// ============================================================
// SentinelX — Threat Detail Screen
// Shows full AI analysis breakdown for a detected threat.
// ============================================================

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/sx_card.dart';
import '../../../shared/widgets/risk_badge.dart';

class ThreatDetailScreen extends StatelessWidget {
  final String threatId;
  const ThreatDetailScreen({super.key, required this.threatId});

  @override
  Widget build(BuildContext context) {
    // In a full implementation, this would fetch threat details by ID
    // from the dashboard repository using a FutureProvider
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        title: const Text('Threat Analysis'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Risk Score Gauge
            SxCard(
              child: Column(
                children: [
                  const Text(
                    'RISK SCORE',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 11,
                      letterSpacing: 2,
                    ),
                  ),
                  const Gap(12),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: 0.87,
                          strokeWidth: 10,
                          backgroundColor: AppTheme.borderColor,
                          valueColor: const AlwaysStoppedAnimation(AppTheme.danger),
                        ),
                      ),
                      Column(
                        children: const [
                          Text(
                            '87',
                            style: TextStyle(
                              color: AppTheme.danger,
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '/100',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(12),
                  const RiskBadge(level: 'CRITICAL'),
                ],
              ),
            ),
            const Gap(16),

            // Score breakdown
            SxCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Score Breakdown',
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  _ScoreBar(label: 'NLP Score', score: 0.91, color: AppTheme.danger),
                  const Gap(10),
                  _ScoreBar(label: 'Behavior', score: 0.78, color: AppTheme.warning),
                  const Gap(10),
                  _ScoreBar(label: 'URL Risk', score: 0.25, color: AppTheme.success),
                  const Gap(10),
                  _ScoreBar(label: 'Reputation', score: 0.60, color: const Color(0xFFF97316)),
                ],
              ),
            ),
            const Gap(16),

            // Reasons
            SxCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detection Reasons',
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(12),
                  ...const [
                    "NLP classified as 'phishing' (score: 91.0)",
                    "Urgency manipulation tactics detected (2 indicators)",
                    "Authority impersonation detected",
                    "Suspicious TLD (.xyz)",
                  ].map(
                    (reason) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.error_outline_rounded,
                            color: AppTheme.danger,
                            size: 16,
                          ),
                          const Gap(10),
                          Expanded(
                            child: Text(
                              reason,
                              style: const TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(16),

            // Classification
            SxCard(
              child: _MetaRow(
                label: 'Classification',
                value: 'phishing',
                icon: Icons.label_outline_rounded,
                valueColor: AppTheme.danger,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreBar extends StatelessWidget {
  final String label;
  final double score;
  final Color color;

  const _ScoreBar({
    required this.label,
    required this.score,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
              ),
            ),
            Text(
              '${(score * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Gap(6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: score,
            backgroundColor: AppTheme.borderColor,
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 6,
          ),
        ),
      ],
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
        Text(label,
            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? AppTheme.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
