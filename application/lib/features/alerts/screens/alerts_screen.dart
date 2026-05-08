// ============================================================
// SentinelX — Alerts Screen
// Paginated alert list with filter and acknowledge support.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/alert_models.dart';
import '../../../providers/providers.dart';
import '../../../shared/widgets/risk_badge.dart';

class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertsAsync = ref.watch(alertsProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        title: const Text('Alerts'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () =>
                ref.read(alertsProvider.notifier).load(refresh: true),
          ),
          _FilterButton(),
        ],
      ),
      body: alertsAsync.when(
        data: (data) {
          if (data.alerts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.notifications_off_outlined,
                    color: AppTheme.textMuted,
                    size: 56,
                  ),
                  const Gap(16),
                  const Text(
                    'No alerts',
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(8),
                  const Text(
                    'Your system is clean.',
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                ],
              ).animate().fadeIn(),
            );
          }

          return RefreshIndicator(
            color: AppTheme.primary,
            backgroundColor: AppTheme.backgroundCard,
            onRefresh: () =>
                ref.read(alertsProvider.notifier).load(refresh: true),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: data.alerts.length,
              separatorBuilder: (_, __) => const Gap(10),
              itemBuilder: (ctx, i) {
                final alert = data.alerts[i];
                return _AlertCard(alert: alert)
                    .animate(delay: Duration(milliseconds: i * 50))
                    .fadeIn()
                    .slideY(begin: 0.05);
              },
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppTheme.primary),
            strokeWidth: 2,
          ),
        ),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline_rounded,
                  color: AppTheme.danger, size: 48),
              const Gap(16),
              Text(
                'Failed to load alerts:\n$e',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.textSecondary),
              ),
              const Gap(16),
              OutlinedButton.icon(
                onPressed: () =>
                    ref.read(alertsProvider.notifier).load(refresh: true),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterButton extends ConsumerStatefulWidget {
  @override
  ConsumerState<_FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends ConsumerState<_FilterButton> {
  bool _unreadOnly = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: _unreadOnly ? 'Show all' : 'Show unread only',
      icon: Icon(
        _unreadOnly ? Icons.filter_alt_rounded : Icons.filter_alt_outlined,
        color: _unreadOnly ? AppTheme.primary : AppTheme.textSecondary,
      ),
      onPressed: () {
        setState(() => _unreadOnly = !_unreadOnly);
        ref.read(alertsProvider.notifier).setFilter(_unreadOnly);
      },
    );
  }
}

class _AlertCard extends ConsumerWidget {
  final AlertModel alert;
  const _AlertCard({required this.alert});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final severityColor = _severityColor(alert.severity);

    return GestureDetector(
      onTap: () => context.push('/alerts/${alert.id}'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.backgroundCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: alert.acknowledged
                ? AppTheme.borderColor
                : severityColor.withOpacity(0.5),
            width: alert.acknowledged ? 1 : 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Severity dot
            Container(
              margin: const EdgeInsets.only(top: 3),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: alert.acknowledged ? AppTheme.textMuted : severityColor,
                shape: BoxShape.circle,
                boxShadow: alert.acknowledged
                    ? null
                    : [
                        BoxShadow(
                          color: severityColor.withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 1,
                        )
                      ],
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          alert.title,
                          style: TextStyle(
                            color: alert.acknowledged
                                ? AppTheme.textSecondary
                                : AppTheme.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Gap(8),
                      _SeverityChip(severity: alert.severity),
                    ],
                  ),
                  if (alert.description != null) ...[
                    const Gap(4),
                    Text(
                      alert.description!,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('MMM d, HH:mm').format(alert.createdAt.toLocal()),
                        style: const TextStyle(
                          color: AppTheme.textMuted,
                          fontSize: 11,
                        ),
                      ),
                      if (!alert.acknowledged)
                        GestureDetector(
                          onTap: () => ref
                              .read(alertsProvider.notifier)
                              .acknowledge(alert.id),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: AppTheme.primary.withOpacity(0.4)),
                            ),
                            child: const Text(
                              'Acknowledge',
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      else
                        const Text(
                          '✓ Resolved',
                          style: TextStyle(
                            color: AppTheme.success,
                            fontSize: 11,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _severityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return AppTheme.danger;
      case 'high':
        return const Color(0xFFF97316);
      case 'warning':
        return AppTheme.warning;
      default:
        return AppTheme.info;
    }
  }
}

class _SeverityChip extends StatelessWidget {
  final String severity;
  const _SeverityChip({required this.severity});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (severity.toLowerCase()) {
      case 'critical':
        color = AppTheme.danger;
      case 'high':
        color = const Color(0xFFF97316);
      case 'warning':
        color = AppTheme.warning;
      default:
        color = AppTheme.info;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        severity.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
