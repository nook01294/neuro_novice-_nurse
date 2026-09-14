import 'package:flutter/material.dart';
import '../data/features.dart';
import '../widgets/feature_list_screen.dart';

class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureListScreen(title: 'ความรู้', items: Features.knowledge);
  }
}
