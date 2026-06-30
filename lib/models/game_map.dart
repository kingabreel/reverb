import 'scene.dart';

class GameMap {
  final String id;
  final String name;
  final Map<String, Scene> scenes;
  final String startSceneId;

  GameMap({
    required this.id,
    required this.name,
    required this.scenes,
    required this.startSceneId,
  });

  Scene? getScene(String sceneId) => scenes[sceneId];

  Scene getStartScene() => scenes[startSceneId]!;

  List<String> getExitsFrom(String sceneId) {
    return scenes[sceneId]?.getAvailableExits() ?? [];
  }

  String? getDestination(String fromSceneId, String exitId) {
    final scene = scenes[fromSceneId];
    if (scene == null) return null;
    return scene.exits[exitId];
  }

  Map<String, String> getScenesByArea(String areaName) {
    final result = <String, String>{};
    for (final entry in scenes.entries) {
      if (entry.value.areaName == areaName) {
        result[entry.key] = entry.value.name;
      }
    }
    return result;
  }

  List<String> getAllAreas() {
    final areas = <String>{};
    for (final scene in scenes.values) {
      areas.add(scene.areaName);
    }
    return areas.toList();
  }
}
