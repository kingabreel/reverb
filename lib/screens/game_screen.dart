import 'package:flutter/material.dart';
import '../services/game_service.dart';
import '../data/content_repository.dart';
import '../models/scene.dart';
import '../models/game_map.dart';
import '../widgets/scene_viewer.dart';
import '../widgets/dialogue_viewer.dart';
import '../widgets/navigation_panel.dart';
import '../widgets/inventory_widget.dart';
import '../widgets/statistics_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameService gameService;
  late ContentRepository contentRepository;
  late GameMap gameMap;
  Scene? currentScene;
  bool showNavigationPanel = false;
  bool showHud = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    gameService = GameService();
    contentRepository = ContentRepository();
    _initializeGame();
  }

  void _initializeGame() async {
    await gameService.initializeGame();
    gameMap = contentRepository.getGameMap();
    final savedSceneId = gameService.currentState.currentSceneId;
    final scene = gameMap.getScene(savedSceneId) ?? gameMap.getStartScene();
    setState(() {
      currentScene = scene;
      isLoading = false;
    });
  }

  void _navigateToScene(String sceneId) {
    final scene = gameMap.getScene(sceneId);
    if (scene != null) {
      setState(() {
        currentScene = scene;
        showNavigationPanel = false;
      });
      gameService.updateCurrentScene(sceneId);
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
    if (currentScene == null) return;
    
    final hotspot = currentScene!.hotspots.firstWhere(
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
      final destinationId = currentScene!.exits[hotspot.actionValue];
      if (destinationId != null) {
        _navigateToScene(destinationId);
      }
    } else if (hotspot.type == HotspotType.dialogue) {
      _showDialogueForHotspot(hotspotId);
    } else if (hotspot.type == HotspotType.examine) {
      _showExamineFeedback(hotspot);
    } else if (hotspot.type == HotspotType.item) {
      _collectItem(hotspot);
    }
  }

  void _showExamineFeedback(Hotspot hotspot) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(hotspot.description),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _collectItem(Hotspot hotspot) {
    if (hotspot.actionValue != null) {
      gameService.addInventoryItem(hotspot.actionValue!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Você coletou: ${hotspot.label}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showDialogueForHotspot(String hotspotId) {
    String? dialogueContext;
    
    if (hotspotId == 'hotspot_lyra_ruinas') {
      dialogueContext = 'ruinas_first';
    } else if (hotspotId == 'hotspot_jude') {
      dialogueContext = 'school';
    } else if (hotspotId == 'hotspot_lyra_janela_30') {
      dialogueContext = 'tower_top';
    } else if (hotspotId == 'hotspot_contato_madrugada') {
      dialogueContext = 'distrito_sucateiros';
    } else if (hotspotId == 'hotspot_balcao_arquivista') {
      dialogueContext = 'arquivo_morto';
    } else if (hotspotId == 'hotspot_npc_clara') {
      dialogueContext = 'escola_abandonada';
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
    if (isLoading || currentScene == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A1428),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF00D9FF)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A1428),
      body: Column(
        children: [
          GameHeader(
            locationName: currentScene!.name,
            onSave: _saveGame,
            onMenu: () => Navigator.of(context).pop(),
            onToggleNavigation: () {
              setState(() {
                showNavigationPanel = !showNavigationPanel;
              });
            },
            showNavigationPanel: showNavigationPanel,
            showHud: showHud,
            onToggleHud: () {
              setState(() {
                showHud = !showHud;
              });
            },
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SceneViewer(
                    scene: currentScene!,
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
                      currentSceneId: currentScene!.id,
                      onDestinationSelected: _navigateToScene,
                    ),
                  ),
                if (showHud)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InventoryWidget(gameService: gameService),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatisticsWidget(gameService: gameService),
                        ),
                      ],
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
  final VoidCallback onToggleNavigation;
  final bool showNavigationPanel;
  final bool showHud;
  final VoidCallback onToggleHud;

  const GameHeader({
    required this.locationName,
    required this.onSave,
    required this.onMenu,
    required this.onToggleNavigation,
    required this.showNavigationPanel,
    required this.showHud,
    required this.onToggleHud,
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
                icon: Icon(
                  showNavigationPanel ? Icons.close : Icons.map,
                  color: const Color(0xFF00D9FF),
                ),
                onPressed: onToggleNavigation,
                tooltip: showNavigationPanel ? 'Fechar mapa' : 'Abrir mapa',
              ),
              IconButton(
                icon: Icon(
                  showHud ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF00D9FF),
                ),
                onPressed: onToggleHud,
                tooltip: showHud ? 'Ocultar inventário' : 'Mostrar inventário',
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
