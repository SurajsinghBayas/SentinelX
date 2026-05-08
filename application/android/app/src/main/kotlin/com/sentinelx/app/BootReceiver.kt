package com.sentinelx.app

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

/**
 * Boot Receiver — Restarts the foreground monitoring service after device reboot.
 * Requires RECEIVE_BOOT_COMPLETED permission in AndroidManifest.
 */
class BootReceiver : BroadcastReceiver() {
    companion object {
        private const val TAG = "SentinelX:BootReceiver"
    }

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action != Intent.ACTION_BOOT_COMPLETED) return
        Log.d(TAG, "Boot completed — restarting monitoring service")

        val serviceIntent = Intent(context, ForegroundMonitorService::class.java).apply {
            action = ForegroundMonitorService.ACTION_START
        }
        context.startForegroundService(serviceIntent)
    }
}
