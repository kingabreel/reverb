import 'package:flutter/material.dart';
import '../services/game_service.dart';
import 'game_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final gameService = GameService();
  bool hasSave = false;

  @override
  void initState() {
    super.initState();
    _checkSave();
  }

  void _checkSave() {
    setState(() {
      hasSave = gameService.saveService.hasSave();
    });
  }

  void _startNewGame() async {
    await gameService.startNewGame();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const GameScreen()),
      );
    }
  }

  void _continueGame() async {
    await gameService.initializeGame();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const GameScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0A1428),
              const Color(0xFF1A2847),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Column(
                    children: [
                      Text(
                        'REVERB',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: const Color(0xFF00D9FF),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Time Flows Backward',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFF00D9FF).withValues(alpha: 0.7),
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      if (hasSave)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: MenuButton(
                            label: 'CONTINUAR',
                            onPressed: _continueGame,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: MenuButton(
                          label: 'NOVO JOGO',
                          onPressed: _startNewGame,
                        ),
                      ),
                      MenuButton(
                        label: 'SAIR',
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const MenuButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00D9FF).withValues(alpha: 0.1),
          side: const BorderSide(
            color: Color(0xFF00D9FF),
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF00D9FF),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
