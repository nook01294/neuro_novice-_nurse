import 'package:flutter/material.dart';
import '../data/features.dart';
import '../theme/app_theme.dart';
import '../widgets/feature_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _Header()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.02,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => FeatureCard(item: Features.all[index]),
                childCount: Features.all.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// App header: the illustrated brain/neuron artwork as a background image
/// (it already includes its own wavy bottom edge), with the title and
/// subtitle overlaid on top.
class _Header extends StatelessWidget {
  static const double _imageAspectRatio = 1371 / 768;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        AspectRatio(
          aspectRatio: _imageAspectRatio,
          child: Image.asset(
            'assets/images/background_1.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Positioned(
          left: 24,
          right: 24,
          top: topInset + 22,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Neuro Novice Nurse',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 31,
                  fontWeight: FontWeight.w900,
                  height: 1.15,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'คู่มือสำหรับพยาบาลระบบประสาทมือใหม่',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
