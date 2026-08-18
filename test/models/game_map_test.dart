import 'package:flutter_test/flutter_test.dart';
import 'package:reverb/models/game_map.dart';
import 'package:reverb/models/scene.dart';

void main() {
  group('GameMap', () {
    late GameMap gameMap;

    setUp(() {
      gameMap = GameMap(
        id: 'test_world',
        name: 'Test World',
        scenes: {
          'scene_1': Scene(
            id: 'scene_1',
            name: 'Scene 1',
            description: 'First scene',
            areaName: 'Area A',
            backgroundImage: 'assets/test.png',
            hotspots: [],
            exits: {'exit_1': 'scene_2'},
          ),
          'scene_2': Scene(
            id: 'scene_2',
            name: 'Scene 2',
            description: 'Second scene',
            areaName: 'Area B',
            backgroundImage: 'assets/test2.png',
            hotspots: [],
            exits: {'exit_2': 'scene_1'},
          ),
        },
        startSceneId: 'scene_1',
      );
    });

    test('getScene returns correct scene', () {
      final scene = gameMap.getScene('scene_1');
      expect(scene, isNotNull);
      expect(scene!.name, 'Scene 1');
    });

    test('getScene returns null for unknown scene', () {
      final scene = gameMap.getScene('unknown');
      expect(scene, isNull);
    });

    test('getStartScene returns start scene', () {
      final scene = gameMap.getStartScene();
      expect(scene.id, 'scene_1');
    });

    test('getExitsFrom returns exit IDs', () {
      final exits = gameMap.getExitsFrom('scene_1');
      expect(exits, contains('exit_1'));
    });

    test('getExitsFrom returns empty list for unknown scene', () {
      final exits = gameMap.getExitsFrom('unknown');
      expect(exits, isEmpty);
    });

    test('getDestination resolves exit to scene ID', () {
      final destination = gameMap.getDestination('scene_1', 'exit_1');
      expect(destination, 'scene_2');
    });

    test('getDestination returns null for unknown exit', () {
      final destination = gameMap.getDestination('scene_1', 'unknown');
      expect(destination, isNull);
    });

    test('getScenesByArea filters scenes by area', () {
      final areas = gameMap.getScenesByArea('Area A');
      expect(areas.length, 1);
      expect(areas['scene_1'], 'Scene 1');
    });

    test('getAllAreas returns unique area names', () {
      final areas = gameMap.getAllAreas();
      expect(areas, contains('Area A'));
      expect(areas, contains('Area B'));
      expect(areas.length, 2);
    });
  });
}
