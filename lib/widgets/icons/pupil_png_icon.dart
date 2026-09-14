import 'package:flutter/material.dart';
import 'cropped_asset_icon.dart';

/// Pupillary light reflex (eye) icon supplied as artwork by the design
/// team, cropped to its content bounding box (found by scanning the source
/// PNG's alpha channel).
class PupilPngIcon extends StatelessWidget {
  final double size;

  const PupilPngIcon({super.key, this.size = 56});

  @override
  Widget build(BuildContext context) {
    return CroppedAssetIcon(
      assetPath: 'assets/icons/eye.png',
      naturalSize: const Size(704, 1531),
      contentRect: const Rect.fromLTRB(114, 627, 589, 900),
      size: size,
    );
  }
}
