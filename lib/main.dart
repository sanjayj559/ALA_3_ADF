import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'services/database_service.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
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
        primaryColor: const Color(0xFF222831),
        scaffoldBackgroundColor: const Color(0xFF222831),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF948979),
          primary: const Color(0xFF393E46),
          secondary: const Color(0xFF948979),
          surface: const Color(0xFF393E46),
          background: const Color(0xFF222831),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFDFD0B8)),
          bodyMedium: TextStyle(color: Color(0xFFDFD0B8)),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
