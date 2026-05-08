// ============================================================
// SentinelX — Settings Screen
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/config/api_config.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/providers.dart';
import '../../../shared/widgets/sx_card.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final settings = ref.watch(appSettingsProvider);
    final permissions = ref.watch(permissionProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User profile card
          if (auth.user != null)
            SxCard(
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        auth.user!.name.isNotEmpty
                            ? auth.user!.name[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          color: AppTheme.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const Gap(14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          auth.user!.name,
                          style: const TextStyle(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          auth.user!.email,
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.secondary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      auth.user!.role.toUpperCase(),
                      style: const TextStyle(
                        color: AppTheme.secondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const Gap(20),

          // Monitoring settings
          _SectionLabel('Monitoring'),
          const Gap(10),
          SxCard(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.sms_outlined,
                  label: 'SMS Monitoring',
                  subtitle: 'Detect scam SMS messages',
                  value: settings.smsMonitoringEnabled,
                  onChanged: (v) =>
                      ref.read(appSettingsProvider.notifier).toggle('sms', v),
                ),
                const Divider(color: AppTheme.dividerColor, height: 1),
                _SettingsTile(
                  icon: Icons.call_outlined,
                  label: 'Call Monitoring',
                  subtitle: 'Detect suspicious callers',
                  value: settings.callMonitoringEnabled,
                  onChanged: (v) =>
                      ref.read(appSettingsProvider.notifier).toggle('call', v),
                ),
                const Divider(color: AppTheme.dividerColor, height: 1),
                _SettingsTile(
                  icon: Icons.notifications_outlined,
                  label: 'Notification Monitor',
                  subtitle: 'Watch WhatsApp, Telegram, etc.',
                  value: settings.notificationMonitoringEnabled,
                  onChanged: (v) => ref
                      .read(appSettingsProvider.notifier)
                      .toggle('notification_monitor', v),
                ),
                const Divider(color: AppTheme.dividerColor, height: 1),
                _SettingsTile(
                  icon: Icons.settings_suggest_outlined,
                  label: 'Background Service',
                  subtitle: 'Keep monitoring when app is closed',
                  value: settings.backgroundMonitoringEnabled,
                  onChanged: (v) => ref
                      .read(appSettingsProvider.notifier)
                      .toggle('background', v),
                ),
              ],
            ),
          ),
          const Gap(20),

          // Permissions status
          _SectionLabel('Permissions'),
          const Gap(10),
          SxCard(
            child: Column(
              children: [
                _PermissionTile(
                  icon: Icons.sms_outlined,
                  label: 'SMS Access',
                  granted: permissions.sms,
                ),
                const Divider(color: AppTheme.dividerColor, height: 1),
                _PermissionTile(
                  icon: Icons.phone_outlined,
                  label: 'Phone State',
                  granted: permissions.phone,
                ),
                const Divider(color: AppTheme.dividerColor, height: 1),
                _PermissionTile(
                  icon: Icons.notifications_outlined,
                  label: 'Notifications',
                  granted: permissions.notification,
                ),
                const Divider(color: AppTheme.dividerColor, height: 1),
                _PermissionTile(
                  icon: Icons.apps_outlined,
                  label: 'Notification Listener',
                  granted: permissions.notificationListener,
                ),
              ],
            ),
          ),
          const Gap(12),
          OutlinedButton.icon(
            onPressed: () => context.push(AppRoutes.permissions),
            icon: const Icon(Icons.refresh_rounded, size: 16),
            label: const Text('Re-run Permission Setup'),
          ),
          const Gap(20),

          // Backend info
          _SectionLabel('Backend'),
          const Gap(10),
          SxCard(
            child: Column(
              children: [
                _InfoTile(
                  icon: Icons.dns_outlined,
                  label: 'Server',
                  value: ApiConfig.baseUrl,
                ),
                const Divider(color: AppTheme.dividerColor, height: 1),
                _InfoTile(
                  icon: Icons.settings_ethernet_rounded,
                  label: 'Environment',
                  value: ApiConfig.activeEnvironment.name.toUpperCase(),
                ),
              ],
            ),
          ),
          const Gap(20),

          // App info
          _SectionLabel('About'),
          const Gap(10),
          SxCard(
            child: Column(
              children: [
                _InfoTile(
                  icon: Icons.shield_outlined,
                  label: 'App Version',
                  value: '1.0.0',
                ),
                const Divider(color: AppTheme.dividerColor, height: 1),
                _InfoTile(
                  icon: Icons.code_rounded,
                  label: 'Platform',
                  value: 'Android',
                ),
              ],
            ),
          ),
          const Gap(24),

          // Logout
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.danger,
              side: const BorderSide(color: AppTheme.danger),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) context.go(AppRoutes.login);
            },
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Sign Out'),
          ),
          const Gap(32),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
        color: AppTheme.textMuted,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: AppTheme.textSecondary, size: 20),
        title: Text(label,
            style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14)),
        subtitle: Text(subtitle,
            style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
        trailing: Switch(value: value, onChanged: onChanged),
        dense: true,
      ),
    );
  }
}

class _PermissionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool granted;

  const _PermissionTile({
    required this.icon,
    required this.label,
    required this.granted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.textSecondary, size: 18),
          const Gap(12),
          Expanded(
            child: Text(label,
                style:
                    const TextStyle(color: AppTheme.textPrimary, fontSize: 13)),
          ),
          Icon(
            granted ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: granted ? AppTheme.success : AppTheme.danger,
            size: 18,
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.textMuted, size: 16),
          const Gap(12),
          Text(label,
              style:
                  const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}
