import 'package:flutter/material.dart';
import 'cropped_asset_icon.dart';

/// GCS icon supplied as artwork by the design team, cropped to its content
/// bounding box (found by scanning the source PNG's alpha channel).
class GcsPngIcon extends StatelessWidget {
  final double size;

  const GcsPngIcon({super.key, this.size = 56});

  @override
  Widget build(BuildContext context) {
    return CroppedAssetIcon(
      assetPath: 'assets/icons/gcs.png',
      naturalSize: const Size(339, 737),
      contentRect: const Rect.fromLTRB(54, 253, 285, 478),
      size: size,
    );
  }
}
