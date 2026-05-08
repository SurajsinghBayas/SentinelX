// ============================================================
// SentinelX — Monitoring Channel Service
// Flutter-side bridge for all Android native event channels.
// ============================================================

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MonitoringChannelService {
  static const MethodChannel _methodChannel =
      MethodChannel('com.sentinelx.app/monitoring');

  static const EventChannel _smsChannel =
      EventChannel('com.sentinelx.app/sms_events');

  static const EventChannel _callChannel =
      EventChannel('com.sentinelx.app/call_events');

  static const EventChannel _notifChannel =
      EventChannel('com.sentinelx.app/notif_events');

  // ── Method Channel Calls ────────────────────────────────────────────
  static Future<bool> startMonitoringService() async {
    try {
      final result = await _methodChannel.invokeMethod<bool>(
        'startMonitoringService',
      );
      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> stopMonitoringService() async {
    try {
      final result = await _methodChannel.invokeMethod<bool>(
        'stopMonitoringService',
      );
      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  // ── Event Streams ───────────────────────────────────────────────────
  static Stream<Map<String, dynamic>> get smsStream =>
      _smsChannel.receiveBroadcastStream().cast<Map<Object?, Object?>>().map(
            (event) => Map<String, dynamic>.from(event),
          );

  static Stream<Map<String, dynamic>> get callStream =>
      _callChannel.receiveBroadcastStream().cast<Map<Object?, Object?>>().map(
            (event) => Map<String, dynamic>.from(event),
          );

  static Stream<Map<String, dynamic>> get notificationStream =>
      _notifChannel.receiveBroadcastStream().cast<Map<Object?, Object?>>().map(
            (event) => Map<String, dynamic>.from(event),
          );
}

// ── Riverpod Provider ───────────────────────────────────────────────────────

final monitoringChannelServiceProvider = Provider<MonitoringChannelService>(
  (_) => MonitoringChannelService(),
);
