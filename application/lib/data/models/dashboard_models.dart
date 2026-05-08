// ============================================================
// SentinelX — Dashboard Data Models
// Mirrors backend DashboardStats, ThreatTrend, DashboardTrends.
// ============================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_models.freezed.dart';
part 'dashboard_models.g.dart';

@freezed
class DashboardStats with _$DashboardStats {
  const factory DashboardStats({
    @JsonKey(name: 'total_threats') required int totalThreats,
    @JsonKey(name: 'phishing_attempts') required int phishingAttempts,
    @JsonKey(name: 'high_risk_alerts') required int highRiskAlerts,
    @JsonKey(name: 'critical_alerts') required int criticalAlerts,
    @JsonKey(name: 'threats_today') required int threatsToday,
    @JsonKey(name: 'avg_risk_score') required double avgRiskScore,
    @JsonKey(name: 'unacknowledged_alerts') required int unacknowledgedAlerts,
  }) = _DashboardStats;

  factory DashboardStats.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsFromJson(json);
}

@freezed
class ThreatTrend with _$ThreatTrend {
  const factory ThreatTrend({
    required String date,
    required int count,
    @JsonKey(name: 'avg_risk_score') required double avgRiskScore,
    required String channel,
  }) = _ThreatTrend;

  factory ThreatTrend.fromJson(Map<String, dynamic> json) =>
      _$ThreatTrendFromJson(json);
}

@freezed
class DashboardTrends with _$DashboardTrends {
  const factory DashboardTrends({
    required List<ThreatTrend> trends,
    @JsonKey(name: 'period_days') required int periodDays,
  }) = _DashboardTrends;

  factory DashboardTrends.fromJson(Map<String, dynamic> json) =>
      _$DashboardTrendsFromJson(json);
}

// ── Offline Queue Item ────────────────────────────────────────────────────────

@freezed
class OfflineQueueItem with _$OfflineQueueItem {
  const factory OfflineQueueItem({
    required String id,
    required String endpoint,
    required Map<String, dynamic> payload,
    required DateTime createdAt,
    @Default(0) int retryCount,
  }) = _OfflineQueueItem;

  factory OfflineQueueItem.fromJson(Map<String, dynamic> json) =>
      _$OfflineQueueItemFromJson(json);
}
