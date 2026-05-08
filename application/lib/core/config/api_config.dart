// ============================================================
// SentinelX — API Configuration
// ============================================================
// IMPORTANT: To switch backend environments, change ONLY the
// [activeEnvironment] value below. Everything else is derived.
// ============================================================

enum ApiEnvironment { emulator, lan, production }

class ApiConfig {
  ApiConfig._();

  // ── Environment Selection ──────────────────────────────────────────
  // emulator  → Android emulator connects to host machine localhost
  // lan       → Physical device on same Wi-Fi as dev machine
  // production → Live backend server
  static const ApiEnvironment activeEnvironment = ApiEnvironment.lan;

  // ── Base URLs per environment ──────────────────────────────────────
  static const String _emulatorUrl = 'http://localhost:8000';
  static const String _lanUrl = 'http://10.12.2.168:8000'; // ← Computer's LAN IP
  static const String _productionUrl = 'https://api.sentinelx.io'; // ← Update for prod

  // ── Computed Properties ────────────────────────────────────────────
  static String get baseUrl {
    switch (activeEnvironment) {
      case ApiEnvironment.emulator:
        return _emulatorUrl;
      case ApiEnvironment.lan:
        return _lanUrl;
      case ApiEnvironment.production:
        return _productionUrl;
    }
  }

  static String get apiBase => '$baseUrl/api/v1';

  // ── Endpoint Paths ─────────────────────────────────────────────────
  static const String authRegister = '/auth/register';
  static const String authLogin = '/auth/login';
  static const String authMe = '/auth/me';

  static const String analyzeSms = '/analyze/sms';
  static const String analyzeEmail = '/analyze/email';
  static const String analyzeCall = '/analyze/call';
  static const String transcribeAudio = '/transcribe/audio';

  static const String alerts = '/alerts';
  static String alertAcknowledge(String id) => '/alerts/$id/acknowledge';

  static const String dashboardStats = '/dashboard/stats';
  static const String dashboardThreats = '/dashboard/threats';
  static const String dashboardTrends = '/dashboard/trends';

  // ── Timeouts ───────────────────────────────────────────────────────
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 20);

  // ── Retry Configuration ────────────────────────────────────────────
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);
}
