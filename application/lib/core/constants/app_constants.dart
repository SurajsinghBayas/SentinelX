// ============================================================
// SentinelX — App Constants
// ============================================================

class AppConstants {
  AppConstants._();

  // ── App Info ───────────────────────────────────────────────────────
  static const String appName = 'SentinelX';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'AI-Powered Threat Detection';

  // ── Hive Box Names ─────────────────────────────────────────────────
  static const String authBox = 'auth_box';
  static const String alertsBox = 'alerts_box';
  static const String offlineQueueBox = 'offline_queue_box';
  static const String settingsBox = 'settings_box';
  static const String threatHistoryBox = 'threat_history_box';

  // ── Hive Keys ─────────────────────────────────────────────────────
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserJson = 'user_json';
  static const String keyTokenExpiry = 'token_expiry';

  // ── Notification Channel IDs ───────────────────────────────────────
  static const String channelMonitoringId = 'sentinelx_monitoring';
  static const String channelMonitoringName = 'Monitoring Service';
  static const String channelAlertsId = 'sentinelx_alerts';
  static const String channelAlertsName = 'Threat Alerts';

  // ── Notification IDs ──────────────────────────────────────────────
  static const int notifForegroundServiceId = 1001;
  static const int notifThreatAlertId = 2001;

  // ── Risk Score Thresholds ─────────────────────────────────────────
  static const double riskLow = 30.0;
  static const double riskMedium = 60.0;
  static const double riskHigh = 85.0;
  // > 85 = CRITICAL

  // ── Monitoring Apps Allowlist ─────────────────────────────────────
  // Notifications from these packages are forwarded to backend
  static const List<String> monitoredPackages = [
    'com.whatsapp',
    'com.whatsapp.w4b',
    'org.telegram.messenger',
    'org.telegram.plus',
    'com.instagram.android',
    'com.facebook.orca',        // Messenger
    'com.sbi.lotusintouch',     // SBI
    'com.snapwork.hdfc',        // HDFC
    'com.icicibank.mobile',     // ICICI
    'com.axisbank.retail',      // Axis
    'com.kotak.mobilebanking',  // Kotak
    'com.PayPal.android',
    'com.google.android.apps.tachyon', // Google Meet
    'com.microsoft.teams',
    'com.skype.raider',
  ];

  // ── UI ────────────────────────────────────────────────────────────
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration dashboardRefreshInterval = Duration(seconds: 30);
  static const Duration offlineRetryInterval = Duration(seconds: 60);
  static const int alertsPageSize = 20;
  static const int threatsPageSize = 20;
  static const int chartDays = 7;
}
