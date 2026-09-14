import 'package:flutter/material.dart';
import '../models/feature_item.dart';
import '../services/usage_log_service.dart';
import '../theme/app_theme.dart';

/// Shared list layout used by the Assess, Monitor, and Knowledge tabs.
class FeatureListScreen extends StatelessWidget {
  final String title;
  final List<FeatureItem> items;

  const FeatureListScreen({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = items[index];
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  child: Row(
                    children: [
                      item.iconBuilder(36),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: AppColors.textMuted),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
