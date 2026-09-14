import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'assess_screen.dart';
import 'home_screen.dart';
import 'knowledge_screen.dart';
import 'monitor_screen.dart';
import 'settings_screen.dart';

/// Bottom-navigation shell hosting the 5 main sections of the app:
/// หน้าหลัก (Home), ประเมิน (Assess), ติดตาม (Monitor), ความรู้ (Knowledge),
/// ตั้งค่า (Settings).
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  static const _tabs = [
    HomeScreen(),
    AssessScreen(),
    MonitorScreen(),
    KnowledgeScreen(),
    SettingsScreen(),
  ];

  static const _labels = ['หน้าหลัก', 'ประเมิน', 'ติดตาม', 'ความรู้', 'ตั้งค่า'];
  static const _icons = [
    Icons.home_rounded,
    Icons.assignment_outlined,
    Icons.show_chart_rounded,
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
          top: 8,
          bottom: MediaQuery.of(context).padding.bottom + 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDark.withValues(alpha: 0.14),
              blurRadius: 24,
              offset: const Offset(0, -8),
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
                onTap: () => setState(() => _index = i),
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
          // Pill-shaped indicator above the icon for the selected tab.
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: 5,
            width: selected ? 46 : 0,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
          ),
          const SizedBox(height: 5),
          Icon(icon, color: color, size: 25),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
