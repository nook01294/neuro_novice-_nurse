import 'package:flutter/material.dart';

/// Displays an icon PNG that was exported with extra transparent padding
/// around the artwork, cropped tightly to its actual content so it fills
/// the requested [size] the same way the hand-drawn CustomPainter icons do.
///
/// [naturalSize] is the source PNG's pixel dimensions, and [contentRect] is
/// the tight bounding box of the non-transparent artwork within it (both
/// found once per asset, e.g. by scanning pixel alpha values).
class CroppedAssetIcon extends StatelessWidget {
  final String assetPath;
  final Size naturalSize;
  final Rect contentRect;
  final double size;

  const CroppedAssetIcon({
    super.key,
    required this.assetPath,
    required this.naturalSize,
    required this.contentRect,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    final scale = size / (contentRect.width > contentRect.height ? contentRect.width : contentRect.height);
    final scaledImageSize = naturalSize * scale;
    final scaledContentCenter = contentRect.center * scale;

    return SizedBox(
      width: size,
      height: size,
      child: ClipRect(
        child: Stack(
          children: [
            Positioned(
              left: size / 2 - scaledContentCenter.dx,
              top: size / 2 - scaledContentCenter.dy,
              width: scaledImageSize.width,
              height: scaledImageSize.height,
              child: Image.asset(assetPath, fit: BoxFit.fill),
            ),
          ],
        ),
      ),
    );
  }
}
