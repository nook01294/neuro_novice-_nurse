import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'circle_back_button.dart';

/// Full-bleed background image shared by every screen except Home: the
/// title bar is painted directly on top of the image (instead of a solid
/// AppBar) so the wave artwork shows through behind the title too.
class BackgroundScaffold extends StatelessWidget {
  /// Extra enlargement applied to the page content (not the title bar),
  /// on top of the user's system font-size setting.
  static const double contentTextScale = 1.1;

  final String title;
  final Widget body;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;

  const BackgroundScaffold({
    super.key,
    required this.title,
    required this.body,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    final showBackButton =
        automaticallyImplyLeading && Navigator.of(context).canPop();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/back_ground_default_3.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _TitleBar(
                  title: title,
                  showBackButton: showBackButton,
                  actions: actions,
                ),
                Expanded(
                  // Builder: read MediaQuery below the SafeArea, so the
                  // status-bar inset it already consumed isn't re-applied.
                  child: Builder(
                    builder: (context) => MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaler: _ScaledTextScaler(
                          MediaQuery.textScalerOf(context),
                          contentTextScale,
                        ),
                      ),
                      child: body,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Mimics AppBar's centered-title layout (title stays centered on the bar
/// regardless of whether a back button or actions are present) but with a
/// transparent background so the page image shows through.
class _TitleBar extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  const _TitleBar({
    required this.title,
    required this.showBackButton,
    this.actions,
  });

  static const _titleShadow = [
    Shadow(color: Colors.black38, blurRadius: 8, offset: Offset(0, 1)),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 56),
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Kanit',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                shadows: _titleShadow,
              ),
            ),
          ),
          if (showBackButton)
            const Positioned(
              left: 12,
              child: CircleBackButton(),
            ),
          if (actions != null)
            Positioned(
              right: 16,
              child: IconTheme.merge(
                data: const IconThemeData(color: Colors.white),
                child: IconButtonTheme(
                  data: IconButtonThemeData(
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions!,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Multiplies an existing [TextScaler] by a constant factor, so the
/// content enlargement composes with the system font-size setting.
class _ScaledTextScaler extends TextScaler {
  final TextScaler base;
  final double factor;

  const _ScaledTextScaler(this.base, this.factor);

  @override
  double scale(double fontSize) => base.scale(fontSize) * factor;

  @override
  // ignore: deprecated_member_use
  double get textScaleFactor => base.textScaleFactor * factor;

  @override
  bool operator ==(Object other) =>
      other is _ScaledTextScaler && other.base == base && other.factor == factor;

  @override
  int get hashCode => Object.hash(base, factor);
}
