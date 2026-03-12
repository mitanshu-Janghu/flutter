import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SmartVidyaApp());
}

class SmartVidyaApp extends StatelessWidget {
  const SmartVidyaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartVidya',
      theme: ThemeData.dark(),
      home: const OnboardingScreen(),
    );
  }
}