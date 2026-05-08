// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlertModelImpl _$$AlertModelImplFromJson(Map<String, dynamic> json) =>
    _$AlertModelImpl(
      id: json['id'] as String,
      threatId: json['threat_id'] as String,
      severity: json['severity'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      acknowledged: json['acknowledged'] as bool? ?? false,
      acknowledgedAt: json['acknowledged_at'] == null
          ? null
          : DateTime.parse(json['acknowledged_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$AlertModelImplToJson(_$AlertModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'threat_id': instance.threatId,
      'severity': instance.severity,
      'title': instance.title,
      'description': instance.description,
      'acknowledged': instance.acknowledged,
      'acknowledged_at': instance.acknowledgedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };

_$AlertListResponseImpl _$$AlertListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AlertListResponseImpl(
      total: (json['total'] as num).toInt(),
      alerts: (json['alerts'] as List<dynamic>)
          .map((e) => AlertModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AlertListResponseImplToJson(
        _$AlertListResponseImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'alerts': instance.alerts,
    };

_$AcknowledgeAlertResponseImpl _$$AcknowledgeAlertResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AcknowledgeAlertResponseImpl(
      id: json['id'] as String,
      acknowledged: json['acknowledged'] as bool,
      acknowledgedAt: DateTime.parse(json['acknowledged_at'] as String),
    );

Map<String, dynamic> _$$AcknowledgeAlertResponseImplToJson(
        _$AcknowledgeAlertResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'acknowledged': instance.acknowledged,
      'acknowledged_at': instance.acknowledgedAt.toIso8601String(),
    };
