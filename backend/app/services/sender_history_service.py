"""
Sender History Service
Tracks contacts between operators and external senders.
Enables first-contact anomaly detection — the core of spear-phishing targeting.
"""

from __future__ import annotations

from datetime import datetime, timezone
from typing import Optional
import uuid

from sqlalchemy import Column, DateTime, Float, ForeignKey, Integer, String, UniqueConstraint
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import Session

from app.database.base import Base
from app.core.logging import get_logger

logger = get_logger(__name__)


def _utcnow() -> datetime:
    return datetime.now(timezone.utc)


# ─── SenderRecord ORM Model ───────────────────────────────────────────────────

class SenderRecord(Base):
    """
    Tracks the history of contacts between an operator and a sender.

    Built automatically as analysis requests come in — no manual maintenance needed.
    The spear_phishing_detector queries this table to determine first-contact anomalies.
    """
    __tablename__ = "sender_records"

    id            = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id       = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False, index=True)
    sender        = Column(String(255), nullable=False, index=True)
    channel       = Column(String(50), nullable=False)   # email | sms | whatsapp | etc.
    first_seen    = Column(DateTime(timezone=True), default=_utcnow, nullable=False)
    last_seen     = Column(DateTime(timezone=True), default=_utcnow, onupdate=_utcnow, nullable=False)
    message_count = Column(Integer, default=1, nullable=False)
    avg_risk_score = Column(Float, default=0.0, nullable=False)
    flagged       = Column(Integer, default=0, nullable=False)   # number of high-risk detections

    __table_args__ = (
        UniqueConstraint("user_id", "sender", "channel", name="uq_user_sender_channel"),
    )

    def __repr__(self) -> str:
        return (
            f"<SenderRecord user={self.user_id} sender={self.sender} "
            f"channel={self.channel} count={self.message_count}>"
        )


# ─── Sender History Service ───────────────────────────────────────────────────

class SenderHistoryService:
    """
    Manages the sender contact history for each operator.

    Usage:
        # Check before analysis
        is_known = sender_history_service.is_known(user_id, sender, channel, db)

        # Record after analysis (call as background task)
        sender_history_service.record_contact(user_id, sender, channel, risk_score, db)
    """

    def is_known(
        self,
        user_id: uuid.UUID,
        sender: str,
        channel: str,
        db: Session,
    ) -> bool:
        """Return True if this operator has previously received messages from this sender."""
        try:
            record = (
                db.query(SenderRecord)
                .filter(
                    SenderRecord.user_id == user_id,
                    SenderRecord.sender == sender.strip().lower(),
                    SenderRecord.channel == channel,
                )
                .first()
            )
            return record is not None
        except Exception as exc:
            logger.warning(f"SenderHistory.is_known failed: {exc}")
            return False   # fail open — don't block analysis

    def record_contact(
        self,
        user_id: uuid.UUID,
        sender: str,
        channel: str,
        risk_score: float,
        db: Session,
    ) -> None:
        """
        Upsert a sender contact record for this operator.
        Call as a background task after every analysis to keep history current.
        """
        try:
            sender_norm = sender.strip().lower()
            record = (
                db.query(SenderRecord)
                .filter(
                    SenderRecord.user_id == user_id,
                    SenderRecord.sender == sender_norm,
                    SenderRecord.channel == channel,
                )
                .first()
            )
            if record:
                # Update rolling average and counts
                total = record.avg_risk_score * record.message_count + risk_score
                record.message_count += 1
                record.avg_risk_score = round(total / record.message_count, 2)
                record.last_seen = _utcnow()
                if risk_score >= 61:
                    record.flagged += 1
            else:
                record = SenderRecord(
                    user_id=user_id,
                    sender=sender_norm,
                    channel=channel,
                    avg_risk_score=risk_score,
                    flagged=1 if risk_score >= 61 else 0,
                )
                db.add(record)
            db.commit()
            logger.debug(
                f"SenderRecord updated: user={user_id}, sender={sender_norm}, "
                f"channel={channel}, risk={risk_score}"
            )
        except Exception as exc:
            logger.warning(f"SenderHistory.record_contact failed: {exc}")
            db.rollback()

    def get_profile(
        self,
        user_id: uuid.UUID,
        sender: str,
        channel: str,
        db: Session,
    ) -> dict:
        """
        Return a risk profile dict for this sender.
        Used by the /analyze/sender-history API endpoint.
        """
        sender_norm = sender.strip().lower()
        try:
            record = (
                db.query(SenderRecord)
                .filter(
                    SenderRecord.user_id == user_id,
                    SenderRecord.sender == sender_norm,
                    SenderRecord.channel == channel,
                )
                .first()
            )
            if not record:
                return {
                    "is_known": False,
                    "message_count": 0,
                    "avg_risk_score": 0.0,
                    "flagged_count": 0,
                    "first_seen": None,
                    "last_seen": None,
                }
            return {
                "is_known": True,
                "message_count": record.message_count,
                "avg_risk_score": record.avg_risk_score,
                "flagged_count": record.flagged,
                "first_seen": record.first_seen.isoformat() if record.first_seen else None,
                "last_seen": record.last_seen.isoformat() if record.last_seen else None,
            }
        except Exception as exc:
            logger.warning(f"SenderHistory.get_profile failed: {exc}")
            return {"is_known": False, "error": str(exc)}


# ─── Singleton ────────────────────────────────────────────────────────────────
sender_history_service = SenderHistoryService()
