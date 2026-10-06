import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Soft mid-green panel for a page's introductory paragraph. Lighter than
/// the header artwork so it stands apart from it, yet dark enough to keep
/// the white text readable where a long intro runs past the green header
/// onto the light part of the background.
class IntroPanel extends StatelessWidget {
  final String text;

  const IntroPanel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF33805F).withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(AppColors.cardRadius),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14.5, height: 1.6, color: AppColors.textOnBackground),
      ),
    );
  }
}
