// ============================================================
// SentinelX — All Riverpod Providers
// Single file for all provider declarations to prevent circular
// imports and make provider graph easy to reason about.
// ============================================================

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasources/remote/alerts_remote_datasource.dart';
import '../data/datasources/remote/analyze_remote_datasource.dart';
import '../data/datasources/remote/auth_remote_datasource.dart';
import '../data/datasources/remote/dashboard_remote_datasource.dart';
import '../data/models/alert_models.dart';
import '../data/models/auth_models.dart';
import '../data/models/dashboard_models.dart';
import '../data/models/threat_models.dart';
import '../data/repositories/alerts_repository.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/dashboard_repository.dart';
import '../data/repositories/threat_repository.dart';
import '../core/permissions/permission_service.dart';
import '../core/services/monitoring_channel_service.dart';
import '../core/constants/app_constants.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

// ============================================================
// DATASOURCE PROVIDERS
// ============================================================

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (_) => AuthRemoteDataSourceImpl(),
);

final analyzeRemoteDataSourceProvider = Provider<AnalyzeRemoteDataSource>(
  (_) => AnalyzeRemoteDataSourceImpl(),
);

final alertsRemoteDataSourceProvider = Provider<AlertsRemoteDataSource>(
  (_) => AlertsRemoteDataSourceImpl(),
);

final dashboardRemoteDataSourceProvider = Provider<DashboardRemoteDataSource>(
  (_) => DashboardRemoteDataSourceImpl(),
);

// ============================================================
// REPOSITORY PROVIDERS
// ============================================================

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    dataSource: ref.watch(authRemoteDataSourceProvider),
  ),
);

final threatRepositoryProvider = Provider<ThreatRepository>(
  (ref) => ThreatRepositoryImpl(
    dataSource: ref.watch(analyzeRemoteDataSourceProvider),
  ),
);

final alertsRepositoryProvider = Provider<AlertsRepository>(
  (ref) => AlertsRepositoryImpl(
    dataSource: ref.watch(alertsRemoteDataSourceProvider),
  ),
);

final dashboardRepositoryProvider = Provider<DashboardRepository>(
  (ref) => DashboardRepositoryImpl(
    dataSource: ref.watch(dashboardRemoteDataSourceProvider),
  ),
);

// ============================================================
// AUTH PROVIDERS
// ============================================================

