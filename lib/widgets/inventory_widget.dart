import 'package:flutter/material.dart';
import '../services/game_service.dart';

class InventoryWidget extends StatelessWidget {
  final GameService gameService;

  const InventoryWidget({
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
            'INVENTÁRIO',
            style: TextStyle(
              color: Color(0xFF00D9FF),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          if (gameService.currentState.inventario.isEmpty)
            const Text(
              'Vazio',
              style: TextStyle(color: Colors.white54, fontSize: 12),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: gameService.currentState.inventario
                  .map((item) => _InventoryItem(label: item))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _InventoryItem extends StatelessWidget {
  final String label;

  const _InventoryItem({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF00D9FF).withValues(alpha: 0.1),
        border: Border.all(
          color: const Color(0xFF00D9FF),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF00D9FF),
          fontSize: 11,
        ),
      ),
    );
  }
}
