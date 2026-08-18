# Contract: GameService Interface

**Purpose**: Defines the contract for game state orchestration and mutation.

**File**: `lib/services/game_service.dart`

## Interface

```dart
class GameService {
  // Singleton access
  factory GameService();
  
  // State initialization
  Future<void> initializeGame();
  Future<void> startNewGame();
  
  // Persistence
  Future<void> saveGame();
  
  // Variable mutations
  void updateSincronia(double delta);
  void updateRuptura(double delta);
  void updateLyraConfianca(double delta);
  void updateJudeLoyalty(double delta);
  
  // State tracking
  void recordChoice(String key, bool value);
  void addInventoryItem(String item);
  void removeInventoryItem(String item);
  void addClue(String clue);
  String getStat(String statName);
}
```

## State Contract

### GameState

```dart
class GameState {
  GamePhase currentPhase;
  GameChapter currentChapter;
  int kaeAge;
  int lyraAge;
  GameVariable sincronia;
  GameVariable ruptura;
  GameVariable lyraConfianca;
  GameVariable judeLoyalty;
  List<String> inventario;
  List<String> discoveredClues;
  Map<String, bool> choicesMade;
  DateTime? lastSaveTime;
  String? lastSaveChapter;
  
  Map<String, dynamic> toJson();
  factory GameState.fromJson(Map<String, dynamic> json);
}
```

**Constraints**:
- `sincronia`, `ruptura`, `lyraConfianca`, `judeLoyalty` values should be clamped to [0, 100]
- `inventario` must not contain duplicates
- `choicesMade` keys must be unique

### GameVariable

```dart
class GameVariable {
  String name;
  double value;
  
  void increase(double amount);
  void decrease(double amount);
}
```

**Constraints**:
- `value` should be clamped to [0, 100] after increase/decrease
- `name` must be non-empty

## Behavioral Contracts

1. **New Game**: `startNewGame()` resets all variables to 0, clears inventory/clues/choices, sets ages to starting values
2. **Save**: `saveGame()` serializes current state to JSON and persists to storage
3. **Load**: `initializeGame()` attempts to load saved state; if none exists, creates new game
4. **Stat Changes**: `update*()` methods modify variables and trigger UI updates via state management
5. **Choice Tracking**: `recordChoice()` stores boolean value for a given key

## Versioning

- Current version: 1.0
- State schema changes require backward-compatible JSON deserialization
