"""
Pydantic Schemas
Request/response models for all API endpoints.
"""

from __future__ import annotations

import uuid
from datetime import datetime
from typing import List, Optional

from pydantic import BaseModel, EmailStr, Field, field_validator


# ──────────────────────────────────────────────────────────────────────────────
# Auth Schemas
# ──────────────────────────────────────────────────────────────────────────────

class UserRegisterRequest(BaseModel):
    name: str = Field(..., min_length=2, max_length=255)
    email: EmailStr
    password: str = Field(..., min_length=8, max_length=128)
    role: str = Field(default="operator", pattern="^(admin|operator)$")
    sector: str = Field(
        default="general",
        pattern="^(power_grid|transport|financial|telecom|water|general)$",
        description="Infrastructure sector of the operator",
    )


class UserLoginRequest(BaseModel):
    email: EmailStr
    password: str


class TokenResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"
    expires_in: int  # seconds


class UserResponse(BaseModel):
    id: uuid.UUID
    name: str
    email: EmailStr
    role: str
    sector: str
    is_active: bool
    created_at: datetime

    model_config = {"from_attributes": True}


# ──────────────────────────────────────────────────────────────────────────────
# Email Analysis Schemas
# ──────────────────────────────────────────────────────────────────────────────

class EmailAnalysisRequest(BaseModel):
    sender: str = Field(..., max_length=255)
    subject: str = Field(..., max_length=1000)
    body: str = Field(..., max_length=50_000)
    attachments: Optional[List[str]] = Field(default=None, description="Attachment filenames")
    operator_context: Optional[str] = Field(
        default=None,
        max_length=500,
        description="Operator's name, title, or role context for spear-phishing detection",
    )
    known_senders: Optional[List[str]] = Field(
        default=None,
        description="Email addresses the operator regularly receives mail from",
    )
    async_processing: bool = Field(default=False, description="Process via Celery task queue")


# ──────────────────────────────────────────────────────────────────────────────
# SMS Analysis Schemas
# ──────────────────────────────────────────────────────────────────────────────

class SMSAnalysisRequest(BaseModel):
    sender: str = Field(..., max_length=50)
    message: str = Field(..., max_length=5000)
    operator_context: Optional[str] = Field(default=None, max_length=500)
    known_senders: Optional[List[str]] = Field(default=None)
    async_processing: bool = False


# ──────────────────────────────────────────────────────────────────────────────
# Call / Audio Analysis Schemas
# ──────────────────────────────────────────────────────────────────────────────

class CallAnalysisRequest(BaseModel):
    transcript: str = Field(..., max_length=100_000)
    caller_id: Optional[str] = Field(default=None, max_length=50)
    duration_seconds: Optional[int] = None


class MessageAnalysisRequest(BaseModel):
    """Request schema for messaging platform threat analysis."""
    platform: str = Field(
        ...,
        pattern="^(whatsapp|telegram|slack|teams|signal|other)$",
        description="Source messaging platform",
    )
    sender_id: str = Field(..., max_length=255, description="Sender ID or phone number")
    sender_display_name: Optional[str] = Field(default=None, max_length=255)
    message_text: str = Field(..., max_length=10_000)
    is_forwarded: bool = Field(default=False, description="Whether message was forwarded")
    forward_count: Optional[int] = Field(
        default=None,
        ge=0,
        description="Number of times the message was forwarded (chain-forward indicator)",
    )
    operator_context: Optional[str] = Field(default=None, max_length=500)
    known_senders: Optional[List[str]] = Field(default=None)
    async_processing: bool = False


class TranscriptionResponse(BaseModel):
    transcript: str
    language: Optional[str] = None
    duration_seconds: Optional[float] = None


# ──────────────────────────────────────────────────────────────────────────────
# Threat Analysis Response (shared)
# ──────────────────────────────────────────────────────────────────────────────

class ThreatAnalysisResponse(BaseModel):
    threat_id: Optional[uuid.UUID] = None
    threat_detected: bool
    risk_score: float = Field(..., ge=0, le=100)
    threat_level: str
    confidence: float = Field(..., ge=0, le=1)
    classification_label: str
    reasons: List[str]
    extracted_urls: List[str] = []
    nlp_score: float
    behavior_score: float
    url_score: float
    reputation_score: float
    spear_phishing_score: float = 0.0
    targeting_indicators: List[str] = []
    sector: Optional[str] = None
    is_targeted_attack: bool = False
    processing_mode: str = "sync"
    task_id: Optional[str] = None


# ──────────────────────────────────────────────────────────────────────────────
# Alert Schemas
# ──────────────────────────────────────────────────────────────────────────────

class AlertResponse(BaseModel):
    id: uuid.UUID
    threat_id: uuid.UUID
    severity: str
    title: str
    description: Optional[str]
    acknowledged: bool
    acknowledged_at: Optional[datetime]
    created_at: datetime

    model_config = {"from_attributes": True}


class AlertListResponse(BaseModel):
    total: int
    alerts: List[AlertResponse]


class AcknowledgeAlertResponse(BaseModel):
    id: uuid.UUID
    acknowledged: bool
    acknowledged_at: datetime


# ──────────────────────────────────────────────────────────────────────────────
# Dashboard Schemas
# ──────────────────────────────────────────────────────────────────────────────

class DashboardStats(BaseModel):
    total_threats: int
    phishing_attempts: int
    high_risk_alerts: int
    critical_alerts: int
    threats_today: int
    avg_risk_score: float
    unacknowledged_alerts: int


class ThreatSummary(BaseModel):
    id: uuid.UUID
    type: str
    channel: str
    risk_score: float
    threat_level: str
    threat_detected: bool
    sender: Optional[str]
    created_at: datetime

    model_config = {"from_attributes": True}


class ThreatListResponse(BaseModel):
    total: int
    threats: List[ThreatSummary]


class ThreatTrend(BaseModel):
    date: str
    count: int
    avg_risk_score: float
    channel: str


class DashboardTrends(BaseModel):
    trends: List[ThreatTrend]
    period_days: int


# ──────────────────────────────────────────────────────────────────────────────
# Generic API Responses
# ──────────────────────────────────────────────────────────────────────────────

class SuccessResponse(BaseModel):
    success: bool = True
    message: str


class ErrorResponse(BaseModel):
    success: bool = False
    error: str
    detail: Optional[str] = None
