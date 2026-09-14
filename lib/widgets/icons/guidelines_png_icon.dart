import 'package:flutter/material.dart';
import 'cropped_asset_icon.dart';

/// Nursing guidelines (book) icon supplied as artwork by the design team,
/// cropped to its content bounding box (found by scanning the source PNG's
/// alpha channel).
class GuidelinesPngIcon extends StatelessWidget {
  final double size;

  const GuidelinesPngIcon({super.key, this.size = 56});

  @override
  Widget build(BuildContext context) {
    return CroppedAssetIcon(
      assetPath: 'assets/icons/guideline.png',
      naturalSize: const Size(704, 1531),
      contentRect: const Rect.fromLTRB(140, 603, 563, 930),
      size: size,
    );
  }
}
