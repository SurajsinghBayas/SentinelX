"""
Messaging Channel Threat Analysis Service
Covers WhatsApp, Telegram, Slack, Teams, Signal and similar platforms.
Forwarded messages receive a risk multiplier — chain-forwarding is a hallmark
of messaging-platform phishing campaigns.
"""

from __future__ import annotations

from typing import Optional
import uuid

from sqlalchemy.orm import Session

from app.ml.phishing_model import phishing_model
from app.ml.behavior_model import behavior_model
from app.ml.url_detector import url_detector
from app.ml.risk_engine import risk_engine
from app.ml.sector_threat_model import sector_threat_model
from app.ml.spear_phishing_detector import spear_phishing_detector
from app.database.models.models import Threat, ThreatType, ThreatLevel
from app.schemas.schemas import MessageAnalysisRequest, ThreatAnalysisResponse
from app.core.logging import get_logger

logger = get_logger(__name__)

# Forwarding risk boost: forwarded messages are higher risk
FORWARD_BASE_BOOST   = 15.0
FORWARD_COUNT_BOOST  = 2.0    # per forward hop, capped
FORWARD_COUNT_CAP    = 10.0


class MessagingService:
    """Coordinates end-to-end messaging platform threat analysis pipeline."""

    def analyze(
        self,
        request: MessageAnalysisRequest,
        db: Session,
        current_user=None,
        user_id: Optional[uuid.UUID] = None,
    ) -> ThreatAnalysisResponse:
        """
        Analyze a messaging platform message for phishing/scam threats.

        Pipeline:
          1. NLP classification
          2. Behavioral analysis + forwarding risk boost
          3. URL extraction and scoring
          4. Sender reputation
          5. Sector-specific threat analysis
          6. Spear-phishing targeting analysis
          7. Composite risk scoring
          8. DB persistence
        """
        text = request.message_text

        # ── Step 1: NLP Classification ─────────────────────────────────────
        nlp_label, nlp_score, nlp_confidence = phishing_model.classify(text)
        logger.info(
            f"Messaging NLP result: platform={request.platform}, "
            f"label={nlp_label}, score={nlp_score}"
        )

        # ── Step 2: Behavioral Analysis + Forward Boost ────────────────────
        behavior_result = behavior_model.analyze(text)
        forwarding_boost = 0.0
        forward_reasons = []
        if request.is_forwarded:
            forwarding_boost = FORWARD_BASE_BOOST
            forward_reasons.append(
                f"Message is forwarded — increases deception risk"
            )
            if request.forward_count and request.forward_count > 1:
                count_boost = min(
                    request.forward_count * FORWARD_COUNT_BOOST,
                    FORWARD_COUNT_CAP
                )
                forwarding_boost += count_boost
                forward_reasons.append(
                    f"Forwarded {request.forward_count} times — "
                    f"viral chain-phishing indicator"
                )

        # ── Step 3: URL Analysis ───────────────────────────────────────────
        extracted_urls, url_score, url_reasons = url_detector.analyze_all(text)

        # ── Step 4: Sender Reputation ──────────────────────────────────────
        reputation_score = risk_engine.compute_reputation_score(
            request.sender_id, channel="sms"
        )

        # ── Step 5: Sector-Specific Threat Analysis ────────────────────────
        user_sector = getattr(current_user, 'sector', 'general') if current_user else 'general'
        sector_result = sector_threat_model.analyze(text, str(user_sector))

        # ── Step 6: Spear-Phishing Targeting Analysis ──────────────────────
        operator_name = getattr(current_user, 'name', None) if current_user else None
        display_name = request.sender_display_name or request.sender_id
        spear_result = spear_phishing_detector.analyze(
            text=text,
            sender=display_name,
            known_senders=getattr(request, 'known_senders', None),
            operator_context=getattr(request, 'operator_context', None) or operator_name,
            sector=str(user_sector),
        )

        # ── Step 7: Risk Score ─────────────────────────────────────────────
        all_behavior_reasons = (
            behavior_result.reasons
            + forward_reasons
            + sector_result.reasons
        )
        adjusted_behavior_score = min(
            behavior_result.behavioral_score
            + forwarding_boost
            + sector_result.sector_score,
            100.0,
        )
        risk_result = risk_engine.compute(
            nlp_score=nlp_score,
            behavior_score=adjusted_behavior_score,
            url_score=url_score,
            reputation_score=reputation_score,
            nlp_label=nlp_label,
            nlp_confidence=nlp_confidence,
            behavior_reasons=all_behavior_reasons,
            url_reasons=url_reasons,
            spear_phishing_score=spear_result.spear_phishing_score,
            targeting_indicators=spear_result.targeting_indicators,
        )

        # ── Step 8: Persist Threat ─────────────────────────────────────────
        threat = Threat(
            type=ThreatType.message,
            channel=request.platform,
            sender=display_name,
            content=text[:2000],
            risk_score=risk_result.risk_score,
            nlp_score=nlp_score,
            behavior_score=adjusted_behavior_score,
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
            f"Messaging analysis complete: threat_id={threat.id}, "
            f"platform={request.platform}, risk_score={risk_result.risk_score}, "
            f"level={risk_result.threat_level}"
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
            behavior_score=adjusted_behavior_score,
            url_score=url_score,
            reputation_score=reputation_score,
            spear_phishing_score=spear_result.spear_phishing_score,
            targeting_indicators=spear_result.targeting_indicators,
            sector=str(user_sector),
            is_targeted_attack=spear_result.is_targeted,
            processing_mode="sync",
        )


messaging_service = MessagingService()
