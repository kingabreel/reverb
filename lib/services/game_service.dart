import '../models/game_state.dart';
import 'save_service.dart';

class GameService {
  static final GameService _instance = GameService._internal();
  late GameState currentState;
  final SaveService saveService = SaveService();

  factory GameService() {
    return _instance;
  }

  GameService._internal() {
    currentState = GameState();
  }

  Future<void> initializeGame() async {
    final savedState = await saveService.loadGame();
    if (savedState != null) {
      currentState = savedState;
    }
  }

  Future<void> startNewGame() async {
    currentState = GameState();
    await saveGame();
  }

  Future<void> saveGame() async {
    currentState.saveProgress(currentState.currentChapter.toString());
    await saveService.saveGame(currentState);
  }

  void updateCurrentScene(String sceneId) {
    currentState.currentSceneId = sceneId;
  }

  void updateSincronia(double delta) {
    currentState.sincronia.increase(delta);
  }

  void updateRuptura(double delta) {
    currentState.ruptura.increase(delta);
  }

  void updateLyraConfianca(double delta) {
    currentState.lyraConfianca.increase(delta);
  }

  void updateJudeLoyalty(double delta) {
    currentState.judeLoyalty.increase(delta);
  }

  void recordChoice(String key, bool value) {
    currentState.recordChoice(key, value);
  }

  void addInventoryItem(String item) {
    currentState.addInventoryItem(item);
  }

  void removeInventoryItem(String item) {
    currentState.removeInventoryItem(item);
  }

  void addClue(String clue) {
    currentState.addClue(clue);
  }

  String getStat(String statName) {
    switch (statName) {
      case 'sincronia':
        return currentState.sincronia.value.toStringAsFixed(1);
      case 'ruptura':
        return currentState.ruptura.value.toStringAsFixed(1);
      case 'lyraConfianca':
        return currentState.lyraConfianca.value.toStringAsFixed(1);
      case 'judeLoyalty':
        return currentState.judeLoyalty.value.toStringAsFixed(1);
      default:
        return '0.0';
    }
  }
}
