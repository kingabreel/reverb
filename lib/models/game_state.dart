enum GamePhase {
  actOne,
  actTwo,
  actThree,
  actFour,
}

enum GameChapter {
  chapter1,
  chapter2,
  chapter3,
  chapter4,
  chapter5,
  chapter6,
  chapter7,
  chapter8,
  chapter9,
  chapter10,
  chapter11,
  chapter12,
}

class GameVariable {
  final String name;
  double value;

  GameVariable({required this.name, this.value = 0.0});

  void increase(double amount) {
    value = (value + amount).clamp(0.0, 100.0);
  }

  void decrease(double amount) {
    value = (value - amount).clamp(0.0, 100.0);
  }
}

class GameState {
  GamePhase currentPhase = GamePhase.actOne;
  GameChapter currentChapter = GameChapter.chapter1;
  String currentSceneId = 'scene_quarto';
  
  int kaeAge = 15;
  int lyraAge = 35;
  
  GameVariable sincronia = GameVariable(name: 'sincronia');
  GameVariable ruptura = GameVariable(name: 'ruptura');
  GameVariable lyraConfianca = GameVariable(name: 'lyraConfianca');
  GameVariable judeLoyalty = GameVariable(name: 'judeLoyalty');
  
  List<String> inventario = [];
  List<String> discoveredClues = [];
  Map<String, bool> choicesMade = {};
  
  DateTime? lastSaveTime;
  String? lastSaveChapter;

  GameState();

  void addInventoryItem(String item) {
    if (!inventario.contains(item)) {
      inventario.add(item);
    }
  }

  void removeInventoryItem(String item) {
    inventario.remove(item);
  }

  void addClue(String clue) {
    if (!discoveredClues.contains(clue)) {
      discoveredClues.add(clue);
    }
  }

  void recordChoice(String choiceKey, bool value) {
    choicesMade[choiceKey] = value;
  }

  bool wasChoiceMade(String choiceKey) {
    return choicesMade[choiceKey] ?? false;
  }

  void saveProgress(String chapter) {
    lastSaveTime = DateTime.now();
    lastSaveChapter = chapter;
  }

  Map<String, dynamic> toJson() => {
    'phase': currentPhase.index,
    'chapter': currentChapter.index,
    'currentSceneId': currentSceneId,
    'kaeAge': kaeAge,
    'lyraAge': lyraAge,
    'sincronia': sincronia.value,
    'ruptura': ruptura.value,
    'lyraConfianca': lyraConfianca.value,
    'judeLoyalty': judeLoyalty.value,
    'inventario': inventario,
    'discoveredClues': discoveredClues,
    'choicesMade': choicesMade,
    'lastSaveTime': lastSaveTime?.toIso8601String(),
    'lastSaveChapter': lastSaveChapter,
  };

  factory GameState.fromJson(Map<String, dynamic> json) {
    final state = GameState();
    state.currentPhase = GamePhase.values[json['phase'] as int? ?? 0];
    state.currentChapter = GameChapter.values[json['chapter'] as int? ?? 0];
    state.currentSceneId = json['currentSceneId'] as String? ?? 'scene_quarto';
    state.kaeAge = json['kaeAge'] as int? ?? 15;
    state.lyraAge = json['lyraAge'] as int? ?? 35;
    state.sincronia.value = (json['sincronia'] as num?)?.toDouble() ?? 0.0;
    state.ruptura.value = (json['ruptura'] as num?)?.toDouble() ?? 0.0;
    state.lyraConfianca.value = (json['lyraConfianca'] as num?)?.toDouble() ?? 0.0;
    state.judeLoyalty.value = (json['judeLoyalty'] as num?)?.toDouble() ?? 0.0;
    state.inventario = List<String>.from(json['inventario'] as List? ?? []);
    state.discoveredClues = List<String>.from(json['discoveredClues'] as List? ?? []);
    state.choicesMade = Map<String, bool>.from(json['choicesMade'] as Map? ?? {});
    if (json['lastSaveTime'] != null) {
      state.lastSaveTime = DateTime.parse(json['lastSaveTime'] as String);
    }
    state.lastSaveChapter = json['lastSaveChapter'] as String?;
    return state;
  }
}
