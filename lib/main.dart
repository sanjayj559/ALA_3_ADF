import 'package:flutter/material.dart';
import 'services/database_service.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.init();
  runApp(const SmartNotesApp());
}

class SmartNotesApp extends StatelessWidget {
  const SmartNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Student Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF2EB), // Background
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFDCDC),
          primary: const Color(0xFFFFDCDC), // Primary
          secondary: const Color(0xFFFFD6BA), // Highlights
          surface: const Color(0xFFFFE8CD), // Cards
          surfaceContainer: const Color(0xFFFFF2EB), // Background
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D4037),
          ),
          bodyLarge: TextStyle(color: Color(0xFF5D4037)),
          bodyMedium: TextStyle(color: Color(0xFF5D4037)),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFFFFE8CD),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFFD6BA),
          foregroundColor: Color(0xFF5D4037),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
