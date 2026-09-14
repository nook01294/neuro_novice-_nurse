import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../root_shell.dart';
import 'login_screen.dart';

/// Root widget that switches between [LoginScreen] and [RootShell] based on
/// the current Firebase auth state, gating the whole app behind login.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService.instance.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.data != null) {
          return const RootShell();
        }
        return const LoginScreen();
      },
    );
  }
}
