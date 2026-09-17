import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'assess_screen.dart';
import 'home_screen.dart';
import 'monitor_screen.dart';
import 'settings_screen.dart';

/// Bottom-navigation shell hosting the 4 main sections of the app:
/// หน้าหลัก (Home), ขั้นตอนประเมิน GCS (Assess), ติดตาม (Monitor),
/// ตั้งค่า (Settings).
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  final _scrollControllers = List.generate(4, (_) => ScrollController());

  late final _tabs = [
    HomeScreen(scrollController: _scrollControllers[0]),
    AssessScreen(scrollController: _scrollControllers[1]),
    MonitorScreen(scrollController: _scrollControllers[2]),
    SettingsScreen(scrollController: _scrollControllers[3]),
  ];

  @override
  void dispose() {
    for (final controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _selectTab(int i) {
    setState(() => _index = i);
    final controller = _scrollControllers[i];
    if (controller.hasClients) {
      controller.jumpTo(0);
    }
  }

  static const _labels = [
    'หน้าหลัก',
    'ขั้นตอนการประเมิน',
    'Nursing Care',
    'ตั้งค่า',
  ];
  static const _icons = [
    Icons.home_rounded,
    Icons.assignment_outlined,
    Icons.menu_book_outlined,
    Icons.settings_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _tabs),
      // No SafeArea here: the bar's own background is painted all the way
      // down through the device's gesture-navigation inset, and only the
      // tappable content is padded above it.
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 4,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDark.withValues(alpha: 0.10),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(_labels.length, (i) {
            final selected = i == _index;
            return Expanded(
              child: _NavItem(
                icon: _icons[i],
                label: _labels[i],
                selected: selected,
                onTap: () => _selectTab(i),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textMuted;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
