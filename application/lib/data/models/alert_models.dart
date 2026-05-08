// ============================================================
// SentinelX — Alert Data Models
// Mirrors backend AlertResponse, AlertListResponse schemas.
// ============================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'alert_models.freezed.dart';
part 'alert_models.g.dart';

@freezed
class AlertModel with _$AlertModel {
  const factory AlertModel({
    required String id,
    @JsonKey(name: 'threat_id') required String threatId,
    required String severity,
    required String title,
    String? description,
    @Default(false) bool acknowledged,
    @JsonKey(name: 'acknowledged_at') DateTime? acknowledgedAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _AlertModel;

  factory AlertModel.fromJson(Map<String, dynamic> json) =>
      _$AlertModelFromJson(json);
}

@freezed
class AlertListResponse with _$AlertListResponse {
  const factory AlertListResponse({
    required int total,
    required List<AlertModel> alerts,
  }) = _AlertListResponse;

  factory AlertListResponse.fromJson(Map<String, dynamic> json) =>
      _$AlertListResponseFromJson(json);
}

@freezed
class AcknowledgeAlertResponse with _$AcknowledgeAlertResponse {
  const factory AcknowledgeAlertResponse({
    required String id,
    required bool acknowledged,
    @JsonKey(name: 'acknowledged_at') required DateTime acknowledgedAt,
  }) = _AcknowledgeAlertResponse;

  factory AcknowledgeAlertResponse.fromJson(Map<String, dynamic> json) =>
      _$AcknowledgeAlertResponseFromJson(json);
}
