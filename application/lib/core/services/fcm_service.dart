// ============================================================
// SentinelX — FCM Service
// Firebase Cloud Messaging integration for push alerts.
// ============================================================

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../constants/app_constants.dart';

/// Background message handler — must be a top-level function
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('[FCM] Background message: ${message.messageId}');
  await FcmService._showLocalNotification(message);
}

class FcmService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // ── Local Notifications Setup ─────────────────────────────────────
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    await _createNotificationChannels();

    // ── FCM Setup ─────────────────────────────────────────────────────
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Foreground message handler
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('[FCM] Foreground message: ${message.messageId}');
      _showLocalNotification(message);
    });

    // Handle notification taps when app is in background (but not killed)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('[FCM] Notification tapped (background): ${message.data}');
      // Navigation handled by GoRouter redirect on app resume
    });

    // Request permission (Android 13+)
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      criticalAlert: true,
    );

    // Log FCM token for backend registration (future feature)
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('[FCM] Device token: $token');
  }

  static Future<void> _createNotificationChannels() async {
    // Alert channel (high importance — makes sound + heads-up)
    const alertChannel = AndroidNotificationChannel(
      AppConstants.channelAlertsId,
      AppConstants.channelAlertsName,
      description: 'Critical threat alerts from SentinelX',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    // Monitoring channel (low importance — silent)
    const monitoringChannel = AndroidNotificationChannel(
      AppConstants.channelMonitoringId,
      AppConstants.channelMonitoringName,
      description: 'Background monitoring status',
      importance: Importance.low,
      playSound: false,
    );

    final plugin = _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await plugin?.createNotificationChannel(alertChannel);
    await plugin?.createNotificationChannel(monitoringChannel);
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final title = notification?.title ?? message.data['title'] ?? 'SentinelX Alert';
    final body = notification?.body ?? message.data['body'] ?? 'Threat detected';

    const androidDetails = AndroidNotificationDetails(
      AppConstants.channelAlertsId,
      AppConstants.channelAlertsName,
      channelDescription: 'Critical threat alerts',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );

    await _localNotifications.show(
      AppConstants.notifThreatAlertId,
      title,
      body,
      const NotificationDetails(android: androidDetails),
      payload: jsonEncode(message.data),
    );
  }

  static void _onNotificationTap(NotificationResponse response) {
    debugPrint('[FCM] Local notification tapped: ${response.payload}');
    // Navigation handled by router
  }

  /// Show an in-app threat notification (called from ThreatRepository)
  static Future<void> showThreatAlert({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      AppConstants.channelAlertsId,
      AppConstants.channelAlertsName,
      importance: Importance.max,
      priority: Priority.high,
      fullScreenIntent: true, // Show as heads-up
    );

    await _localNotifications.show(
      AppConstants.notifThreatAlertId,
      title,
      body,
      const NotificationDetails(android: androidDetails),
      payload: payload,
    );
  }
}
