import 'package:flutter/material.dart';
import 'cropped_asset_icon.dart';

/// Quiz Test icon supplied as artwork by the design team, cropped
/// to its content bounding box (found by scanning the source PNG's alpha
/// channel).
class QuizTestPngIcon extends StatelessWidget {
  final double size;

  const QuizTestPngIcon({super.key, this.size = 56});

  @override
  Widget build(BuildContext context) {
    return CroppedAssetIcon(
      assetPath: 'assets/icons/neuro_monitoring.png',
      naturalSize: const Size(704, 1531),
      contentRect: const Rect.fromLTRB(150, 594, 554, 930),
      size: size,
    );
  }
}
