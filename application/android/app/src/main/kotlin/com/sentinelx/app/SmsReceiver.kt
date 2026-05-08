package com.sentinelx.app

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.provider.Telephony
import android.util.Log
import io.flutter.plugin.common.EventChannel

/**
 * SentinelX SMS Broadcast Receiver
 *
 * Intercepts incoming SMS messages and forwards them to Flutter
 * via EventChannel for backend threat analysis.
 *
 * Registered in AndroidManifest.xml with highest priority (2147483647)
 * so SentinelX processes the SMS before it reaches other apps.
 */
class SmsReceiver : BroadcastReceiver() {

    companion object {
        private const val TAG = "SentinelX:SmsReceiver"

        // Shared EventSink — set by MainActivity when EventChannel is ready
        var eventSink: EventChannel.EventSink? = null
    }

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action != Telephony.Sms.Intents.SMS_RECEIVED_ACTION) return

        try {
            val messages = Telephony.Sms.Intents.getMessagesFromIntent(intent)
            if (messages.isNullOrEmpty()) return

            // Merge multipart SMS fragments from the same sender
            val sender = messages[0].displayOriginatingAddress ?: "Unknown"
            val body = messages.joinToString("") { it.messageBody ?: "" }
            val timestamp = messages[0].timestampMillis

            Log.d(TAG, "SMS received from: $sender")

            val payload = mapOf(
                "type" to "sms",
                "sender" to sender,
                "message" to body,
                "timestamp" to timestamp
            )

            // Forward to Flutter on main thread
            eventSink?.success(payload)

        } catch (e: Exception) {
            Log.e(TAG, "Error processing SMS: ${e.message}", e)
        }
    }
}
