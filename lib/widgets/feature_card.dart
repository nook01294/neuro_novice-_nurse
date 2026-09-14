import 'package:flutter/material.dart';
import '../models/feature_item.dart';
import '../services/usage_log_service.dart';
import '../theme/app_theme.dart';

/// A rounded, tappable card representing a single main feature.
class FeatureCard extends StatelessWidget {
  final FeatureItem item;

  const FeatureCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppColors.cardRadius);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: radius,
        boxShadow: AppColors.cardShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            UsageLogService.instance.logFeatureUsage(item.title);
            Navigator.of(context).push(
              MaterialPageRoute(builder: item.pageBuilder),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                item.iconBuilder(72),
                const SizedBox(height: 16),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
