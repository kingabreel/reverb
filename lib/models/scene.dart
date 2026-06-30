enum HotspotType {
  examine,
  navigate,
  dialogue,
  item,
}

class SceneExit {
  final String id;
  final String destinationSceneId;
  final String label;

  SceneExit({
    required this.id,
    required this.destinationSceneId,
    required this.label,
  });
}

class Hotspot {
  final String id;
  final String label;
  final String description;
  final Offset position;
  final double radius;
  final HotspotType type;
  final String? actionType;
  final String? actionValue;
  final String? linkedSceneId;
  final String? icon;

  Hotspot({
    required this.id,
    required this.label,
    required this.description,
    required this.position,
    required this.radius,
    this.type = HotspotType.examine,
    this.actionType,
    this.actionValue,
    this.linkedSceneId,
    this.icon
  });
}

class Offset {
  final double x;
  final double y;

  Offset(this.x, this.y);

  factory Offset.fromJson(Map<String, dynamic> json) =>
      Offset(json['x'] as double, json['y'] as double);

  Map<String, dynamic> toJson() => {'x': x, 'y': y};
}

class Scene {
  final String id;
  final String name;
  final String description;
  final String areaName;
  final String backgroundImage;
  final List<Hotspot> hotspots;
  final Map<String, String> exits;

  Scene({
    required this.id,
    required this.name,
    required this.description,
    required this.areaName,
    required this.backgroundImage,
    required this.hotspots,
    required this.exits,
  });

  List<String> getAvailableExits() => exits.keys.toList();

  String? getExitDestination(String exitId) => exits[exitId];
}

class Chapter {
  final String id;
  final String number;
  final String title;
  final String objective;
  final List<Scene> scenes;
  final String? nextChapterId;

  Chapter({
    required this.id,
    required this.number,
    required this.title,
    required this.objective,
    required this.scenes,
    this.nextChapterId,
  });

  Scene getSceneById(String sceneId) {
    return scenes.firstWhere((s) => s.id == sceneId);
  }
}

class Act {
  final String id;
  final String number;
  final String title;
  final List<Chapter> chapters;

  Act({
    required this.id,
    required this.number,
    required this.title,
    required this.chapters,
  });

  Chapter getChapterById(String chapterId) {
    return chapters.firstWhere((c) => c.id == chapterId);
  }
}
