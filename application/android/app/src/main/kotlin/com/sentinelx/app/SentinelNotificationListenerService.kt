package com.sentinelx.app

import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.util.Log
import io.flutter.plugin.common.EventChannel

/**
 * SentinelX Notification Listener Service
 *
 * Monitors incoming notifications from a configurable allowlist of apps
 * (messaging apps, banking apps) and forwards them to Flutter for
 * backend threat analysis.
 *
 * Must be granted via Settings > Apps > Special App Access > Notification Access.
 */
class SentinelNotificationListenerService : NotificationListenerService() {

    companion object {
        private const val TAG = "SentinelX:NotifListener"

        // Packages to monitor (matches AppConstants.monitoredPackages in Flutter)
        private val MONITORED_PACKAGES = setOf(
            "com.whatsapp",
            "com.whatsapp.w4b",
            "org.telegram.messenger",
            "org.telegram.plus",
            "com.instagram.android",
            "com.facebook.orca",
            "com.sbi.lotusintouch",
            "com.snapwork.hdfc",
            "com.icicibank.mobile",
            "com.axisbank.retail",
            "com.kotak.mobilebanking",
            "com.PayPal.android",
            "com.google.android.apps.tachyon",
            "com.microsoft.teams",
            "com.skype.raider"
        )

        // Shared EventSink — set by MainActivity
        var eventSink: EventChannel.EventSink? = null
    }

    override fun onNotificationPosted(sbn: StatusBarNotification) {
        val packageName = sbn.packageName ?: return

        // Only process monitored packages
        if (packageName !in MONITORED_PACKAGES) return

        // Skip group summaries and ongoing notifications
        if (sbn.isOngoing) return

        try {
            val extras = sbn.notification?.extras ?: return
            val title = extras.getCharSequence("android.title")?.toString()
            val text = extras.getCharSequence("android.text")?.toString()
            val bigText = extras.getCharSequence("android.bigText")?.toString()

            val body = bigText ?: text

            // Skip empty notifications
            if (body.isNullOrBlank() && title.isNullOrBlank()) return

            Log.d(TAG, "Notification from $packageName: $title")

            val appName = getAppName(packageName)

            val payload = mapOf(
                "type" to "notification",
                "packageName" to packageName,
                "appName" to appName,
                "title" to (title ?: ""),
                "body" to (body ?: ""),
                "timestamp" to System.currentTimeMillis()
            )

            eventSink?.success(payload)

        } catch (e: Exception) {
            Log.e(TAG, "Error processing notification: ${e.message}", e)
        }
    }

    override fun onNotificationRemoved(sbn: StatusBarNotification) {
        // No action needed
    }

    private fun getAppName(packageName: String): String {
        return try {
            val pm = applicationContext.packageManager
            val info = pm.getApplicationInfo(packageName, 0)
            pm.getApplicationLabel(info).toString()
        } catch (_: Exception) {
            packageName
        }
    }
}
