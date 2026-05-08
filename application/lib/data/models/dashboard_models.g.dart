// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardStatsImpl _$$DashboardStatsImplFromJson(Map<String, dynamic> json) =>
    _$DashboardStatsImpl(
      totalThreats: (json['total_threats'] as num).toInt(),
      phishingAttempts: (json['phishing_attempts'] as num).toInt(),
      highRiskAlerts: (json['high_risk_alerts'] as num).toInt(),
      criticalAlerts: (json['critical_alerts'] as num).toInt(),
      threatsToday: (json['threats_today'] as num).toInt(),
      avgRiskScore: (json['avg_risk_score'] as num).toDouble(),
      unacknowledgedAlerts: (json['unacknowledged_alerts'] as num).toInt(),
    );

Map<String, dynamic> _$$DashboardStatsImplToJson(
        _$DashboardStatsImpl instance) =>
    <String, dynamic>{
      'total_threats': instance.totalThreats,
      'phishing_attempts': instance.phishingAttempts,
      'high_risk_alerts': instance.highRiskAlerts,
      'critical_alerts': instance.criticalAlerts,
      'threats_today': instance.threatsToday,
      'avg_risk_score': instance.avgRiskScore,
      'unacknowledged_alerts': instance.unacknowledgedAlerts,
    };

_$ThreatTrendImpl _$$ThreatTrendImplFromJson(Map<String, dynamic> json) =>
    _$ThreatTrendImpl(
      date: json['date'] as String,
      count: (json['count'] as num).toInt(),
      avgRiskScore: (json['avg_risk_score'] as num).toDouble(),
      channel: json['channel'] as String,
    );

Map<String, dynamic> _$$ThreatTrendImplToJson(_$ThreatTrendImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'count': instance.count,
      'avg_risk_score': instance.avgRiskScore,
      'channel': instance.channel,
    };

_$DashboardTrendsImpl _$$DashboardTrendsImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardTrendsImpl(
      trends: (json['trends'] as List<dynamic>)
          .map((e) => ThreatTrend.fromJson(e as Map<String, dynamic>))
          .toList(),
      periodDays: (json['period_days'] as num).toInt(),
    );

Map<String, dynamic> _$$DashboardTrendsImplToJson(
        _$DashboardTrendsImpl instance) =>
    <String, dynamic>{
      'trends': instance.trends,
      'period_days': instance.periodDays,
    };

_$OfflineQueueItemImpl _$$OfflineQueueItemImplFromJson(
        Map<String, dynamic> json) =>
    _$OfflineQueueItemImpl(
      id: json['id'] as String,
      endpoint: json['endpoint'] as String,
      payload: json['payload'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$OfflineQueueItemImplToJson(
        _$OfflineQueueItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'endpoint': instance.endpoint,
      'payload': instance.payload,
      'createdAt': instance.createdAt.toIso8601String(),
      'retryCount': instance.retryCount,
    };
