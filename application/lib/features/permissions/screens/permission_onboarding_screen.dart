// ============================================================
// SentinelX — Permission Onboarding Screen
// 3-step guided permission setup flow.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/providers.dart';
import '../../../shared/widgets/sx_button.dart';

class PermissionOnboardingScreen extends ConsumerStatefulWidget {
  const PermissionOnboardingScreen({super.key});

  @override
  ConsumerState<PermissionOnboardingScreen> createState() =>
      _PermissionOnboardingScreenState();
}

class _PermissionOnboardingScreenState
    extends ConsumerState<PermissionOnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  final _steps = const [
    _PermStep(
      icon: Icons.sms_outlined,
      color: AppTheme.primary,
      title: 'SMS & Phone Access',
      description:
          'SentinelX needs to read incoming SMS messages and detect phone calls to protect you from OTP scams and phishing calls.',
      bullets: [
        'Detect fraudulent OTP requests',
        'Identify phishing SMS messages',
        'Monitor suspicious caller patterns',
      ],
    ),
    _PermStep(
      icon: Icons.notifications_active_outlined,
      color: AppTheme.secondary,
      title: 'Notification Access',
      description:
          'Grant notification access to monitor messages from WhatsApp, Telegram, and banking apps for social engineering attacks.',
      bullets: [
        'Monitor WhatsApp & Telegram threats',
        'Detect banking app scam attempts',
        'Alert on suspicious message patterns',
      ],
    ),
    _PermStep(
      icon: Icons.battery_charging_full_rounded,
      color: AppTheme.success,
      title: 'Background Monitoring',
      description:
          'Allow SentinelX to run in the background to protect you 24/7, even when the app is not open.',
      bullets: [
        'Continuous threat monitoring',
        'Real-time scam detection',
        'Instant alert delivery',
      ],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handleAction() async {
    final permNotifier = ref.read(permissionProvider.notifier);
    switch (_currentPage) {
      case 0:
        await permNotifier.requestSms();
        await permNotifier.requestPhone();
        await permNotifier.requestNotification();
        _goNext();
      case 1:
        await permNotifier.openNotificationListenerSettings();
        _goNext();
      case 2:
        // Battery optimization — open settings
        _goNext();
    }
  }

  void _goNext() {
    if (_currentPage < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // All steps done — go to dashboard
      context.go(AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    final perms = ref.watch(permissionProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Progress dots
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _steps.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == _currentPage ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == _currentPage
                        ? AppTheme.primary
                        : AppTheme.borderColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const Gap(8),
            Text(
              'Step ${_currentPage + 1} of ${_steps.length}',
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
              ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _steps.length,
                itemBuilder: (_, i) => _StepPage(step: _steps[i]),
              ),
            ),

            // Action button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Column(
                children: [
                  SxButton(
                    label: _currentPage < _steps.length - 1
                        ? 'Grant Permission & Continue'
                        : 'Start Monitoring',
                    onPressed: _handleAction,
                    icon: _currentPage < _steps.length - 1
                        ? Icons.arrow_forward_rounded
                        : Icons.security_rounded,
                  ),
                  const Gap(12),
                  if (_currentPage < _steps.length - 1)
                    TextButton(
                      onPressed: _goNext,
                      child: const Text(
                        'Skip for now',
                        style: TextStyle(color: AppTheme.textMuted),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepPage extends StatelessWidget {
  final _PermStep step;
  const _StepPage({required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: step.color.withOpacity(0.12),
              boxShadow: [
                BoxShadow(
                  color: step.color.withOpacity(0.25),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(step.icon, color: step.color, size: 48),
          )
              .animate(key: ValueKey(step.title))
              .fadeIn(duration: 400.ms)
              .scale(begin: const Offset(0.7, 0.7)),
          const Gap(36),
          Text(
            step.title,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.1),
          const Gap(14),
          Text(
            step.description,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 14,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ).animate(delay: 150.ms).fadeIn(),
          const Gap(28),
          // Bullets
          ...step.bullets.asMap().entries.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: step.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Gap(12),
                  Text(
                    e.value,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ).animate(delay: Duration(milliseconds: 200 + e.key * 60)).fadeIn(),
            );
          }),
        ],
      ),
    );
  }
}

class _PermStep {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final List<String> bullets;

  const _PermStep({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    required this.bullets,
  });
}
