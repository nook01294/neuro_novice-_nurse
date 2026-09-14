import 'package:flutter/material.dart';
import 'cropped_asset_icon.dart';

/// ICP Warning icon supplied as artwork by the design team, cropped to its
/// content bounding box (found by scanning the source PNG's alpha channel).
class IcpWarningPngIcon extends StatelessWidget {
  final double size;

  const IcpWarningPngIcon({super.key, this.size = 56});

  @override
  Widget build(BuildContext context) {
    return CroppedAssetIcon(
      assetPath: 'assets/icons/icp_warning.png',
      naturalSize: const Size(704, 1531),
      contentRect: const Rect.fromLTRB(126, 565, 578, 971),
      size: size,
    );
  }
}
