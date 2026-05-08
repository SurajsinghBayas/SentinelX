"""
Risk Scoring Engine
Combines NLP, behavioral, URL, and reputation scores into a final risk score.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import List, Optional

from app.core.config import settings
from app.core.logging import get_logger

logger = get_logger(__name__)


@dataclass
class RiskScoreResult:
    risk_score: float          # 0–100 composite score
    threat_level: str          # LOW | MEDIUM | HIGH | CRITICAL
    threat_detected: bool
    confidence: float          # 0–1
    classification_label: str
    reasons: List[str]
    nlp_score: float
    behavior_score: float
    url_score: float
    reputation_score: float
    spear_phishing_score: float  # 0–100, new in PS alignment
    targeting_indicators: List[str]  # spear-phishing signal descriptions
    explanation: str


class RiskEngine:
    """
    Weighted risk scoring engine.

    Formula:
        RiskScore = 0.30 * NLPScore
                  + 0.20 * BehaviorScore
                  + 0.20 * URLScore
                  + 0.15 * ReputationScore
                  + 0.15 * SpearPhishingScore   ← NEW

    Threat Levels:
        0–30   → LOW
        31–60  → MEDIUM
        61–85  → HIGH
        86–100 → CRITICAL
    """

    def compute(
        self,
        nlp_score: float,
        behavior_score: float,
        url_score: float,
        reputation_score: float,
        nlp_label: str,
        nlp_confidence: float,
        behavior_reasons: List[str],
        url_reasons: List[str],
        spear_phishing_score: float = 0.0,
        targeting_indicators: Optional[List[str]] = None,
    ) -> RiskScoreResult:
        """
        Compute composite risk score and classify threat level.

        Args:
            nlp_score:        NLP classification score (0–100)
            behavior_score:   Behavioral analysis score (0–100)
            url_score:        URL threat heuristic score (0–100)
            reputation_score: Sender/domain reputation score (0–100)
            nlp_label:        Top classification label from NLP model
            nlp_confidence:   Confidence of NLP classification (0–1)
            behavior_reasons: List of behavioral threat reasons
            url_reasons:      List of URL threat reasons

        Returns:
            RiskScoreResult with all fields populated
        """
        # Weighted composite score
        risk_score = round(
            settings.WEIGHT_NLP * nlp_score
            + settings.WEIGHT_BEHAVIOR * behavior_score
            + settings.WEIGHT_URL * url_score
            + settings.WEIGHT_REPUTATION * reputation_score
            + 0.15 * spear_phishing_score,
            2,
        )
        risk_score = max(0.0, min(risk_score, 100.0))

        # Threat level classification
        threat_level = self._classify_level(risk_score)
        threat_detected = risk_score >= settings.ALERT_TRIGGER_THRESHOLD

        # Combined confidence (weighted average)
        confidence = round(
            (nlp_confidence * 0.5)
            + (min(behavior_score / 100, 1.0) * 0.3)
            + (min(url_score / 100, 1.0) * 0.2),
            4,
        )

        # Merge reasons
        all_reasons: List[str] = []
        if nlp_label != "safe":
            all_reasons.append(f"NLP classified as '{nlp_label}' (score: {nlp_score:.1f})")
        all_reasons.extend(behavior_reasons)
        all_reasons.extend(url_reasons)
        if targeting_indicators:
            all_reasons.extend(targeting_indicators)

        # Human-readable explanation
        explanation = self._generate_explanation(
            risk_score, threat_level, nlp_label, behavior_score,
            url_score, reputation_score, spear_phishing_score
        )

        return RiskScoreResult(
            risk_score=risk_score,
            threat_level=threat_level,
            threat_detected=threat_detected,
            confidence=confidence,
            classification_label=nlp_label,
            reasons=all_reasons,
            nlp_score=nlp_score,
            behavior_score=behavior_score,
            url_score=url_score,
            reputation_score=reputation_score,
            spear_phishing_score=spear_phishing_score,
            targeting_indicators=targeting_indicators or [],
            explanation=explanation,
        )

    @staticmethod
    def _classify_level(score: float) -> str:
        if score <= settings.RISK_THRESHOLD_LOW:
            return "LOW"
        elif score <= settings.RISK_THRESHOLD_MEDIUM:
            return "MEDIUM"
        elif score <= settings.RISK_THRESHOLD_HIGH:
            return "HIGH"
        else:
            return "CRITICAL"

    @staticmethod
    def _generate_explanation(
        risk_score: float,
        threat_level: str,
        nlp_label: str,
        behavior_score: float,
        url_score: float,
        reputation_score: float,
        spear_phishing_score: float = 0.0,
    ) -> str:
        parts = [
            f"Overall risk score: {risk_score:.1f}/100 ({threat_level}).",
        ]
        if nlp_label != "safe":
            parts.append(f"NLP model identified content as '{nlp_label}'.")
        if behavior_score > 30:
            parts.append(f"Behavioral analysis detected social engineering indicators (score: {behavior_score:.1f}).")
        if url_score > 20:
            parts.append(f"Suspicious URL patterns found (score: {url_score:.1f}).")
        if reputation_score > 40:
            parts.append(f"Sender reputation is poor (score: {reputation_score:.1f}).")
        if spear_phishing_score >= 40:
            parts.append(
                f"\u26a0\ufe0f TARGETED ATTACK DETECTED: Spear-phishing indicators present "
                f"(score: {spear_phishing_score:.1f}). This message shows signs of being "
                f"crafted specifically for this operator."
            )
        return " ".join(parts)

    def compute_reputation_score(self, sender: str, channel: str = "email") -> float:
        """
        Simple heuristic reputation scorer for sender identity.

        In production, integrate with threat intelligence feeds or
        domain reputation APIs. Returns 0–100 (higher = more suspicious).
        """
        import re

        score = 0.0

        if channel == "email":
            # Disposable / free email domains
            disposable = {
                "tempmail.com", "guerrillamail.com", "mailinator.com",
                "throwaway.email", "yopmail.com", "sharklasers.com",
            }
            domain_match = re.search(r"@([\w.-]+)", sender)
            if domain_match:
                domain = domain_match.group(1).lower()
                if domain in disposable:
                    score += 60.0
                # Random-looking local part (many numbers or long random string)
                local = sender.split("@")[0]
                digit_ratio = sum(c.isdigit() for c in local) / max(len(local), 1)
                if digit_ratio > 0.5:
                    score += 20.0
                if len(local) > 20:
                    score += 10.0

        elif channel == "sms":
            # Short code or premium rate numbers
            if re.match(r"^\+?[89]\d{9,}$", sender):
                score += 30.0

        return round(min(score, 100.0), 2)


risk_engine = RiskEngine()
