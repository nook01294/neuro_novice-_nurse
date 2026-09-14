import 'package:flutter/material.dart';
import '../data/features.dart';
import '../widgets/feature_list_screen.dart';

class AssessScreen extends StatelessWidget {
  const AssessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureListScreen(title: 'ประเมิน', items: Features.assessment);
  }
}
