import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/usage_log_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';

class SettingsScreen extends StatelessWidget {
  final ScrollController? scrollController;

  const SettingsScreen({super.key, this.scrollController});

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

  /// Deletes the account and everything stored under it, in that order:
  /// confirm, re-authenticate, wipe Firestore, then delete the auth user.
  Future<void> _confirmDeleteAccount(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ลบบัญชีถาวร'),
        content: const Text(
          'บัญชีของคุณและข้อมูลทั้งหมดจะถูกลบอย่างถาวร ได้แก่\n\n'
          '• อีเมลและข้อมูลการเข้าสู่ระบบ\n'
          '• ประวัติหัวข้อที่เคยเปิดดู\n'
          '• ผลการทำแบบทดสอบทั้งหมด\n\n'
          'การลบนี้ย้อนกลับไม่ได้ และกู้คืนข้อมูลไม่ได้',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('ลบบัญชี'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final password = await showDialog<String>(
      context: context,
      builder: (context) => const _PasswordPrompt(),
    );
    if (password == null || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context, rootNavigator: true);

    _showProgressBarrier(context);

    String? error;
    try {
      final uid = AuthService.instance.currentUser?.uid;
      if (uid == null) throw const AuthFailure('ไม่พบบัญชีผู้ใช้ กรุณาเข้าสู่ระบบใหม่');

      await AuthService.instance.reauthenticate(password);
      // Firestore first: after the auth user is gone the rules would reject
      // these deletes and the documents could never be removed.
      await UsageLogService.instance.deleteUserData(uid);
      await AuthService.instance.deleteAccount();
      // AuthGate listens to authStateChanges and will swap to LoginScreen.
    } on AuthFailure catch (e) {
      error = e.message;
    } catch (_) {
      error = 'ลบบัญชีไม่สำเร็จ กรุณาลองใหม่อีกครั้ง';
    }

    navigator.pop(); // dismiss the progress barrier

    if (error != null) {
      messenger.showSnackBar(
        SnackBar(content: Text(error), backgroundColor: AppColors.danger),
      );
    }
  }

  /// Blocks interaction while the delete runs. Deliberately not awaited: it
  /// is dismissed by popping the root navigator once the work finishes.
  void _showProgressBarrier(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final email = AuthService.instance.currentUser?.email ?? '-';

    return BackgroundScaffold(
      title: 'ตั้งค่า',
      automaticallyImplyLeading: false,
      body: ListView(
        controller: scrollController,
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
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.logout_rounded, color: AppColors.danger),
                    title: const Text(
                      'ออกจากระบบ',
                      style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.w600),
                    ),
                    onTap: () => _confirmSignOut(context),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: const Icon(Icons.delete_forever_rounded, color: AppColors.danger),
                    title: const Text(
                      'ลบบัญชี',
                      style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text(
                      'ลบบัญชีและข้อมูลทั้งหมดอย่างถาวร',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                    ),
                    onTap: () => _confirmDeleteAccount(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Asks for the account password so the delete can be re-authenticated.
/// Pops the entered password, or null when cancelled.
class _PasswordPrompt extends StatefulWidget {
  const _PasswordPrompt();

  @override
  State<_PasswordPrompt> createState() => _PasswordPromptState();
}

class _PasswordPromptState extends State<_PasswordPrompt> {
  final _controller = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final password = _controller.text;
    if (password.isEmpty) return;
    Navigator.of(context).pop(password);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('ยืนยันรหัสผ่าน'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'กรอกรหัสผ่านของคุณเพื่อยืนยันการลบบัญชี',
            style: TextStyle(color: AppColors.textMuted, fontSize: 14),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            obscureText: _obscure,
            autofocus: true,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.fieldFill,
              hintText: 'รหัสผ่าน',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.fieldBorder),
              ),
              suffixIcon: IconButton(
                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                color: AppColors.textMuted,
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('ยกเลิก'),
        ),
        TextButton(
          onPressed: _submit,
          style: TextButton.styleFrom(foregroundColor: AppColors.danger),
          child: const Text('ลบบัญชี'),
        ),
      ],
    );
  }
}
