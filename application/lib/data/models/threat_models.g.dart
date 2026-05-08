// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'threat_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThreatAnalysisResponseImpl _$$ThreatAnalysisResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ThreatAnalysisResponseImpl(
      threatId: json['threat_id'] as String?,
      threatDetected: json['threat_detected'] as bool,
      riskScore: (json['risk_score'] as num).toDouble(),
      threatLevel: json['threat_level'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      classificationLabel: json['classification_label'] as String,
      reasons:
          (json['reasons'] as List<dynamic>).map((e) => e as String).toList(),
      extractedUrls: (json['extracted_urls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      nlpScore: (json['nlp_score'] as num).toDouble(),
      behaviorScore: (json['behavior_score'] as num).toDouble(),
      urlScore: (json['url_score'] as num).toDouble(),
      reputationScore: (json['reputation_score'] as num).toDouble(),
      processingMode: json['processing_mode'] as String? ?? 'sync',
      taskId: json['task_id'] as String?,
    );

Map<String, dynamic> _$$ThreatAnalysisResponseImplToJson(
        _$ThreatAnalysisResponseImpl instance) =>
    <String, dynamic>{
      'threat_id': instance.threatId,
      'threat_detected': instance.threatDetected,
      'risk_score': instance.riskScore,
      'threat_level': instance.threatLevel,
      'confidence': instance.confidence,
      'classification_label': instance.classificationLabel,
      'reasons': instance.reasons,
      'extracted_urls': instance.extractedUrls,
      'nlp_score': instance.nlpScore,
      'behavior_score': instance.behaviorScore,
      'url_score': instance.urlScore,
      'reputation_score': instance.reputationScore,
      'processing_mode': instance.processingMode,
      'task_id': instance.taskId,
    };

_$ThreatSummaryImpl _$$ThreatSummaryImplFromJson(Map<String, dynamic> json) =>
    _$ThreatSummaryImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      channel: json['channel'] as String,
      riskScore: (json['risk_score'] as num).toDouble(),
      threatLevel: json['threat_level'] as String,
      threatDetected: json['threat_detected'] as bool,
      sender: json['sender'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ThreatSummaryImplToJson(_$ThreatSummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'channel': instance.channel,
      'risk_score': instance.riskScore,
      'threat_level': instance.threatLevel,
      'threat_detected': instance.threatDetected,
      'sender': instance.sender,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$ThreatListResponseImpl _$$ThreatListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ThreatListResponseImpl(
      total: (json['total'] as num).toInt(),
      threats: (json['threats'] as List<dynamic>)
          .map((e) => ThreatSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ThreatListResponseImplToJson(
        _$ThreatListResponseImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'threats': instance.threats,
    };

_$SmsAnalysisRequestImpl _$$SmsAnalysisRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SmsAnalysisRequestImpl(
      sender: json['sender'] as String,
      message: json['message'] as String,
      asyncProcessing: json['async_processing'] as bool? ?? false,
    );

Map<String, dynamic> _$$SmsAnalysisRequestImplToJson(
        _$SmsAnalysisRequestImpl instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'message': instance.message,
      'async_processing': instance.asyncProcessing,
    };

_$CallAnalysisRequestImpl _$$CallAnalysisRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CallAnalysisRequestImpl(
      transcript: json['transcript'] as String,
      callerId: json['caller_id'] as String?,
      durationSeconds: (json['duration_seconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CallAnalysisRequestImplToJson(
        _$CallAnalysisRequestImpl instance) =>
    <String, dynamic>{
      'transcript': instance.transcript,
      'caller_id': instance.callerId,
      'duration_seconds': instance.durationSeconds,
    };

_$EmailAnalysisRequestImpl _$$EmailAnalysisRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$EmailAnalysisRequestImpl(
      sender: json['sender'] as String,
      subject: json['subject'] as String,
      body: json['body'] as String,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      asyncProcessing: json['async_processing'] as bool? ?? false,
    );

Map<String, dynamic> _$$EmailAnalysisRequestImplToJson(
        _$EmailAnalysisRequestImpl instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'subject': instance.subject,
      'body': instance.body,
      'attachments': instance.attachments,
      'async_processing': instance.asyncProcessing,
    };

_$SmsEventImpl _$$SmsEventImplFromJson(Map<String, dynamic> json) =>
    _$SmsEventImpl(
      id: json['id'] as String,
      sender: json['sender'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      sentToBackend: json['sentToBackend'] as bool? ?? false,
      analysisResult: json['analysisResult'] == null
          ? null
          : ThreatAnalysisResponse.fromJson(
              json['analysisResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SmsEventImplToJson(_$SmsEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
      'sentToBackend': instance.sentToBackend,
      'analysisResult': instance.analysisResult,
    };

_$CallEventImpl _$$CallEventImplFromJson(Map<String, dynamic> json) =>
    _$CallEventImpl(
      id: json['id'] as String,
      callerId: json['callerId'] as String,
      state: json['state'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
      transcript: json['transcript'] as String?,
      sentToBackend: json['sentToBackend'] as bool? ?? false,
      analysisResult: json['analysisResult'] == null
          ? null
          : ThreatAnalysisResponse.fromJson(
              json['analysisResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CallEventImplToJson(_$CallEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'callerId': instance.callerId,
      'state': instance.state,
      'timestamp': instance.timestamp.toIso8601String(),
      'durationSeconds': instance.durationSeconds,
      'transcript': instance.transcript,
      'sentToBackend': instance.sentToBackend,
      'analysisResult': instance.analysisResult,
    };

_$NotificationEventImpl _$$NotificationEventImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationEventImpl(
      id: json['id'] as String,
      packageName: json['packageName'] as String,
      appName: json['appName'] as String,
      title: json['title'] as String?,
      body: json['body'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      sentToBackend: json['sentToBackend'] as bool? ?? false,
      analysisResult: json['analysisResult'] == null
          ? null
          : ThreatAnalysisResponse.fromJson(
              json['analysisResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$NotificationEventImplToJson(
        _$NotificationEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packageName': instance.packageName,
      'appName': instance.appName,
      'title': instance.title,
      'body': instance.body,
      'timestamp': instance.timestamp.toIso8601String(),
      'sentToBackend': instance.sentToBackend,
      'analysisResult': instance.analysisResult,
    };
