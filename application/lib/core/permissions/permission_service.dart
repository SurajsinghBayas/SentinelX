// ============================================================
// SentinelX — Permission Service
// ============================================================

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  PermissionService._();

  static const MethodChannel _channel =
      MethodChannel('com.sentinelx.app/monitoring');

  // ── Permission Checks ───────────────────────────────────────────────
  static Future<bool> hasSmsPermission() async {
    final status = await Permission.sms.status;
    return status.isGranted;
  }

  static Future<bool> hasPhonePermission() async {
    final status = await Permission.phone.status;
    return status.isGranted;
  }

  static Future<bool> hasNotificationPermission() async {
    final status = await Permission.notification.status;
    return status.isGranted;
  }

  static Future<bool> hasNotificationListenerPermission() async {
    try {
      final result = await _channel.invokeMethod<bool>(
        'checkNotificationListenerPermission',
      );
      return result ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> hasMicrophonePermission() async {
    final status = await Permission.microphone.status;
    return status.isGranted;
  }

  // ── Permission Requests ─────────────────────────────────────────────
  static Future<PermissionStatus> requestSms() =>
      Permission.sms.request();

  static Future<PermissionStatus> requestPhone() =>
      Permission.phone.request();

  static Future<PermissionStatus> requestNotification() =>
      Permission.notification.request();

  static Future<PermissionStatus> requestMicrophone() =>
      Permission.microphone.request();

  static Future<void> openNotificationListenerSettings() async {
    try {
      await _channel.invokeMethod('openNotificationListenerSettings');
    } catch (_) {
      await openAppSettings();
    }
  }

  static Future<void> requestAllCore() async {
    await [
      Permission.sms,
      Permission.phone,
      Permission.notification,
    ].request();
  }

  // ── Status Bundle ───────────────────────────────────────────────────
  static Future<PermissionBundle> checkAll() async {
    final results = await Future.wait([
      hasSmsPermission(),
      hasPhonePermission(),
      hasNotificationPermission(),
      hasNotificationListenerPermission(),
    ]);

    return PermissionBundle(
      sms: results[0],
      phone: results[1],
      notification: results[2],
      notificationListener: results[3],
    );
  }
}

class PermissionBundle {
  final bool sms;
  final bool phone;
  final bool notification;
  final bool notificationListener;

  const PermissionBundle({
    required this.sms,
    required this.phone,
    required this.notification,
    required this.notificationListener,
  });

  bool get allCoreGranted => sms && phone && notification;
  bool get allGranted => allCoreGranted && notificationListener;

  PermissionBundle copyWith({
    bool? sms,
    bool? phone,
    bool? notification,
    bool? notificationListener,
  }) {
    return PermissionBundle(
      sms: sms ?? this.sms,
      phone: phone ?? this.phone,
      notification: notification ?? this.notification,
      notificationListener: notificationListener ?? this.notificationListener,
    );
  }
}
