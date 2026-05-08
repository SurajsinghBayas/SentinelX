"""
Threat Analysis Routes
POST /analyze/email   — Analyze email for phishing
POST /analyze/sms     — Analyze SMS for scams
POST /analyze/call    — Analyze call transcript
POST /transcribe/audio — Transcribe audio file via Whisper
"""

from __future__ import annotations

from fastapi import APIRouter, Depends, HTTPException, UploadFile, File, status, BackgroundTasks
from sqlalchemy.orm import Session

from app.database.session import get_db
from app.database.models.models import User, Threat
from app.api.dependencies.auth import get_current_user
from app.services.email_service import email_service
from app.services.sms_service import sms_service
from app.services.call_service import call_service
from app.services.alert_service import alert_service
from app.services.messaging_service import messaging_service
from app.services.sender_history_service import sender_history_service
from app.schemas.schemas import (
    EmailAnalysisRequest,
    SMSAnalysisRequest,
    CallAnalysisRequest,
    MessageAnalysisRequest,
    ThreatAnalysisResponse,
    TranscriptionResponse,
)
from app.core.logging import get_logger

logger = get_logger(__name__)

router = APIRouter(tags=["Threat Analysis"])

# ─── Email Analysis ───────────────────────────────────────────────────────────

@router.post(
    "/analyze/email",
    response_model=ThreatAnalysisResponse,
    summary="Analyze an email for phishing and social engineering threats",
)
def analyze_email(
    request: EmailAnalysisRequest,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
) -> ThreatAnalysisResponse:
    """
    Synchronous (or async via `async_processing=true`) email threat analysis.

    Returns a comprehensive threat report including NLP classification,
    behavioral indicators, URL risk, and a composite risk score.
    """
    if request.async_processing:
        from app.workers.celery_worker import analyze_email_task
        task = analyze_email_task.apply_async(
            kwargs={
                "sender": request.sender,
                "subject": request.subject,
                "body": request.body,
                "user_id": str(current_user.id),
            }
        )
        return ThreatAnalysisResponse(
            threat_detected=False,
            risk_score=0.0,
            threat_level="PENDING",
            confidence=0.0,
            classification_label="pending",
            reasons=[],
            nlp_score=0.0,
            behavior_score=0.0,
            url_score=0.0,
            reputation_score=0.0,
            processing_mode="async",
            task_id=task.id,
        )

    result = email_service.analyze(request, db, user_id=current_user.id)

    # Auto-create alert in background if threshold exceeded
    if result.threat_id:
        threat = db.query(Threat).filter(Threat.id == result.threat_id).first()
        if threat:
            background_tasks.add_task(alert_service.maybe_create_alert, threat, db)

    # Record sender contact for future first-contact anomaly detection
    background_tasks.add_task(
        sender_history_service.record_contact,
        current_user.id, request.sender, "email", result.risk_score, db
    )

    return result


# ─── SMS Analysis ─────────────────────────────────────────────────────────────

@router.post(
    "/analyze/sms",
    response_model=ThreatAnalysisResponse,
    summary="Analyze an SMS message for scam and phishing threats",
)
def analyze_sms(
    request: SMSAnalysisRequest,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
) -> ThreatAnalysisResponse:
    """Detect OTP fraud, prize scams, and malicious links in SMS messages."""
    if request.async_processing:
        from app.workers.celery_worker import analyze_sms_task
        task = analyze_sms_task.apply_async(
            kwargs={
                "sender": request.sender,
                "message": request.message,
                "user_id": str(current_user.id),
            }
        )
        return ThreatAnalysisResponse(
            threat_detected=False,
            risk_score=0.0,
            threat_level="PENDING",
            confidence=0.0,
            classification_label="pending",
            reasons=[],
            nlp_score=0.0,
            behavior_score=0.0,
            url_score=0.0,
            reputation_score=0.0,
            processing_mode="async",
            task_id=task.id,
        )

    result = sms_service.analyze(request, db, user_id=current_user.id)

    if result.threat_id:
        threat = db.query(Threat).filter(Threat.id == result.threat_id).first()
        if threat:
            background_tasks.add_task(alert_service.maybe_create_alert, threat, db)

    return result


# ─── Call Transcript Analysis ─────────────────────────────────────────────────

@router.post(
    "/analyze/call",
    response_model=ThreatAnalysisResponse,
    summary="Analyze a phone call transcript for scam patterns",
)
def analyze_call(
    request: CallAnalysisRequest,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
) -> ThreatAnalysisResponse:
    """Detect social engineering and scam patterns in call transcripts."""
    result = call_service.analyze_transcript(request, db, user_id=current_user.id)

    if result.threat_id:
        threat = db.query(Threat).filter(Threat.id == result.threat_id).first()
        if threat:
            background_tasks.add_task(alert_service.maybe_create_alert, threat, db)

    return result


# ─── Messaging Platform Analysis ───────────────────────────────────────────────

@router.post(
    "/analyze/message",
    response_model=ThreatAnalysisResponse,
    summary="Analyze a messaging platform message (WhatsApp, Telegram, Slack, Teams)",
)
def analyze_message(
    request: MessageAnalysisRequest,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
) -> ThreatAnalysisResponse:
    """
    Detect phishing and social engineering in messaging platform messages.

    Supports WhatsApp, Telegram, Slack, Teams, Signal, and other platforms.
    Chain-forwarded messages receive a risk multiplier as they are a common
    vector for viral phishing campaigns targeting infrastructure operators.
    """
    result = messaging_service.analyze(
        request,
        db,
        current_user=current_user,
        user_id=current_user.id,
    )

    if result.threat_id:
        threat = db.query(Threat).filter(Threat.id == result.threat_id).first()
        if threat:
            background_tasks.add_task(alert_service.maybe_create_alert, threat, db)

    return result


# ─── Audio Transcription ──────────────────────────────────────────────────────

@router.post(
    "/transcribe/audio",
    response_model=TranscriptionResponse,
    summary="Transcribe an audio file using OpenAI Whisper",
)
async def transcribe_audio(
    file: UploadFile = File(..., description="Audio file (wav, mp3, m4a, flac)"),
    current_user: User = Depends(get_current_user),
) -> TranscriptionResponse:
    """
    Upload an audio file and receive a text transcript.

    Supported formats: WAV, MP3, M4A, FLAC, OGG, WebM.
    Max file size: 25 MB.
    """
    MAX_SIZE = 25 * 1024 * 1024  # 25 MB

    audio_bytes = await file.read()
    if len(audio_bytes) > MAX_SIZE:
        raise HTTPException(
            status_code=status.HTTP_413_REQUEST_ENTITY_TOO_LARGE,
            detail="Audio file exceeds the 25 MB limit.",
        )

    try:
        return await call_service.transcribe_audio(audio_bytes, file.filename or "audio.wav")
    except RuntimeError as exc:
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail=str(exc),
        )


# ─── Sender History ───────────────────────────────────────────────────────────

@router.get(
    "/analyze/sender-history",
    summary="Get risk profile for a specific sender",
    tags=["Threat Analysis"],
)
def get_sender_history(
    sender: str,
    channel: str = "email",
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
) -> dict:
    """
    Return the contact history and risk profile for a specific sender.

    Use this to surface 'First contact from this sender' warnings in the UI
    before the operator opens or acts on a suspicious message.
    """
    return sender_history_service.get_profile(
        user_id=current_user.id,
        sender=sender,
        channel=channel,
        db=db,
    )
