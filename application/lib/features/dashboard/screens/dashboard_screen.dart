// ============================================================
// SentinelX — Dashboard Screen
// Main monitoring hub with KPI cards, live feed, and trend chart.
// ============================================================

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/dashboard_models.dart';
import '../../../data/models/threat_models.dart';
import '../../../providers/providers.dart';
import '../../../shared/widgets/sx_card.dart';
import '../../../shared/widgets/risk_badge.dart';
import '../../../shared/widgets/monitoring_status_indicator.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedNav = 0;

  @override
  void initState() {
    super.initState();
    // Start monitoring on first load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(monitoringProvider.notifier).startMonitoring();
    });
  }

  @override
  Widget build(BuildContext context) {
    final monitoring = ref.watch(monitoringProvider);
    final statsAsync = ref.watch(dashboardStatsProvider);
    final threatsAsync = ref.watch(recentThreatsProvider);
    final trendsAsync = ref.watch(dashboardTrendsProvider);
    final unreadCount = ref.watch(unacknowledgedCountProvider);

    // Auto-refresh ticker
    ref.watch(dashboardRefreshProvider);
    if (mounted) {
      ref.invalidate(dashboardStatsProvider);
      ref.invalidate(recentThreatsProvider);
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, monitoring, unreadCount),
            Expanded(
              child: RefreshIndicator(
                color: AppTheme.primary,
                backgroundColor: AppTheme.backgroundCard,
                onRefresh: () async {
                  ref.invalidate(dashboardStatsProvider);
                  ref.invalidate(recentThreatsProvider);
                  ref.invalidate(dashboardTrendsProvider);
                },
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    const Gap(16),
                    MonitoringStatusIndicator(state: monitoring),
                    const Gap(20),
                    _buildKpiCards(statsAsync),
                    const Gap(20),
                    _buildTrendChart(trendsAsync),
                    const Gap(20),
                    _buildRecentThreats(threatsAsync),
                    const Gap(24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, unreadCount),
    );
  }

  Widget _buildHeader(BuildContext context, MonitoringState monitoring, AsyncValue<int> unread) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 16, 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.borderColor)),
      ),
      child: Row(
        children: [
          const Icon(Icons.shield_rounded, color: AppTheme.primary, size: 24),
          const Gap(8),
          const Text(
            'SentinelX',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          // Monitoring pulse
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: (monitoring.isActive ? AppTheme.success : AppTheme.textMuted)
                  .withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: monitoring.isActive ? AppTheme.success : AppTheme.textMuted,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PulseDot(active: monitoring.isActive),
                const Gap(6),
                Text(
                  monitoring.isActive ? 'ACTIVE' : 'INACTIVE',
                  style: TextStyle(
                    color: monitoring.isActive ? AppTheme.success : AppTheme.textMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          )
              .animate(onPlay: (c) => c.repeat())
              .shimmer(duration: 2.seconds, color: AppTheme.success.withOpacity(0.1)),
          const Gap(8),
          // Alerts badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: AppTheme.textSecondary),
                onPressed: () => context.push(AppRoutes.alerts),
              ),
              unread.when(
                data: (count) => count > 0
                    ? Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: AppTheme.danger,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              count > 9 ? '9+' : '$count',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKpiCards(AsyncValue<DashboardStats> statsAsync) {
    return statsAsync.when(
      data: (stats) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _KpiCard(
                label: 'Total Threats',
                value: '${stats.totalThreats}',
                icon: Icons.security_outlined,
                color: AppTheme.primary,
              ).animate().fadeIn(delay: 100.ms),
              _KpiCard(
                label: 'Critical',
                value: '${stats.criticalAlerts}',
                icon: Icons.warning_amber_rounded,
                color: AppTheme.danger,
              ).animate().fadeIn(delay: 150.ms),
              _KpiCard(
                label: 'Today',
                value: '${stats.threatsToday}',
                icon: Icons.today_outlined,
                color: AppTheme.warning,
              ).animate().fadeIn(delay: 200.ms),
              _KpiCard(
                label: 'Avg Risk',
                value: '${stats.avgRiskScore.toStringAsFixed(1)}',
                icon: Icons.analytics_outlined,
                color: AppTheme.secondary,
              ).animate().fadeIn(delay: 250.ms),
            ],
          ),
        ],
      ),
      loading: () => _buildKpiSkeleton(),
      error: (e, _) => Center(
        child: Text('Failed to load stats: $e',
            style: const TextStyle(color: AppTheme.danger)),
      ),
    );
  }

  Widget _buildKpiSkeleton() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: List.generate(
        4,
        (_) => Container(
          decoration: BoxDecoration(
            color: AppTheme.backgroundCard,
            borderRadius: BorderRadius.circular(16),
          ),
        )
            .animate(onPlay: (c) => c.repeat())
            .shimmer(duration: 1.seconds, color: AppTheme.backgroundElevated),
      ),
    );
  }

  Widget _buildTrendChart(AsyncValue<DashboardTrends> trendsAsync) {
    return trendsAsync.when(
      data: (trends) {
        if (trends.trends.isEmpty) return const SizedBox.shrink();

        final spots = trends.trends.asMap().entries.map((e) {
          return FlSpot(e.key.toDouble(), e.value.count.toDouble());
        }).toList();

        return SxCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '7-Day Threat Trend',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(20),
              SizedBox(
                height: 140,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (_) => FlLine(
                        color: AppTheme.borderColor,
                        strokeWidth: 1,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitlesWidget: (value, _) => Text(
                            '${value.toInt()}',
                            style: const TextStyle(
                              color: AppTheme.textMuted,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 24,
                          getTitlesWidget: (value, _) {
                            final idx = value.toInt();
                            if (idx >= trends.trends.length) {
                              return const SizedBox.shrink();
                            }
                            final date = trends.trends[idx].date;
                            try {
                              final parsed = DateTime.parse(date);
                              return Text(
                                DateFormat('d/M').format(parsed),
                                style: const TextStyle(
                                  color: AppTheme.textMuted,
                                  fontSize: 10,
                                ),
                              );
                            } catch (_) {
                              return Text(
                                date.length > 5 ? date.substring(5) : date,
                                style: const TextStyle(
                                  color: AppTheme.textMuted,
                                  fontSize: 10,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        color: AppTheme.primary,
                        barWidth: 2,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: AppTheme.primary.withOpacity(0.08),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 300.ms);
      },
      loading: () => Container(
        height: 180,
        decoration: BoxDecoration(
          color: AppTheme.backgroundCard,
          borderRadius: BorderRadius.circular(16),
        ),
      )
          .animate(onPlay: (c) => c.repeat())
          .shimmer(duration: 1.seconds, color: AppTheme.backgroundElevated),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildRecentThreats(AsyncValue<ThreatListResponse> threatsAsync) {
    return threatsAsync.when(
      data: (data) {
        if (data.threats.isEmpty) {
          return SxCard(
            child: Column(
              children: const [
                Icon(Icons.check_circle_outline_rounded,
                    color: AppTheme.success, size: 40),
                Gap(12),
                Text(
                  'No threats detected',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(4),
                Text(
                  'Your system is secure',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Threats',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () => context.push(AppRoutes.alerts),
                  child: const Text('View all'),
                ),
              ],
            ),
            const Gap(8),
            ...data.threats.take(5).map((t) => _ThreatListItem(threat: t)),
          ],
        );
      },
      loading: () => Column(
        children: List.generate(
          3,
          (i) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 72,
            decoration: BoxDecoration(
              color: AppTheme.backgroundCard,
              borderRadius: BorderRadius.circular(12),
            ),
          )
              .animate(onPlay: (c) => c.repeat())
              .shimmer(duration: 1.seconds, color: AppTheme.backgroundElevated),
        ),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildBottomNav(BuildContext context, AsyncValue<int> unread) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppTheme.borderColor)),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedNav,
        onTap: (i) {
          setState(() => _selectedNav = i);
          switch (i) {
            case 0:
              break; // Already on dashboard
            case 1:
              context.push(AppRoutes.alerts);
            case 2:
              context.push(AppRoutes.settings);
          }
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: unread.value != null && unread.value! > 0
                  ? Text('${unread.value}')
                  : null,
              child: const Icon(Icons.notifications_outlined),
            ),
            activeIcon: const Icon(Icons.notifications_rounded),
            label: 'Alerts',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// ── Sub-Widgets ───────────────────────────────────────────────────────────────

class _PulseDot extends StatelessWidget {
  final bool active;
  const _PulseDot({required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: active ? AppTheme.success : AppTheme.textMuted,
        shape: BoxShape.circle,
        boxShadow: active
            ? [
                BoxShadow(
                  color: AppTheme.success.withOpacity(0.6),
                  blurRadius: 6,
                  spreadRadius: 1,
                )
              ]
            : null,
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _KpiCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 22),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ThreatListItem extends StatelessWidget {
  final dynamic threat;
  const _ThreatListItem({required this.threat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          _channelIcon(threat.channel as String),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  threat.sender ?? 'Unknown Sender',
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(2),
                Text(
                  _formatDate(threat.createdAt as DateTime),
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          RiskBadge(level: threat.threatLevel as String),
        ],
      ),
    );
  }

  Widget _channelIcon(String channel) {
    IconData icon;
    Color color;
    switch (channel.toLowerCase()) {
      case 'sms':
        icon = Icons.sms_outlined;
        color = AppTheme.primary;
      case 'call':
        icon = Icons.call_outlined;
        color = AppTheme.secondary;
      default:
        icon = Icons.notifications_outlined;
        color = AppTheme.warning;
    }
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 18),
    );
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return DateFormat('MMM d').format(dt);
  }
}
