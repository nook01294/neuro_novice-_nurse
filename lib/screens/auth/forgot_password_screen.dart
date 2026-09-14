import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../theme/app_theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isSubmitting = false;
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    try {
      await AuthService.instance.sendPasswordResetEmail(
        _emailController.text.trim(),
      );
      if (mounted) setState(() => _sent = true);
    } on AuthFailure catch (e) {
      if (mounted) _showError(e.message);
    } catch (_) {
      if (mounted) _showError('เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.danger),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('ลืมรหัสผ่าน')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: _sent ? _buildSentState() : _buildFormState(),
        ),
      ),
    );
  }

  Widget _buildFormState() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'กรอกอีเมลที่ใช้สมัครสมาชิก เราจะส่งลิงก์สำหรับตั้งรหัสผ่านใหม่ให้ทางอีเมล',
            style: TextStyle(color: AppColors.textMuted, fontSize: 15),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'อีเมล',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'กรุณากรอกอีเมล';
              }
              if (!value.contains('@')) {
                return 'รูปแบบอีเมลไม่ถูกต้อง';
              }
              return null;
            },
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: _isSubmitting ? null : _submit,
              style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
              child: _isSubmitting
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : const Text('ส่งลิงก์รีเซ็ตรหัสผ่าน', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.mark_email_read_outlined, color: AppColors.primary, size: 56),
        const SizedBox(height: 16),
        const Text(
          'ส่งอีเมลแล้ว',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textDark),
        ),
        const SizedBox(height: 8),
        Text(
          'กรุณาตรวจสอบอีเมล ${_emailController.text.trim()} เพื่อตั้งรหัสผ่านใหม่',
          style: const TextStyle(color: AppColors.textMuted, fontSize: 15),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('กลับไปเข้าสู่ระบบ', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
