import 'package:flutter/material.dart';
import '../data/features.dart';
import '../theme/app_theme.dart';
import '../widgets/feature_card.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController? scrollController;

  const HomeScreen({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // Same full-bleed artwork as every other screen (see BackgroundScaffold);
      // it stays fixed while the header text and cards scroll over it.
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back_ground_default_3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(child: _Header()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
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
      ),
    );
  }
}

/// App header: the title and subtitle over the screen's background artwork.
/// Its height leaves room for the artwork's dark band, so the cards start
/// around the wave.
class _Header extends StatelessWidget {
  static const double _headerAspectRatio = 1371 / 768;

  static const List<Shadow> _shadow = [
    Shadow(color: Colors.black38, blurRadius: 10, offset: Offset(0, 2)),
  ];

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        const AspectRatio(aspectRatio: _headerAspectRatio),
        // Title block sits right of the neuron artwork, as in the design mock.
        Positioned(
          left: 48,
          right: 24,
          top: topInset + 26,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DimensionalTitle(),
              SizedBox(height: 8),
              Text(
                'คู่มือสำหรับพยาบาลระบบประสาทมือใหม่',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  shadows: _shadow,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// "Neuro Novice Nurse" with depth: a stack of hard dark-green offsets reads
/// as an extruded edge, a soft drop shadow lifts it off the artwork, and a
/// white-to-mint gradient lights the face from above.
class _DimensionalTitle extends StatelessWidget {
  const _DimensionalTitle();

  static const String _text = 'Neuro Novice\nNurse';
  static const TextStyle _base = TextStyle(fontSize: 40, fontWeight: FontWeight.w900, height: 1.05);

  static const List<Shadow> _depth = [
    Shadow(color: Color(0xFF0E4D35), offset: Offset(0, 1)),
    Shadow(color: Color(0xFF0E4D35), offset: Offset(0, 2)),
    Shadow(color: Color(0xFF0B3F2B), offset: Offset(0, 3)),
    Shadow(color: Color(0x66000000), offset: Offset(0, 8), blurRadius: 14),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Back layer carries the shadows; the gradient face is drawn over it
        // because ShaderMask would also tint the shadows.
        Text(_text, style: _base.copyWith(color: Colors.white, shadows: _depth)),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFD9F5E6)],
          ).createShader(bounds),
          child: Text(_text, style: _base.copyWith(color: Colors.white)),
        ),
      ],
    );
  }
}
