import 'package:flutter/material.dart';
import '../data/features.dart';
import '../widgets/feature_list_screen.dart';

class MonitorScreen extends StatelessWidget {
  const MonitorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureListScreen(title: 'ติดตาม', items: Features.monitoring);
  }
}
