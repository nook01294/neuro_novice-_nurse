import 'package:flutter/material.dart';

/// Back arrow on a translucent white circle, for use over the green header
/// artwork or app bar. Pops the current route.
class CircleBackButton extends StatelessWidget {
  const CircleBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.2),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 26,
            semanticLabel: MaterialLocalizations.of(context).backButtonTooltip,
          ),
        ),
      ),
    );
  }
}
