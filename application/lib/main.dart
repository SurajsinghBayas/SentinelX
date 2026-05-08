// ============================================================
// SentinelX — Application Entry Point
// ============================================================

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/config/api_config.dart';
import 'core/router/app_router.dart';
import 'core/services/fcm_service.dart';
import 'core/storage/hive_service.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style (dark status bar)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppTheme.backgroundDark,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize Hive local storage
  await Hive.initFlutter();
  await HiveService.init();

  // Initialize Firebase (FCM)
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FcmService.init();
  } catch (e) {
    // Firebase not configured yet — FCM disabled, app continues
    debugPrint('[SentinelX] Firebase init skipped: $e');
  }

  debugPrint('[SentinelX] Starting app. Backend: ${ApiConfig.baseUrl}');

  runApp(
    const ProviderScope(
      child: SentinelXApp(),
    ),
  );
}

class SentinelXApp extends ConsumerWidget {
  const SentinelXApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'SentinelX',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
