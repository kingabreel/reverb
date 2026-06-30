import 'package:flutter/material.dart';
import '../services/game_service.dart';

class StatisticsWidget extends StatelessWidget {
  final GameService gameService;

  const StatisticsWidget({
    required this.gameService,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2847),
        border: Border.all(color: const Color(0xFF00D9FF)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DIMENSÕES TEMPORAIS',
            style: TextStyle(
              color: Color(0xFF00D9FF),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          _StatBar(
            label: 'SINCRONIA',
            value: gameService.currentState.sincronia.value,
            color: Colors.cyan,
          ),
          const SizedBox(height: 8),
          _StatBar(
            label: 'RUPTURA',
            value: gameService.currentState.ruptura.value,
            color: Colors.red,
          ),
          const SizedBox(height: 8),
          _StatBar(
            label: 'CONFIANÇA',
            value: gameService.currentState.lyraConfianca.value,
            color: Colors.blue,
          ),
          const SizedBox(height: 8),
          _StatBar(
            label: 'LEALDADE',
            value: gameService.currentState.judeLoyalty.value,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class _StatBar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _StatBar({
    required this.label,
    required this.value,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedValue = (value.clamp(0, 100) / 100).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF00D9FF),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value.toStringAsFixed(1),
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: normalizedValue,
            minHeight: 4,
            backgroundColor: Colors.white12,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
