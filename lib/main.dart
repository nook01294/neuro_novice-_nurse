import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/landing_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const NeuroNoviceNurseApp());
}

class NeuroNoviceNurseApp extends StatelessWidget {
  const NeuroNoviceNurseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neuro Novice Nurse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LandingScreen(),
    );
  }
}
