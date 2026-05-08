// ============================================================
// SentinelX — Offline Queue Service
// ============================================================

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/datasources/remote/analyze_remote_datasource.dart';
import '../../data/models/threat_models.dart';
import '../network/dio_client.dart';
import '../storage/hive_service.dart';
import '../constants/app_constants.dart';

class OfflineQueueService {
  final _uuid = const Uuid();
  Timer? _retryTimer;
  bool _isProcessing = false;

  void start() {
    // Listen for connectivity changes
    Connectivity().onConnectivityChanged.listen((results) {
      if (results.any((r) => r != ConnectivityResult.none)) {
        _processQueue();
      }
    });

    // Also retry on a fixed interval
    _retryTimer = Timer.periodic(
      AppConstants.offlineRetryInterval,
      (_) => _processQueue(),
    );
  }

  void stop() {
    _retryTimer?.cancel();
    _retryTimer = null;
  }

  Future<void> _processQueue() async {
    if (_isProcessing) return;

    final queuedItems = HiveService.allQueuedItems;
    if (queuedItems.isEmpty) return;

    // Check connectivity
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity.contains(ConnectivityResult.none)) return;

    _isProcessing = true;

    try {
      final datasource = AnalyzeRemoteDataSourceImpl();

      for (final entry in queuedItems.entries) {
        final key = entry.key as String;
        final item = Map<String, dynamic>.from(entry.value as Map);

        try {
          final type = item['type'] as String;
          final payload = Map<String, dynamic>.from(item['payload'] as Map);

          switch (type) {
            case 'sms':
              await datasource.analyzeSms(SmsAnalysisRequest(
                sender: payload['sender'] as String,
                message: payload['message'] as String,
              ));
              break;
            case 'call':
              await datasource.analyzeCall(CallAnalysisRequest(
                transcript: payload['transcript'] as String,
                callerId: payload['caller_id'] as String?,
                durationSeconds: payload['duration_seconds'] as int?,
              ));
              break;
            case 'email':
              await datasource.analyzeEmail(EmailAnalysisRequest(
                sender: payload['sender'] as String,
                subject: payload['subject'] as String,
                body: payload['body'] as String,
              ));
              break;
          }

          // Remove from queue on success
          await HiveService.dequeueItem(key);
          debugPrint('[OfflineQueue] Successfully retried item: $key ($type)');
        } catch (e) {
          // Update retry count
          final retryCount = (item['retry_count'] as int? ?? 0) + 1;
          if (retryCount >= 5) {
            // Give up after 5 retries
            await HiveService.dequeueItem(key);
            debugPrint('[OfflineQueue] Dropped item after 5 retries: $key');
          } else {
            item['retry_count'] = retryCount;
            await HiveService.enqueueItem(key, item);
          }
        }
      }
    } finally {
      _isProcessing = false;
    }
  }

  int get queueLength => HiveService.allQueuedItems.length;
}

// ── Provider ────────────────────────────────────────────────────────────────

final offlineQueueServiceProvider = Provider<OfflineQueueService>(
  (ref) => OfflineQueueService(),
);
