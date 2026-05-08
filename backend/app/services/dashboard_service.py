"""
Dashboard Analytics Service
Provides aggregated statistics and trend data for the frontend dashboard.
"""

from __future__ import annotations

from datetime import datetime, timedelta, timezone
from typing import List

from sqlalchemy import func, desc
from sqlalchemy.orm import Session

from app.database.models.models import Alert, Threat, ThreatLevel, AlertSeverity
from app.schemas.schemas import (
    DashboardStats,
    ThreatSummary,
    ThreatListResponse,
    ThreatTrend,
    DashboardTrends,
)
from app.core.logging import get_logger

logger = get_logger(__name__)


class DashboardService:
    """Aggregation queries for dashboard analytics endpoints."""

    def get_stats(self, db: Session) -> DashboardStats:
        """Return high-level KPI statistics."""
        today_start = datetime.now(timezone.utc).replace(
            hour=0, minute=0, second=0, microsecond=0
        )

        total_threats = db.query(Threat).count()
        phishing_attempts = (
            db.query(Threat)
            .filter(Threat.classification_label.in_(["phishing", "credential_theft"]))
            .count()
        )
        high_risk_alerts = (
            db.query(Alert)
            .filter(Alert.severity.in_([AlertSeverity.high, AlertSeverity.critical]))
            .count()
        )
        critical_alerts = (
            db.query(Alert)
            .filter(Alert.severity == AlertSeverity.critical)
            .count()
        )
        threats_today = (
            db.query(Threat).filter(Threat.created_at >= today_start).count()
        )
        avg_risk = (
            db.query(func.avg(Threat.risk_score)).scalar() or 0.0
        )
        unacknowledged = (
            db.query(Alert).filter(Alert.acknowledged == False).count()
        )

        return DashboardStats(
            total_threats=total_threats,
            phishing_attempts=phishing_attempts,
            high_risk_alerts=high_risk_alerts,
            critical_alerts=critical_alerts,
            threats_today=threats_today,
            avg_risk_score=round(float(avg_risk), 2),
            unacknowledged_alerts=unacknowledged,
        )

    def get_recent_threats(
        self, db: Session, skip: int = 0, limit: int = 50
    ) -> ThreatListResponse:
        """Return paginated recent threats."""
        total = db.query(Threat).count()
        threats = (
            db.query(Threat)
            .order_by(desc(Threat.created_at))
            .offset(skip)
            .limit(limit)
            .all()
        )
        return ThreatListResponse(
            total=total,
            threats=[ThreatSummary.model_validate(t) for t in threats],
        )

    def get_trends(self, db: Session, days: int = 7) -> DashboardTrends:
        """
        Return daily threat counts and average risk scores per channel
        over the past N days.
        """
        since = datetime.now(timezone.utc) - timedelta(days=days)

        # Use SQLAlchemy's date truncation (PostgreSQL cast to date)
        rows = (
            db.query(
                func.cast(Threat.created_at, func.Date).label("date"),
                Threat.channel,
                func.count(Threat.id).label("count"),
                func.avg(Threat.risk_score).label("avg_score"),
            )
            .filter(Threat.created_at >= since)
            .group_by("date", Threat.channel)
            .order_by("date")
            .all()
        )

        trends: List[ThreatTrend] = []
        for row in rows:
            trends.append(
                ThreatTrend(
                    date=str(row.date),
                    count=row.count,
                    avg_risk_score=round(float(row.avg_score or 0), 2),
                    channel=row.channel,
                )
            )

        return DashboardTrends(trends=trends, period_days=days)


dashboard_service = DashboardService()
