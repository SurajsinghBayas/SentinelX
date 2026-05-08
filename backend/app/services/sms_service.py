"""
SMS Threat Analysis Service
Orchestrates SMS-specific scam/phishing detection pipeline.
"""

from __future__ import annotations

from typing import Optional
import uuid

from sqlalchemy.orm import Session

from app.ml.sms_model import sms_model
from app.ml.behavior_model import behavior_model
from app.ml.url_detector import url_detector
from app.ml.risk_engine import risk_engine
from app.ml.sector_threat_model import sector_threat_model
from app.ml.spear_phishing_detector import spear_phishing_detector
from app.database.models.models import Threat, ThreatType, ThreatLevel
from app.schemas.schemas import SMSAnalysisRequest, ThreatAnalysisResponse
from app.core.logging import get_logger

logger = get_logger(__name__)


class SMSService:
    """Coordinates end-to-end SMS threat analysis pipeline."""

    def analyze(
        self,
        request: SMSAnalysisRequest,
        db: Session,
        user_id: Optional[uuid.UUID] = None,
    ) -> ThreatAnalysisResponse:
        """
        Analyze an SMS message for scam/phishing threats.

        Pipeline:
          1. SMS-specific NLP classification (includes SMS pattern boost)
          2. Behavioral analysis
          3. URL extraction and scoring
          4. Sender reputation (phone number reputation)
          5. Risk score computation
          6. DB persistence
        """
        # ── Step 1: SMS NLP Classification ────────────────────────────────
        nlp_label, nlp_score, nlp_confidence = sms_model.classify(request.message)
        sms_reasons = sms_model.get_matched_patterns(request.message)
        logger.info(f"SMS NLP result: label={nlp_label}, score={nlp_score}")

        # ── Step 2: Behavioral Analysis ───────────────────────────────────
        behavior_result = behavior_model.analyze(request.message)

        # ── Step 3: URL Analysis ──────────────────────────────────────────
        extracted_urls, url_score, url_reasons = url_detector.analyze_all(request.message)

        # ── Step 4: Sender Reputation ─────────────────────────────────────
        reputation_score = risk_engine.compute_reputation_score(
            request.sender, channel="sms"
        )

        # ── Step 5: Sector-Specific Threat Analysis ───────────────────────
        user_sector = getattr(current_user, 'sector', 'general') if current_user else 'general'
        sector_result = sector_threat_model.analyze(request.message, str(user_sector))

        # ── Step 6: Spear-Phishing Targeting Analysis ─────────────────────
        operator_name = getattr(current_user, 'name', None) if current_user else None
        spear_result = spear_phishing_detector.analyze(
            text=request.message,
            sender=request.sender,
            known_senders=getattr(request, 'known_senders', None),
            operator_context=getattr(request, 'operator_context', None) or operator_name,
            sector=str(user_sector),
        )

        # ── Step 7: Risk Score ────────────────────────────────────────────
        all_behavior_reasons = behavior_result.reasons + sms_reasons + sector_result.reasons
        risk_result = risk_engine.compute(
            nlp_score=nlp_score,
            behavior_score=behavior_result.behavioral_score + sector_result.sector_score,
            url_score=url_score,
            reputation_score=reputation_score,
            nlp_label=nlp_label,
            nlp_confidence=nlp_confidence,
            behavior_reasons=all_behavior_reasons,
            url_reasons=url_reasons,
            spear_phishing_score=spear_result.spear_phishing_score,
            targeting_indicators=spear_result.targeting_indicators,
        )

        # ── Step 6: Persist Threat ────────────────────────────────────────
        threat = Threat(
            type=ThreatType.sms,
            channel="sms",
            sender=request.sender,
            content=request.message[:2000],
            risk_score=risk_result.risk_score,
            nlp_score=nlp_score,
            behavior_score=behavior_result.behavioral_score,
            url_score=url_score,
            reputation_score=reputation_score,
            threat_level=ThreatLevel[risk_result.threat_level],
            threat_detected=risk_result.threat_detected,
            confidence=risk_result.confidence,
            reasons=risk_result.reasons,
            extracted_urls=extracted_urls,
            classification_label=nlp_label,
            targeting_indicators=spear_result.targeting_indicators,
            sector=str(user_sector),
            spear_phishing_score=spear_result.spear_phishing_score,
            created_by=user_id,
        )
        db.add(threat)
        db.commit()
        db.refresh(threat)

        logger.info(
            f"SMS analysis complete: threat_id={threat.id}, "
            f"risk_score={risk_result.risk_score}, level={risk_result.threat_level}"
        )

        return ThreatAnalysisResponse(
            threat_id=threat.id,
            threat_detected=risk_result.threat_detected,
            risk_score=risk_result.risk_score,
            threat_level=risk_result.threat_level,
            confidence=risk_result.confidence,
            classification_label=nlp_label,
            reasons=risk_result.reasons,
            extracted_urls=extracted_urls,
            nlp_score=nlp_score,
            behavior_score=behavior_result.behavioral_score,
            url_score=url_score,
            reputation_score=reputation_score,
            processing_mode="sync",
        )


sms_service = SMSService()
