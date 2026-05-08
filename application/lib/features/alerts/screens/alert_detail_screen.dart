// ============================================================
// SentinelX — Alert Detail Screen
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/alert_models.dart';
import '../../../providers/providers.dart';
import '../../../shared/widgets/sx_card.dart';

class AlertDetailScreen extends ConsumerWidget {
  final String alertId;
  const AlertDetailScreen({super.key, required this.alertId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertsAsync = ref.watch(alertsProvider);

    final alert = alertsAsync.value?.alerts
        .firstWhereOrNull((a) => a.id == alertId);

    if (alert == null) {
      return Scaffold(
        backgroundColor: AppTheme.backgroundDark,
        appBar: AppBar(title: const Text('Alert Detail')),
        body: const Center(
          child: Text('Alert not found',
              style: TextStyle(color: AppTheme.textSecondary)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        title: const Text('Alert Detail'),
        actions: [
          if (!alert.acknowledged)
            TextButton(
              onPressed: () {
                ref.read(alertsProvider.notifier).acknowledge(alert.id);
                Navigator.pop(context);
              },
              child: const Text('Acknowledge'),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Severity banner
            _SeverityBanner(severity: alert.severity),
            const Gap(20),
            // Title
            SxCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          color: AppTheme.warning, size: 18),
                      const Gap(8),
                      const Text(
                        'Alert',
                        style: TextStyle(
                            color: AppTheme.textSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Text(
                    alert.title,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (alert.description != null) ...[
                    const Gap(8),
                    Text(
                      alert.description!,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Gap(16),
            // Metadata
            SxCard(
              child: Column(
                children: [
                  _MetaRow(
                    label: 'Alert ID',
                    value: alert.id.substring(0, 8).toUpperCase(),
                    icon: Icons.tag_rounded,
                  ),
                  const Divider(color: AppTheme.dividerColor, height: 20),
                  _MetaRow(
                    label: 'Created',
                    value: DateFormat('MMM d, yyyy HH:mm')
                        .format(alert.createdAt.toLocal()),
                    icon: Icons.schedule_rounded,
                  ),
                  const Divider(color: AppTheme.dividerColor, height: 20),
                  _MetaRow(
                    label: 'Status',
                    value: alert.acknowledged ? 'Acknowledged' : 'Unacknowledged',
                    icon: alert.acknowledged
                        ? Icons.check_circle_outline_rounded
                        : Icons.radio_button_unchecked_rounded,
                    valueColor: alert.acknowledged
                        ? AppTheme.success
                        : AppTheme.warning,
                  ),
                  if (alert.acknowledgedAt != null) ...[
                    const Divider(color: AppTheme.dividerColor, height: 20),
                    _MetaRow(
                      label: 'Resolved At',
                      value: DateFormat('MMM d, yyyy HH:mm')
                          .format(alert.acknowledgedAt!.toLocal()),
                      icon: Icons.verified_outlined,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeverityBanner extends StatelessWidget {
  final String severity;
  const _SeverityBanner({required this.severity});

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;
    switch (severity.toLowerCase()) {
      case 'critical':
        color = AppTheme.danger;
        icon = Icons.dangerous_rounded;
      case 'high':
        color = const Color(0xFFF97316);
        icon = Icons.warning_rounded;
      case 'warning':
        color = AppTheme.warning;
        icon = Icons.warning_amber_rounded;
      default:
        color = AppTheme.info;
        icon = Icons.info_outline_rounded;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.4), width: 1.5),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const Gap(14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${severity.toUpperCase()} SEVERITY',
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const Gap(2),
              Text(
                'Threat requires immediate attention',
                style: TextStyle(
                  color: color.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;

  const _MetaRow({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.textMuted, size: 16),
        const Gap(10),
        Text(
          label,
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? AppTheme.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

extension IterableExt<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final e in this) {
      if (test(e)) return e;
    }
    return null;
  }
}
