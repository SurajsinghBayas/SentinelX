// ============================================================
// SentinelX — Threat & Analysis Data Models
// Mirrors backend ThreatAnalysisResponse, ThreatSummary schemas.
// ============================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'threat_models.freezed.dart';
part 'threat_models.g.dart';

// ── Threat Analysis Response (from POST /analyze/*) ───────────────────────────

@freezed
class ThreatAnalysisResponse with _$ThreatAnalysisResponse {
  const factory ThreatAnalysisResponse({
    @JsonKey(name: 'threat_id') String? threatId,
    @JsonKey(name: 'threat_detected') required bool threatDetected,
    @JsonKey(name: 'risk_score') required double riskScore,
    @JsonKey(name: 'threat_level') required String threatLevel,
    required double confidence,
    @JsonKey(name: 'classification_label') required String classificationLabel,
    required List<String> reasons,
    @JsonKey(name: 'extracted_urls') @Default([]) List<String> extractedUrls,
    @JsonKey(name: 'nlp_score') required double nlpScore,
    @JsonKey(name: 'behavior_score') required double behaviorScore,
    @JsonKey(name: 'url_score') required double urlScore,
    @JsonKey(name: 'reputation_score') required double reputationScore,
    @JsonKey(name: 'processing_mode') @Default('sync') String processingMode,
    @JsonKey(name: 'task_id') String? taskId,
  }) = _ThreatAnalysisResponse;

  factory ThreatAnalysisResponse.fromJson(Map<String, dynamic> json) =>
      _$ThreatAnalysisResponseFromJson(json);
}

// ── Threat Summary (from GET /dashboard/threats) ──────────────────────────────

@freezed
class ThreatSummary with _$ThreatSummary {
  const factory ThreatSummary({
    required String id,
    required String type,
    required String channel,
    @JsonKey(name: 'risk_score') required double riskScore,
    @JsonKey(name: 'threat_level') required String threatLevel,
    @JsonKey(name: 'threat_detected') required bool threatDetected,
    String? sender,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _ThreatSummary;

  factory ThreatSummary.fromJson(Map<String, dynamic> json) =>
      _$ThreatSummaryFromJson(json);
}

// ── Threat List Response ──────────────────────────────────────────────────────

@freezed
class ThreatListResponse with _$ThreatListResponse {
  const factory ThreatListResponse({
    required int total,
    required List<ThreatSummary> threats,
  }) = _ThreatListResponse;

  factory ThreatListResponse.fromJson(Map<String, dynamic> json) =>
      _$ThreatListResponseFromJson(json);
}

// ── SMS Analysis Request ──────────────────────────────────────────────────────

@freezed
class SmsAnalysisRequest with _$SmsAnalysisRequest {
  const factory SmsAnalysisRequest({
    required String sender,
    required String message,
    @JsonKey(name: 'async_processing') @Default(false) bool asyncProcessing,
  }) = _SmsAnalysisRequest;

  factory SmsAnalysisRequest.fromJson(Map<String, dynamic> json) =>
      _$SmsAnalysisRequestFromJson(json);
}

// ── Call Analysis Request ─────────────────────────────────────────────────────

@freezed
class CallAnalysisRequest with _$CallAnalysisRequest {
  const factory CallAnalysisRequest({
    required String transcript,
    @JsonKey(name: 'caller_id') String? callerId,
    @JsonKey(name: 'duration_seconds') int? durationSeconds,
  }) = _CallAnalysisRequest;

  factory CallAnalysisRequest.fromJson(Map<String, dynamic> json) =>
      _$CallAnalysisRequestFromJson(json);
}

// ── Email Analysis Request ────────────────────────────────────────────────────

@freezed
class EmailAnalysisRequest with _$EmailAnalysisRequest {
  const factory EmailAnalysisRequest({
    required String sender,
    required String subject,
    required String body,
    @Default([]) List<String> attachments,
    @JsonKey(name: 'async_processing') @Default(false) bool asyncProcessing,
  }) = _EmailAnalysisRequest;

  factory EmailAnalysisRequest.fromJson(Map<String, dynamic> json) =>
      _$EmailAnalysisRequestFromJson(json);
}

// ── Local SMS Event (captured on device, not yet sent) ───────────────────────

@freezed
class SmsEvent with _$SmsEvent {
  const factory SmsEvent({
    required String id,
    required String sender,
    required String message,
    required DateTime timestamp,
    @Default(false) bool sentToBackend,
    ThreatAnalysisResponse? analysisResult,
  }) = _SmsEvent;

  factory SmsEvent.fromJson(Map<String, dynamic> json) =>
      _$SmsEventFromJson(json);
}

// ── Local Call Event ──────────────────────────────────────────────────────────

@freezed
class CallEvent with _$CallEvent {
  const factory CallEvent({
    required String id,
    required String callerId,
    required String state,
    required DateTime timestamp,
    int? durationSeconds,
    String? transcript,
    @Default(false) bool sentToBackend,
    ThreatAnalysisResponse? analysisResult,
  }) = _CallEvent;

  factory CallEvent.fromJson(Map<String, dynamic> json) =>
      _$CallEventFromJson(json);
}

// ── Notification Event ────────────────────────────────────────────────────────

@freezed
class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent({
    required String id,
    required String packageName,
    required String appName,
    String? title,
    String? body,
    required DateTime timestamp,
    @Default(false) bool sentToBackend,
    ThreatAnalysisResponse? analysisResult,
  }) = _NotificationEvent;

  factory NotificationEvent.fromJson(Map<String, dynamic> json) =>
      _$NotificationEventFromJson(json);
}
