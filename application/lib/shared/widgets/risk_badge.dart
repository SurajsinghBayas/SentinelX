import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class RiskBadge extends StatelessWidget {
  final String level;
  const RiskBadge({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.riskColor(level);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        level.toUpperCase(),
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
