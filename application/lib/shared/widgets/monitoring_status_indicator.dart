import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/providers.dart';

class MonitoringStatusIndicator extends StatelessWidget {
  final MonitoringState state;
  const MonitoringStatusIndicator({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: state.isActive
            ? AppTheme.success.withOpacity(0.07)
            : AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: state.isActive
              ? AppTheme.success.withOpacity(0.3)
              : AppTheme.borderColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (state.isActive ? AppTheme.success : AppTheme.textMuted)
                  .withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              state.isActive ? Icons.radar_rounded : Icons.security_outlined,
              color: state.isActive ? AppTheme.success : AppTheme.textMuted,
              size: 20,
            ),
          )
              .animate(
                onPlay: (c) => state.isActive ? c.repeat() : c.stop(),
              )
              .shimmer(
                duration: 2.seconds,
                color: AppTheme.success.withOpacity(0.2),
              ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.isActive
                      ? 'Monitoring Active'
                      : 'Monitoring Inactive',
                  style: TextStyle(
                    color: state.isActive ? AppTheme.success : AppTheme.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(2),
                Text(
                  state.isActive
                      ? 'SMS · Calls · Notifications'
                      : 'Tap to start protection',
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Live event count badge
          if (state.isActive && state.recentEvents.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${state.recentEvents.length} events',
                style: const TextStyle(
                  color: AppTheme.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
