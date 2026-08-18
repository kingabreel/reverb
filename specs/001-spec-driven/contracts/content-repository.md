# Contract: ContentRepository Interface

**Purpose**: Defines the contract for providing game content (scenes and dialogues) to the game engine.

**File**: `lib/data/content_repository.dart`

## Interface

```dart
class ContentRepository {
  // Singleton factory
  factory ContentRepository();
  
  // Returns the complete game world map
  GameMap getGameMap();
  
  // Returns a dialogue tree for a specific NPC and context
  DialogueTree getDialogueForNpc(String npcId, String context);
}
```

## Data Contracts

### GameMap

```dart
class GameMap {
  String id;
  String name;
  Map<String, Scene> scenes;
  String startSceneId;
  
  Scene? getScene(String sceneId);
  Scene getStartScene();
  List<String> getExitsFrom(String sceneId);
  String? getDestination(String fromSceneId, String exitId);
  Map<String, String> getScenesByArea(String areaName);
  List<String> getAllAreas();
}
```

**Constraints**:
- `startSceneId` must exist in `scenes`
- All exit destination IDs must exist in `scenes`
- Scene IDs must be unique

### Scene

```dart
class Scene {
  String id;
  String name;
  String description;
  String areaName;
  String backgroundImage;
  List<Hotspot> hotspots;
  Map<String, String> exits;
  
  List<String> getAvailableExits();
  String? getExitDestination(String exitId);
}
```

**Constraints**:
- `id` must be unique across all scenes
- `backgroundImage` must be a valid asset path
- `exits` keys must be unique
- All `exits` values must reference existing scene IDs

### Hotspot

```dart
class Hotspot {
  String id;
  String label;
  String description;
  Offset position;
  double radius;
  HotspotType type;
  String? actionType;
  String? actionValue;
  String? linkedSceneId;
  String? icon;
}
```

**Constraints**:
- `id` must be unique within a scene
- `position.x` and `position.y` must be in [0.0, 1.0]
- `radius` must be > 0
- If `type == navigate`, `actionValue` must not be null
- If `type == dialogue`, `actionValue` must reference a valid dialogue context

### DialogueTree

```dart
class DialogueTree {
  String id;
  String npcName;
  Map<String, DialogueNode> nodes;
  String rootNodeId;
  
  DialogueNode getRootNode();
  DialogueNode? getNodeById(String nodeId);
}
```

**Constraints**:
- `rootNodeId` must exist in `nodes`
- All `nextDialogueId` references in options must exist in `nodes`
- No circular references without exit nodes

## Versioning

- Current version: 1.0
- Breaking changes require migration guide for content data
