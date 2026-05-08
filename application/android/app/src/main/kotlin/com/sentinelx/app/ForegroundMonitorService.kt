package com.sentinelx.app

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat

/**
 * SentinelX Foreground Monitor Service
 *
 * Keeps the monitoring stack alive even when the app is in the background
 * or the user swipes away the app. Android foreground services are exempt
 * from most battery optimisations and are kept alive by the OS.
 *
 * The persistent notification shows the current monitoring status.
 */
class ForegroundMonitorService : Service() {

    companion object {
        private const val TAG = "SentinelX:ForegroundSvc"
        private const val NOTIFICATION_ID = 1001
        private const val CHANNEL_ID = "sentinelx_monitoring"
        private const val CHANNEL_NAME = "Monitoring Service"

        const val ACTION_START = "com.sentinelx.START_MONITORING"
        const val ACTION_STOP = "com.sentinelx.STOP_MONITORING"
    }

    override fun onCreate() {
        super.onCreate()
        Log.d(TAG, "ForegroundMonitorService created")
        createNotificationChannel()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_STOP -> {
                Log.d(TAG, "Stop action received")
                stopForeground(STOP_FOREGROUND_REMOVE)
                stopSelf()
                return START_NOT_STICKY
            }
            else -> {
                Log.d(TAG, "Starting foreground monitoring service")
                startForeground(NOTIFICATION_ID, buildNotification())
            }
        }
        return START_STICKY // Restart if killed by system
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "ForegroundMonitorService destroyed")
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                CHANNEL_NAME,
                NotificationManager.IMPORTANCE_LOW // Low = silent, no sound
            ).apply {
                description = "SentinelX active threat monitoring"
                setShowBadge(false)
                lockscreenVisibility = Notification.VISIBILITY_PUBLIC
            }
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }
    }

    private fun buildNotification(): Notification {
        val tapIntent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_SINGLE_TOP
        }
        val pendingIntent = PendingIntent.getActivity(
            this, 0, tapIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val stopIntent = Intent(this, ForegroundMonitorService::class.java).apply {
            action = ACTION_STOP
        }
        val stopPending = PendingIntent.getService(
            this, 1, stopIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("🛡️ SentinelX Active")
            .setContentText("Monitoring SMS, calls & notifications for threats")
            .setSmallIcon(android.R.drawable.ic_dialog_alert) // Replace with custom icon
            .setContentIntent(pendingIntent)
            .setOngoing(true)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .setCategory(NotificationCompat.CATEGORY_SERVICE)
            .addAction(
                android.R.drawable.ic_menu_close_clear_cancel,
                "Stop Monitoring",
                stopPending
            )
            .build()
    }
}
