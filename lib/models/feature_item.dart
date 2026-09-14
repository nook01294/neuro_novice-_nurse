import 'package:flutter/material.dart';

/// Describes one of the app's main feature tiles shown on the home grid.
class FeatureItem {
  final String title;
  final Widget Function(double size) iconBuilder;
  final WidgetBuilder pageBuilder;

  const FeatureItem({
    required this.title,
    required this.iconBuilder,
    required this.pageBuilder,
  });
}
