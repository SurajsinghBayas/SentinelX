// ============================================================
// SentinelX — App Router (GoRouter + Auth Guards)
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/alerts/screens/alert_detail_screen.dart';
import '../../features/alerts/screens/alerts_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/permissions/screens/permission_onboarding_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/threats/screens/threat_detail_screen.dart';
import '../../providers/providers.dart';

// Route name constants
class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const permissions = '/permissions';
  static const dashboard = '/dashboard';
  static const alerts = '/alerts';
  static const alertDetail = '/alerts/:id';
  static const threats = '/threats';
  static const threatDetail = '/threats/:id';
  static const settings = '/settings';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final permissionState = ref.watch(permissionProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthenticated =
          authState.status == AuthStatus.authenticated;
      final isLoading = authState.status == AuthStatus.initial ||
          authState.status == AuthStatus.loading;

      // Don't redirect while loading
      if (isLoading) return null;

      final location = state.matchedLocation;

      // Not authenticated — send to login
      if (!isAuthenticated) {
        if (location == AppRoutes.login || location == AppRoutes.register) {
          return null;
        }
        return AppRoutes.login;
      }

      // Authenticated but missing core permissions — send to onboarding
      if (!permissionState.allCoreGranted &&
          location != AppRoutes.permissions) {
        return AppRoutes.permissions;
      }

      // Authenticated + on login/splash → send to dashboard
      if (location == AppRoutes.login ||
          location == AppRoutes.register ||
          location == AppRoutes.splash) {
        return AppRoutes.dashboard;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, __) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.permissions,
        builder: (_, __) => const PermissionOnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (_, __) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.alerts,
        builder: (_, __) => const AlertsScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (_, state) =>
                AlertDetailScreen(alertId: state.pathParameters['id']!),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.threats,
        builder: (_, __) => const AlertsScreen(), // reuses alerts screen filtered by threats
        routes: [
          GoRoute(
            path: ':id',
            builder: (_, state) =>
                ThreatDetailScreen(threatId: state.pathParameters['id']!),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (_, __) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (_, state) => Scaffold(
      body: Center(
        child: Text('Route not found: ${state.error}'),
      ),
    ),
  );
});
