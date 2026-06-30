import 'package:flutter/material.dart';
import '../models/game_map.dart';

class NavigationPanel extends StatelessWidget {
  final GameMap gameMap;
  final String currentSceneId;
  final Function(String) onDestinationSelected;

  const NavigationPanel({
    required this.gameMap,
    required this.currentSceneId,
    required this.onDestinationSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final exits = gameMap.getExitsFrom(currentSceneId);
    
    if (exits.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2847),
        border: Border.all(color: const Color(0xFF00D9FF), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'PARA ONDE DESEJA IR?',
            style: TextStyle(
              color: Color(0xFF00D9FF),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          ...exits.map((exitId) {
            final destinationId = gameMap.getDestination(currentSceneId, exitId);
            final destinationScene = gameMap.getScene(destinationId!);
            
            if (destinationScene == null) {
              return SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    onDestinationSelected(destinationId);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00D9FF).withValues(alpha: 0.1),
                    side: const BorderSide(color: Color(0xFF00D9FF), width: 1),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    destinationScene.name,
                    style: const TextStyle(
                      color: Color(0xFF00D9FF),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