class AuthState {
  final AuthStatus status;
  final UserModel? user;
  final String? error;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    String? error,
  }) =>
      AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
        error: error ?? this.error,
      );
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repo;

  AuthNotifier(this._repo) : super(const AuthState()) {
    _init();
  }

  void _init() {
    if (_repo.isAuthenticated) {
      final user = _repo.getCachedUser();
      state = AuthState(
        status: AuthStatus.authenticated,
        user: user,
      );
    } else {
      state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final user = await _repo.login(email, password);
      state = AuthState(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        error: e.toString(),
      );
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repo.register(name: name, email: email, password: password);
      // After register, login automatically
      await login(email, password);
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        error: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  void clearError() {
    state = state.copyWith(status: AuthStatus.unauthenticated, error: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(authRepositoryProvider)),
);

// ============================================================
// DASHBOARD PROVIDERS
// ============================================================

final dashboardStatsProvider = FutureProvider.autoDispose<DashboardStats>(
  (ref) async {
    final repo = ref.watch(dashboardRepositoryProvider);
    return repo.getStats();
  },
);

final recentThreatsProvider =
    FutureProvider.autoDispose<ThreatListResponse>((ref) async {
  final repo = ref.watch(dashboardRepositoryProvider);
  return repo.getThreats(limit: AppConstants.threatsPageSize);
});

final dashboardTrendsProvider =
    FutureProvider.autoDispose<DashboardTrends>((ref) async {
  final repo = ref.watch(dashboardRepositoryProvider);
  return repo.getTrends(days: AppConstants.chartDays);
});

// Auto-refresh provider — refreshes dashboard every 30s
final dashboardRefreshProvider = StreamProvider.autoDispose<int>((ref) {
  return Stream.periodic(AppConstants.dashboardRefreshInterval, (i) => i);
});

// ============================================================
// ALERTS PROVIDERS
// ============================================================

class AlertsNotifier extends StateNotifier<AsyncValue<AlertListResponse>> {
  final AlertsRepository _repo;

  AlertsNotifier(this._repo) : super(const AsyncValue.loading()) {
    load();
  }

  bool _unacknowledgedOnly = false;
  int _skip = 0;

  Future<void> load({bool refresh = false}) async {
    if (refresh) _skip = 0;
    try {
      state = const AsyncValue.loading();
      final result = await _repo.listAlerts(
        skip: _skip,
        limit: AppConstants.alertsPageSize,
        unacknowledgedOnly: _unacknowledgedOnly,
      );
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> acknowledge(String alertId) async {
    await _repo.acknowledgeAlert(alertId);
    await load(refresh: true);
  }

  void setFilter(bool unacknowledgedOnly) {
    _unacknowledgedOnly = unacknowledgedOnly;
    load(refresh: true);
  }
}

final alertsProvider =
    StateNotifierProvider.autoDispose<AlertsNotifier, AsyncValue<AlertListResponse>>(
  (ref) => AlertsNotifier(ref.watch(alertsRepositoryProvider)),
);

final unacknowledgedCountProvider = FutureProvider.autoDispose<int>((ref) async {
  final repo = ref.watch(alertsRepositoryProvider);
  final result = await repo.listAlerts(unacknowledgedOnly: true, limit: 1);
  return result.total;
});

// ============================================================
// PERMISSIONS PROVIDER
// ============================================================

class PermissionNotifier extends StateNotifier<PermissionBundle> {
  PermissionNotifier()
      : super(const PermissionBundle(
          sms: false,
          phone: false,
          notification: false,
          notificationListener: false,
        )) {
    checkAll();
  }

  Future<void> checkAll() async {
    final bundle = await PermissionService.checkAll();
    state = bundle;
  }

  Future<void> requestSms() async {
    await PermissionService.requestSms();
    await checkAll();
  }

  Future<void> requestPhone() async {
    await PermissionService.requestPhone();
    await checkAll();
  }

  Future<void> requestNotification() async {
    await PermissionService.requestNotification();
    await checkAll();
  }

  Future<void> openNotificationListenerSettings() async {
    await PermissionService.openNotificationListenerSettings();
  }
}

final permissionProvider =
    StateNotifierProvider<PermissionNotifier, PermissionBundle>(
  (_) => PermissionNotifier(),
);

// ============================================================
// MONITORING PROVIDERS
// ============================================================

class MonitoringState {
  final bool isActive;
  final bool smsMonitoring;
  final bool callMonitoring;
  final bool notificationMonitoring;
  final List<Map<String, dynamic>> recentEvents;

  const MonitoringState({
    this.isActive = false,
    this.smsMonitoring = false,
    this.callMonitoring = false,
    this.notificationMonitoring = false,
    this.recentEvents = const [],
  });

  MonitoringState copyWith({
    bool? isActive,
    bool? smsMonitoring,
    bool? callMonitoring,
    bool? notificationMonitoring,
    List<Map<String, dynamic>>? recentEvents,
  }) =>
      MonitoringState(
        isActive: isActive ?? this.isActive,
        smsMonitoring: smsMonitoring ?? this.smsMonitoring,
        callMonitoring: callMonitoring ?? this.callMonitoring,
        notificationMonitoring:
            notificationMonitoring ?? this.notificationMonitoring,
        recentEvents: recentEvents ?? this.recentEvents,
      );
}

class MonitoringNotifier extends StateNotifier<MonitoringState> {
  MonitoringNotifier() : super(const MonitoringState());

  StreamSubscription<Map<String, dynamic>>? _smsSub;
  StreamSubscription<Map<String, dynamic>>? _callSub;
  StreamSubscription<Map<String, dynamic>>? _notifSub;

  final ThreatRepository _threatRepo = ThreatRepositoryImpl();

  Future<void> startMonitoring() async {
    await MonitoringChannelService.startMonitoringService();

    _smsSub = MonitoringChannelService.smsStream.listen(_onSmsEvent);
    _callSub = MonitoringChannelService.callStream.listen(_onCallEvent);
    _notifSub =
        MonitoringChannelService.notificationStream.listen(_onNotifEvent);

    state = state.copyWith(
      isActive: true,
      smsMonitoring: true,
      callMonitoring: true,
      notificationMonitoring: true,
    );
  }

  Future<void> stopMonitoring() async {
    await MonitoringChannelService.stopMonitoringService();
    await _smsSub?.cancel();
    await _callSub?.cancel();
    await _notifSub?.cancel();
    state = const MonitoringState();
  }

  void _addEvent(Map<String, dynamic> event) {
    final events = [event, ...state.recentEvents].take(50).toList();
    state = state.copyWith(recentEvents: events);
  }

  Future<void> _onSmsEvent(Map<String, dynamic> event) async {
    _addEvent(event);
    try {
      final result = await _threatRepo.analyzeSms(
        sender: event['sender'] as String? ?? 'Unknown',
        message: event['message'] as String? ?? '',
      );
      if (result.threatDetected && result.riskScore >= 61) {
        _triggerAlert(result, 'SMS');
      }
    } catch (_) {}
  }

  Future<void> _onCallEvent(Map<String, dynamic> event) async {
    _addEvent(event);
    // Only analyze ended calls with sufficient duration
    if (event['event'] == 'ended') {
      final duration = (event['durationSeconds'] as int?) ?? 0;
      if (duration >= 10) {
        // future: send transcript after audio upload feature
      }
    }
  }

  Future<void> _onNotifEvent(Map<String, dynamic> event) async {
    _addEvent(event);
    final body = event['body'] as String? ?? '';
    final title = event['title'] as String? ?? '';
    if (body.length < 5 && title.length < 5) return;

    try {
      // Analyze notification as SMS-style message
      final result = await _threatRepo.analyzeSms(
        sender: event['appName'] as String? ?? event['packageName'] as String? ?? 'App',
        message: '$title $body'.trim(),
      );
      if (result.threatDetected && result.riskScore >= 61) {
        _triggerAlert(result, event['appName'] as String? ?? 'App');
      }
    } catch (_) {}
  }

  void _triggerAlert(dynamic result, String source) {
    // FCM / local notification handled by FcmService
    // This is purely state update for UI
  }

  @override
  void dispose() {
    _smsSub?.cancel();
    _callSub?.cancel();
    _notifSub?.cancel();
    super.dispose();
  }
}

final monitoringProvider =
    StateNotifierProvider<MonitoringNotifier, MonitoringState>(
  (_) => MonitoringNotifier(),
);

// ============================================================
// SETTINGS PROVIDER
// ============================================================

class AppSettings {
  final bool notificationsEnabled;
  final bool backgroundMonitoringEnabled;
  final bool smsMonitoringEnabled;
  final bool callMonitoringEnabled;
  final bool notificationMonitoringEnabled;
  final bool biometricEnabled;

  const AppSettings({
    this.notificationsEnabled = true,
    this.backgroundMonitoringEnabled = true,
    this.smsMonitoringEnabled = true,
    this.callMonitoringEnabled = true,
    this.notificationMonitoringEnabled = true,
    this.biometricEnabled = false,
  });

  AppSettings copyWith({
    bool? notificationsEnabled,
    bool? backgroundMonitoringEnabled,
    bool? smsMonitoringEnabled,
    bool? callMonitoringEnabled,
    bool? notificationMonitoringEnabled,
    bool? biometricEnabled,
  }) =>
      AppSettings(
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        backgroundMonitoringEnabled:
            backgroundMonitoringEnabled ?? this.backgroundMonitoringEnabled,
        smsMonitoringEnabled: smsMonitoringEnabled ?? this.smsMonitoringEnabled,
        callMonitoringEnabled:
            callMonitoringEnabled ?? this.callMonitoringEnabled,
        notificationMonitoringEnabled:
            notificationMonitoringEnabled ?? this.notificationMonitoringEnabled,
        biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      );
}

final appSettingsProvider =
    StateNotifierProvider<AppSettingsNotifier, AppSettings>(
  (_) => AppSettingsNotifier(),
);

class AppSettingsNotifier extends StateNotifier<AppSettings> {
  AppSettingsNotifier() : super(const AppSettings());

  void toggle(String key, bool value) {
    state = switch (key) {
      'notifications' => state.copyWith(notificationsEnabled: value),
      'background' => state.copyWith(backgroundMonitoringEnabled: value),
      'sms' => state.copyWith(smsMonitoringEnabled: value),
      'call' => state.copyWith(callMonitoringEnabled: value),
      'notification_monitor' =>
        state.copyWith(notificationMonitoringEnabled: value),
      'biometric' => state.copyWith(biometricEnabled: value),
      _ => state,
    };
  }
}
