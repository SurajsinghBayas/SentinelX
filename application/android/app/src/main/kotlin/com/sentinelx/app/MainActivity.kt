package com.sentinelx.app

import android.content.Intent
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

/**
 * SentinelX — MainActivity
 *
 * Registers all MethodChannels and EventChannels that bridge
 * Kotlin native code with Flutter Dart code.
 *
 * Channels:
 *   MethodChannel  com.sentinelx.app/monitoring  → control commands (start/stop service, open settings)
 *   EventChannel   com.sentinelx.app/sms_events  → stream of SMS events
 *   EventChannel   com.sentinelx.app/call_events → stream of call state events
 *   EventChannel   com.sentinelx.app/notif_events→ stream of notification events
 */
class MainActivity : FlutterActivity() {

    companion object {
        private const val METHOD_CHANNEL = "com.sentinelx.app/monitoring"
        private const val SMS_EVENT_CHANNEL = "com.sentinelx.app/sms_events"
        private const val CALL_EVENT_CHANNEL = "com.sentinelx.app/call_events"
        private const val NOTIF_EVENT_CHANNEL = "com.sentinelx.app/notif_events"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messenger = flutterEngine.dartExecutor.binaryMessenger

        // ── Method Channel (control commands) ───────────────────────────
        MethodChannel(messenger, METHOD_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startMonitoringService" -> {
                    startForegroundMonitorService()
                    result.success(true)
                }
                "stopMonitoringService" -> {
                    stopForegroundMonitorService()
                    result.success(true)
                }
                "checkNotificationListenerPermission" -> {
                    result.success(hasNotificationListenerPermission())
                }
                "openNotificationListenerSettings" -> {
                    openNotificationListenerSettings()
                    result.success(true)
                }
                "openBatteryOptimizationSettings" -> {
                    openBatteryOptimizationSettings()
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }

        // ── SMS Event Channel ────────────────────────────────────────────
        EventChannel(messenger, SMS_EVENT_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    SmsReceiver.eventSink = events
                }
                override fun onCancel(arguments: Any?) {
                    SmsReceiver.eventSink = null
                }
            }
        )

        // ── Call Event Channel ───────────────────────────────────────────
        EventChannel(messenger, CALL_EVENT_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    CallStateReceiver.eventSink = events
                }
                override fun onCancel(arguments: Any?) {
                    CallStateReceiver.eventSink = null
                }
            }
        )

        // ── Notification Event Channel ────────────────────────────────────
        EventChannel(messenger, NOTIF_EVENT_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    SentinelNotificationListenerService.eventSink = events
                }
                override fun onCancel(arguments: Any?) {
                    SentinelNotificationListenerService.eventSink = null
                }
            }
        )
    }

    // ── Service Control ─────────────────────────────────────────────────────

    private fun startForegroundMonitorService() {
        val intent = Intent(this, ForegroundMonitorService::class.java).apply {
            action = ForegroundMonitorService.ACTION_START
        }
        startForegroundService(intent)
    }

    private fun stopForegroundMonitorService() {
        val intent = Intent(this, ForegroundMonitorService::class.java).apply {
            action = ForegroundMonitorService.ACTION_STOP
        }
        startService(intent)
    }

    // ── Notification Listener Helpers ───────────────────────────────────────

    private fun hasNotificationListenerPermission(): Boolean {
        val flat = Settings.Secure.getString(
            contentResolver,
            "enabled_notification_listeners"
        )
        return flat?.contains(packageName) == true
    }

    private fun openNotificationListenerSettings() {
        startActivity(Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS))
    }

    private fun openBatteryOptimizationSettings() {
        startActivity(Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS))
    }
}
