# Contract: SaveService Interface

**Purpose**: Defines the contract for game state persistence.

**File**: `lib/services/save_service.dart`

## Interface

```dart
class SaveService {
  // Save current game state
  Future<void> saveGame(GameState state);
  
  // Load saved game state
  Future<GameState?> loadGame();
  
  // Delete saved game
  Future<void> deleteSave();
  
  // Check if save exists
  bool hasSave();
}
```

## Storage Contract

### Current Implementation (In-Memory)

- Storage: `Map<String, String>` in memory
- Key: `reverb_game_save`
- Value: JSON-serialized `GameState`
- Lifetime: Process lifetime only

### Target Implementation (Disk)

- Storage: `shared_preferences` (or equivalent platform storage)
- Key: `reverb_game_save`
- Value: JSON-serialized `GameState`
- Lifetime: Persistent across app restarts

## Behavioral Contracts

1. **Save**: Serializes `GameState` to JSON, stores under fixed key
2. **Load**: Reads JSON from storage, deserializes to `GameState`, returns null if missing
3. **Delete**: Removes stored save data
4. **HasSave**: Returns true if save data exists in storage
5. **Error Handling**: All methods must handle serialization/deserialization errors gracefully, returning null or default values

## Data Format

```json
{
  "phase": 0,
  "chapter": 0,
  "kaeAge": 15,
  "lyraAge": 35,
  "sincronia": 0.0,
  "ruptura": 0.0,
  "lyraConfianca": 0.0,
  "judeLoyalty": 0.0,
  "inventario": [],
  "discoveredClues": [],
  "choicesMade": {},
  "lastSaveTime": "2026-08-16T00:00:00.000Z",
  "lastSaveChapter": "chapter1"
}
```

## Versioning

- Current version: 1.0
- JSON schema changes must maintain backward compatibility with existing saves
