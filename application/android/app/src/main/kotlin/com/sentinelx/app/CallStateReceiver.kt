package com.sentinelx.app

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.TelephonyManager
import android.util.Log
import io.flutter.plugin.common.EventChannel

/**
 * SentinelX Call State Receiver
 *
 * Detects incoming call events using PHONE_STATE broadcast.
 * Forwards caller ID and call state transitions to Flutter.
 *
 * States: RINGING → OFFHOOK → IDLE
 *
 * NOTE: This only detects state changes — it does NOT intercept
 * or record call audio (which would require Telecom API and carrier agreements).
 */
class CallStateReceiver : BroadcastReceiver() {

    companion object {
        private const val TAG = "SentinelX:CallReceiver"

        // Shared EventSink — set by MainActivity
        var eventSink: EventChannel.EventSink? = null

        private var lastState = TelephonyManager.CALL_STATE_IDLE
        private var callStartTime: Long = 0
        private var lastIncomingNumber: String? = null
    }

    override fun onReceive(context: Context, intent: Intent) {
        val stateStr = intent.getStringExtra(TelephonyManager.EXTRA_STATE) ?: return

        val incomingNumber = intent.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER)

        val state = when (stateStr) {
            TelephonyManager.EXTRA_STATE_RINGING -> TelephonyManager.CALL_STATE_RINGING
            TelephonyManager.EXTRA_STATE_OFFHOOK -> TelephonyManager.CALL_STATE_OFFHOOK
            else -> TelephonyManager.CALL_STATE_IDLE
        }

        if (state == lastState) return

        Log.d(TAG, "Call state: $stateStr | Number: $incomingNumber")

        when {
            state == TelephonyManager.CALL_STATE_RINGING -> {
                lastIncomingNumber = incomingNumber
                callStartTime = System.currentTimeMillis()

                val payload = mapOf(
                    "type" to "call",
                    "event" to "ringing",
                    "callerId" to (incomingNumber ?: "Unknown"),
                    "timestamp" to callStartTime
                )
                eventSink?.success(payload)
            }

            state == TelephonyManager.CALL_STATE_OFFHOOK && lastState == TelephonyManager.CALL_STATE_RINGING -> {
                // Call answered
                val payload = mapOf(
                    "type" to "call",
                    "event" to "answered",
                    "callerId" to (lastIncomingNumber ?: "Unknown"),
                    "timestamp" to System.currentTimeMillis()
                )
                eventSink?.success(payload)
            }

            state == TelephonyManager.CALL_STATE_IDLE && lastState != TelephonyManager.CALL_STATE_IDLE -> {
                // Call ended
                val duration = if (callStartTime > 0) {
                    ((System.currentTimeMillis() - callStartTime) / 1000).toInt()
                } else 0

                val payload = mapOf(
                    "type" to "call",
                    "event" to "ended",
                    "callerId" to (lastIncomingNumber ?: "Unknown"),
                    "durationSeconds" to duration,
                    "timestamp" to System.currentTimeMillis()
                )
                eventSink?.success(payload)
                lastIncomingNumber = null
                callStartTime = 0
            }
        }

        lastState = state
    }
}
