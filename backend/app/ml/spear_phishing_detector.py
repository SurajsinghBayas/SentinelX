"""
Spear-Phishing Detector
Identifies signals that distinguish targeted (spear-phishing) attacks from
generic phishing campaigns — the key requirement of the problem statement.

Targeted attacks are characterised by:
  1. Operator personalisation (name, title, department referenced)
  2. First-contact anomaly (sender never seen before by this operator)
  3. Executive / authority chain impersonation (CEO, regulator, etc.)
  4. Urgency + secrecy combination (classic social engineering)
  5. Sector-context baiting (already handled by SectorThreatModel)
"""

from __future__ import annotations

import re
from dataclasses import dataclass, field
from typing import List, Optional

from app.core.logging import get_logger

logger = get_logger(__name__)


# ─── Executive / authority impersonation patterns ─────────────────────────────
EXECUTIVE_PATTERNS = re.compile(
    r"\b(CEO|CFO|COO|CTO|CISO|CMO|board\s+of\s+directors|chairman|chairwoman|"
    r"director\s+general|secretary\s+of\s+state|minister|commissioner|"
    r"inspector\s+general|chief\s+of\s+staff|vice\s+president|managing\s+director)\b",
    re.IGNORECASE,
)

# ─── Secrecy / do-not-discuss patterns ───────────────────────────────────────
SECRECY_PATTERNS = re.compile(
    r"\b(keep\s+(this\s+)?(confidential|secret|private|between\s+us)|"
    r"do\s+not\s+(share|forward|discuss|tell)|strictly\s+confidential|"
    r"for\s+your\s+eyes\s+only|classified|do\s+not\s+reply\s+to\s+anyone)\b",
    re.IGNORECASE,
)

# ─── Urgency + action demand patterns ────────────────────────────────────────
URGENCY_ACTION_PATTERNS = re.compile(
    r"\b(respond\s+within|reply\s+immediately|action\s+required\s+now|"
    r"before\s+(close\s+of\s+business|end\s+of\s+day|COB|EOD)|"
    r"within\s+the\s+next\s+\d+\s+(minutes?|hours?)|no\s+later\s+than\s+today)\b",
    re.IGNORECASE,
)

# ─── Sender spoofing pattern (display-name mismatch indicator in text) ────────
IMPERSONATION_PATTERNS = re.compile(
    r"\b(on\s+behalf\s+of|this\s+message\s+is\s+from|sent\s+by\s+order\s+of|"
    r"as\s+directed\s+by|acting\s+on\s+instructions\s+from)\b",
    re.IGNORECASE,
)


@dataclass
class SpearPhishingResult:
    spear_phishing_score: float
    targeting_indicators: List[str] = field(default_factory=list)
    is_targeted: bool = False


class SpearPhishingDetector:
    """
    Scores messages for spear-phishing targeting signals.

    Unlike the generic PhishingModel which looks for broad phishing language,
    this detector looks for evidence that the attack was CRAFTED FOR this
    specific operator — the hallmark of spear-phishing.
    """

    # Score contributions per signal
    SCORE_PERSONALISATION   = 35.0   # operator name/role referenced
    SCORE_FIRST_CONTACT     = 25.0   # sender never seen before
    SCORE_EXECUTIVE         = 20.0   # CEO/regulator impersonation
    SCORE_SECRECY           = 15.0   # "keep this confidential" etc.
    SCORE_URGENCY_ACTION    = 10.0   # tight deadline demand
    SCORE_IMPERSONATION_CUE = 15.0   # "sent on behalf of" etc.
    SPEAR_PHISHING_THRESHOLD = 40.0  # above this = targeted attack

    def analyze(
        self,
        text: str,
        sender: str,
        known_senders: Optional[List[str]] = None,
        operator_context: Optional[str] = None,
        sector: str = "general",
    ) -> SpearPhishingResult:
        """
        Analyze a message for spear-phishing targeting signals.

        Args:
            text:             Combined message text (subject + body).
            sender:           The sender's email/phone/ID.
            known_senders:    Whitelist of senders the operator regularly contacts.
            operator_context: Free-text context: operator's name, title, organisation.
            sector:           The operator's infrastructure sector.

        Returns:
            SpearPhishingResult with score (0-100) and list of targeting indicators.
        """
        score = 0.0
        indicators: List[str] = []
        text_lower = text.lower()

        # ── Signal 1: Operator personalisation ──────────────────────────────
        if operator_context:
            tokens = [
                w for w in operator_context.split()
                if len(w) > 3 and w.lower() not in {
                    "the", "and", "for", "with", "from", "operator", "engineer"
                }
            ]
            matched_tokens = [t for t in tokens if t.lower() in text_lower]
            if matched_tokens:
                score += self.SCORE_PERSONALISATION
                indicators.append(
                    f"Message references operator-specific context: "
                    f"{', '.join(matched_tokens[:3])}"
                )

        # ── Signal 2: First-contact anomaly ─────────────────────────────────
        if known_senders is not None and len(known_senders) > 0:
            # Normalise for comparison
            sender_norm = sender.strip().lower()
            known_norm  = [s.strip().lower() for s in known_senders]
            if sender_norm not in known_norm:
                score += self.SCORE_FIRST_CONTACT
                indicators.append(
                    f"First contact from unknown sender: '{sender}' — "
                    f"not in operator's known contacts"
                )

        # ── Signal 3: Executive / authority chain impersonation ──────────────
        if EXECUTIVE_PATTERNS.search(text):
            score += self.SCORE_EXECUTIVE
            indicators.append(
                "Executive or government authority impersonation detected "
                "(CEO/CFO/Director/Regulator reference)"
            )

        # ── Signal 4: Secrecy / do-not-forward instruction ───────────────────
        if SECRECY_PATTERNS.search(text):
            score += self.SCORE_SECRECY
            indicators.append(
                "Secrecy instruction detected — attacker attempting to prevent "
                "victim from seeking verification"
            )

        # ── Signal 5: Tight deadline / urgency action demand ─────────────────
        if URGENCY_ACTION_PATTERNS.search(text):
            score += self.SCORE_URGENCY_ACTION
            indicators.append(
                "Tight action deadline detected — pressuring operator to act "
                "without verification"
            )

        # ── Signal 6: Explicit impersonation cue in body ─────────────────────
        if IMPERSONATION_PATTERNS.search(text):
            score += self.SCORE_IMPERSONATION_CUE
            indicators.append(
                "Delegation/authority chain language detected "
                "('on behalf of', 'as directed by') — common in BEC attacks"
            )

        score = round(min(score, 100.0), 2)
        is_targeted = score >= self.SPEAR_PHISHING_THRESHOLD

        if is_targeted:
            logger.warning(
                f"Spear-phishing detected: score={score}, sender={sender}, "
                f"sector={sector}, indicators={len(indicators)}"
            )
        else:
            logger.debug(f"Spear-phishing check: score={score}, sender={sender}")

        return SpearPhishingResult(
            spear_phishing_score=score,
            targeting_indicators=indicators,
            is_targeted=is_targeted,
        )


# ─── Singleton ────────────────────────────────────────────────────────────────
spear_phishing_detector = SpearPhishingDetector()
