import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _confirmSignOut(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ออกจากระบบ'),
        content: const Text('คุณต้องการออกจากระบบใช่หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('ออกจากระบบ'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await AuthService.instance.signOut();
      // AuthGate listens to authStateChanges and will swap to LoginScreen.
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = AuthService.instance.currentUser?.email ?? '-';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('ตั้งค่า'), automaticallyImplyLeading: false),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(AppColors.cardRadius),
              boxShadow: AppColors.cardShadow,
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.accent,
                  child: Icon(Icons.person, color: AppColors.primaryDark),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'บัญชีผู้ใช้',
                        style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        email,
                        style: const TextStyle(
                          color: AppColors.textDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(AppColors.cardRadius),
              boxShadow: AppColors.cardShadow,
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(AppColors.cardRadius),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: const Icon(Icons.logout_rounded, color: AppColors.danger),
                title: const Text(
                  'ออกจากระบบ',
                  style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.w600),
                ),
                onTap: () => _confirmSignOut(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
