import 'package:flutter/material.dart';
import 'cropped_asset_icon.dart';

/// Motor Power icon supplied as artwork by the design team, cropped to its
/// content bounding box (found by scanning the source PNG's alpha channel).
class MotorPowerPngIcon extends StatelessWidget {
  final double size;

  const MotorPowerPngIcon({super.key, this.size = 56});

  @override
  Widget build(BuildContext context) {
    return CroppedAssetIcon(
      assetPath: 'assets/icons/motor_power.png',
      naturalSize: const Size(704, 1531),
      contentRect: const Rect.fromLTRB(117, 523, 586, 979),
      size: size,
    );
  }
}
