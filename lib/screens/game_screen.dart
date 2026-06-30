import 'package:flutter/material.dart';
import '../services/game_service.dart';
import '../data/content_repository.dart';
import '../models/scene.dart';
import '../models/game_map.dart';
import '../widgets/scene_viewer.dart';
import '../widgets/dialogue_viewer.dart';
import '../widgets/navigation_panel.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameService gameService;
  late ContentRepository contentRepository;
  late GameMap gameMap;
  late Scene currentScene;
  bool showNavigationPanel = false;

  @override
  void initState() {
    super.initState();
    gameService = GameService();
    contentRepository = ContentRepository();
    _initializeGame();
  }

  void _initializeGame() {
    gameMap = contentRepository.getGameMap();
    currentScene = gameMap.getStartScene();
    setState(() {});
  }

  void _navigateToScene(String sceneId) {
    final scene = gameMap.getScene(sceneId);
    if (scene != null) {
      setState(() {
        currentScene = scene;
        showNavigationPanel = false;
      });
    }
  }

  void _saveGame() async {
    await gameService.saveGame();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jogo salvo com sucesso')),
      );
    }
  }

  void _handleHotspotInteraction(String hotspotId) {
    final hotspot = currentScene.hotspots.firstWhere(
      (h) => h.id == hotspotId,
      orElse: () => Hotspot(
        id: '',
        label: '',
        description: '',
        position: Offset(0, 0),
        radius: 0,
      ),
    );

    if (hotspot.id.isEmpty) return;

    if (hotspot.type == HotspotType.navigate && hotspot.actionValue != null) {
      final destinationId = currentScene.exits[hotspot.actionValue];
      if (destinationId != null) {
        _navigateToScene(destinationId);
      }
    } else if (hotspot.type == HotspotType.dialogue) {
      _showDialogueForHotspot(hotspotId);
    } 
  }

  void _showDialogueForHotspot(String hotspotId) {
    String? dialogueContext;
    
    if (hotspotId == 'hotspot_lyra_ruinas') {
      dialogueContext = 'ruinas_first';
    } else if (hotspotId == 'hotspot_jude') {
      dialogueContext = 'school';
    }

    if (dialogueContext == null) return;

    final dialogueTree = contentRepository.getDialogueForNpc('lyra', dialogueContext);

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A2847),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: DialogueViewer(
            dialogueTree: dialogueTree,
            gameService: gameService,
            onComplete: () {
              Navigator.pop(context);
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1428),
      body: Column(
        children: [
          GameHeader(
            locationName: currentScene.name,
            onSave: _saveGame,
            onMenu: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SceneViewer(
                    scene: currentScene,
                    onHotspotTapped: (hotspotId) {
                      _handleHotspotInteraction(hotspotId);
                    },
                  ),
                ),
                if (showNavigationPanel)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: NavigationPanel(
                      gameMap: gameMap,
                      currentSceneId: currentScene.id,
                      onDestinationSelected: _navigateToScene,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GameHeader extends StatelessWidget {
  final String locationName;
  final VoidCallback onSave;
  final VoidCallback onMenu;

  const GameHeader({
    required this.locationName,
    required this.onSave,
    required this.onMenu,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1428),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF00D9FF).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            locationName.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF00D9FF),
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.save, color: Color(0xFF00D9FF)),
                onPressed: onSave,
                tooltip: 'Salvar jogo',
              ),
              IconButton(
                icon: const Icon(Icons.menu, color: Color(0xFF00D9FF)),
                onPressed: onMenu,
                tooltip: 'Menu',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
