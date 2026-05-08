// ============================================================
// SentinelX — Threat Repository
// Sends device events to backend. Falls back to offline queue.
// ============================================================

import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../datasources/remote/analyze_remote_datasource.dart';
import '../models/threat_models.dart';
import '../../core/storage/hive_service.dart';

abstract class ThreatRepository {
  Future<ThreatAnalysisResponse> analyzeSms({
    required String sender,
    required String message,
  });
  Future<ThreatAnalysisResponse> analyzeCall({
    required String transcript,
    String? callerId,
    int? durationSeconds,
  });
  Future<ThreatAnalysisResponse> analyzeEmail({
    required String sender,
    required String subject,
    required String body,
  });
}

class ThreatRepositoryImpl implements ThreatRepository {
  final AnalyzeRemoteDataSource _dataSource;
  final _uuid = const Uuid();

  ThreatRepositoryImpl({AnalyzeRemoteDataSource? dataSource})
      : _dataSource = dataSource ?? AnalyzeRemoteDataSourceImpl();

  @override
  Future<ThreatAnalysisResponse> analyzeSms({
    required String sender,
    required String message,
  }) async {
    try {
      final result = await _dataSource.analyzeSms(
        SmsAnalysisRequest(sender: sender, message: message),
      );
      return result;
    } catch (e) {
      // Queue for offline retry
      await _enqueueOffline('sms', {
        'sender': sender,
        'message': message,
      });
      rethrow;
    }
  }

  @override
  Future<ThreatAnalysisResponse> analyzeCall({
    required String transcript,
    String? callerId,
    int? durationSeconds,
  }) async {
    try {
      final result = await _dataSource.analyzeCall(
        CallAnalysisRequest(
          transcript: transcript,
          callerId: callerId,
          durationSeconds: durationSeconds,
        ),
      );
      return result;
    } catch (e) {
      await _enqueueOffline('call', {
        'transcript': transcript,
        if (callerId != null) 'caller_id': callerId,
        if (durationSeconds != null) 'duration_seconds': durationSeconds,
      });
      rethrow;
    }
  }

  @override
  Future<ThreatAnalysisResponse> analyzeEmail({
    required String sender,
    required String subject,
    required String body,
  }) async {
    try {
      final result = await _dataSource.analyzeEmail(
        EmailAnalysisRequest(sender: sender, subject: subject, body: body),
      );
      return result;
    } catch (e) {
      await _enqueueOffline('email', {
        'sender': sender,
        'subject': subject,
        'body': body,
      });
      rethrow;
    }
  }

  Future<void> _enqueueOffline(
    String type,
    Map<String, dynamic> payload,
  ) async {
    final id = _uuid.v4();
    final item = {
      'id': id,
      'type': type,
      'payload': payload,
      'created_at': DateTime.now().toIso8601String(),
      'retry_count': 0,
    };
    await HiveService.enqueueItem(id, item);
  }
}
