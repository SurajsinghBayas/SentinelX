"""
Sector-Specific Threat Model
Detects terminology used to impersonate legitimate authority communications
within critical infrastructure sectors (power grid, transport, financial, etc.).
"""

from __future__ import annotations

import re
from dataclasses import dataclass, field
from typing import Dict, List

from app.core.logging import get_logger

logger = get_logger(__name__)

# ─── Sector Pattern Definitions ───────────────────────────────────────────────
# Each entry is a list of regex patterns that match terminology an attacker would
# use to impersonate legitimate authority communications in that sector.

SECTOR_PATTERNS: Dict[str, List[str]] = {
    "power_grid": [
        r"\b(SCADA|DCS|HMI|ICS|RTU|PLC|NERC\s*CIP|grid\s+outage|substation)\b",
        r"\b(transmission|distribution|load\s+dispatch|emergency\s+protocol|voltage\s+regulation)\b",
        r"\b(energy\s+regulator|FERC|Ofgem|ministry\s+of\s+power|grid\s+operator)\b",
        r"\b(critical\s+infrastructure\s+alert|grid\s+stability|blackout\s+risk|power\s+disruption)\b",
        r"\b(smart\s+meter|AMI|advanced\s+metering|demand\s+response|peak\s+load)\b",
        r"\b(inverter|transformer|switchgear|protection\s+relay|circuit\s+breaker)\b",
    ],
    "transport": [
        r"\b(ATC|air\s+traffic\s+control|runway|clearance|NOTAM|transponder|squawk)\b",
        r"\b(railway\s+control|signal\s+failure|track\s+authority|ETCS|ERTMS|platform\s+hold)\b",
        r"\b(port\s+authority|vessel\s+traffic\s+service|AIS|maritime\s+alert|berth\s+assignment)\b",
        r"\b(fleet\s+management|dispatch\s+system|incident\s+command|emergency\s+stop)\b",
        r"\b(ICAO|IATA|FAA|DGCA|flight\s+plan|airspace\s+closure|TFR)\b",
        r"\b(rolling\s+stock|shunting|interlocking|level\s+crossing|signalling)\b",
    ],
    "financial": [
        r"\b(SWIFT|wire\s+transfer|correspondent\s+bank|nostro|vostro|BIC\s+code)\b",
        r"\b(RTGS|ACH|interbank|clearing\s+house|payment\s+gateway|settlement)\b",
        r"\b(KYC|AML|compliance\s+officer|regulator\s+notice|SEC|FCA|RBI|SEBI)\b",
        r"\b(market\s+manipulation|insider\s+trading|position\s+limit|margin\s+call)\b",
        r"\b(IBAN|BBAN|routing\s+number|sort\s+code|beneficiary\s+account)\b",
        r"\b(central\s+bank|reserve\s+bank|monetary\s+authority|forex\s+reserve)\b",
    ],
    "telecom": [
        r"\b(BGP|SS7|diameter|roaming\s+agreement|interconnect|IXP|peering)\b",
        r"\b(network\s+operations\s+(centre|center)|NOC|transit\s+provider|backbone)\b",
        r"\b(SIM\s+swap|number\s+portability|MVNO|spectrum\s+license|base\s+station)\b",
        r"\b(Tier\s+1|Tier\s+2|ASN|autonomous\s+system|route\s+hijack|BGP\s+leak)\b",
    ],
    "water": [
        r"\b(SCADA|chlorine\s+level|pumping\s+station|EPA|water\s+authority|dosing)\b",
        r"\b(treatment\s+plant|contamination\s+alert|distribution\s+network|reservoir)\b",
        r"\b(turbidity|pH\s+level|disinfection|filtration\s+system|lift\s+station)\b",
        r"\b(water\s+quality\s+report|Cryptosporidium|E\.?\s*coli|boil\s+water\s+advisory)\b",
    ],
}

# Weight boost when sector terminology is detected in a message
SECTOR_MATCH_WEIGHT = 30.0   # per match, capped
SECTOR_SCORE_CAP = 100.0


@dataclass
class SectorThreatResult:
    sector: str
    sector_score: float
    matched_categories: List[str] = field(default_factory=list)
    reasons: List[str] = field(default_factory=list)


class SectorThreatModel:
    """
    Detects critical-infrastructure-specific terminology in phishing messages.

    When attackers craft spear-phishing emails targeting a power grid operator,
    they will use terms like 'SCADA', 'NERC CIP', or 'substation' to appear
    legitimate. This model flags those patterns and adds them to the risk score.
    """

    def __init__(self) -> None:
        # Pre-compile all patterns
        self._compiled: Dict[str, List[re.Pattern]] = {
            sector: [re.compile(p, re.IGNORECASE) for p in patterns]
            for sector, patterns in SECTOR_PATTERNS.items()
        }

    def analyze(self, text: str, sector: str) -> SectorThreatResult:
        """
        Analyze text for sector-specific authority impersonation patterns.

        Args:
            text:   The message body / combined text to analyze.
            sector: The operator's infrastructure sector (e.g. 'power_grid').

        Returns:
            SectorThreatResult with score and matched patterns.
        """
        result = SectorThreatResult(sector=sector, sector_score=0.0)

        patterns = self._compiled.get(sector, [])
        if not patterns:
            # No sector-specific patterns → no contribution
            return result

        total_matches = 0
        for pattern in patterns:
            if pattern.search(text):
                total_matches += 1

        if total_matches > 0:
            # Diminishing returns: each extra match adds proportionally less
            score = min(total_matches * SECTOR_MATCH_WEIGHT, SECTOR_SCORE_CAP)
            result.sector_score = round(score, 2)
            result.matched_categories.append(sector)
            result.reasons.append(
                f"Critical infrastructure terminology impersonation detected "
                f"({sector.replace('_', ' ')} sector, {total_matches} indicator"
                f"{'s' if total_matches > 1 else ''})"
            )
            logger.info(
                f"Sector threat detected: sector={sector}, matches={total_matches}, "
                f"score={result.sector_score}"
            )

        return result


# ─── Singleton ────────────────────────────────────────────────────────────────
sector_threat_model = SectorThreatModel()
