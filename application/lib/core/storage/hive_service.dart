// ============================================================
// SentinelX — Hive Storage Service
// ============================================================

import 'package:hive_flutter/hive_flutter.dart';

import '../constants/app_constants.dart';

class HiveService {
  HiveService._();

  static late Box _authBox;
  static late Box _alertsBox;
  static late Box _offlineQueueBox;
  static late Box _settingsBox;
  static late Box _threatHistoryBox;

  static Future<void> init() async {
    _authBox = await Hive.openBox(AppConstants.authBox);
    _alertsBox = await Hive.openBox(AppConstants.alertsBox);
    _offlineQueueBox = await Hive.openBox(AppConstants.offlineQueueBox);
    _settingsBox = await Hive.openBox(AppConstants.settingsBox);
    _threatHistoryBox = await Hive.openBox(AppConstants.threatHistoryBox);
  }

  // ── Auth Storage ────────────────────────────────────────────────────
  static Box get authBox => _authBox;
  static Box get alertsBox => _alertsBox;
  static Box get offlineQueueBox => _offlineQueueBox;
  static Box get settingsBox => _settingsBox;
  static Box get threatHistoryBox => _threatHistoryBox;

  // ── Token Helpers ───────────────────────────────────────────────────
  static String? getToken() =>
      _authBox.get(AppConstants.keyAccessToken) as String?;

  static Future<void> saveToken(String token) async =>
      _authBox.put(AppConstants.keyAccessToken, token);

  static Future<void> saveUserJson(String json) async =>
      _authBox.put(AppConstants.keyUserJson, json);

  static String? getUserJson() =>
      _authBox.get(AppConstants.keyUserJson) as String?;

  static Future<void> clearAuth() async {
    await _authBox.delete(AppConstants.keyAccessToken);
    await _authBox.delete(AppConstants.keyUserJson);
  }

  static bool get isAuthenticated =>
      _authBox.containsKey(AppConstants.keyAccessToken) &&
      (getToken()?.isNotEmpty ?? false);

  // ── Offline Queue Helpers ───────────────────────────────────────────
  static Future<void> enqueueItem(String key, Map<String, dynamic> data) async =>
      _offlineQueueBox.put(key, data);

  static Future<void> dequeueItem(String key) async =>
      _offlineQueueBox.delete(key);

  static Map<dynamic, dynamic> get allQueuedItems => _offlineQueueBox.toMap();

  // ── Settings Helpers ────────────────────────────────────────────────
  static bool getSetting(String key, {bool defaultValue = false}) =>
      _settingsBox.get(key, defaultValue: defaultValue) as bool;

  static Future<void> setSetting(String key, dynamic value) =>
      _settingsBox.put(key, value);
}
