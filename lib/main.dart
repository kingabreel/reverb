import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/main_menu_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const ReverbApp());
}

class ReverbApp extends StatelessWidget {
  const ReverbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reverb',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00D9FF),
          brightness: Brightness.dark,
        ),
      ),
      home: const MainMenuScreen(),
    );
  }
}