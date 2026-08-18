import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reverb/models/scene.dart' as models;
import 'package:reverb/widgets/scene_viewer.dart';
import 'package:reverb/widgets/placeholder_image.dart';

void main() {
  group('SceneViewer', () {
    testWidgets('renders background image', (tester) async {
      final scene = models.Scene(
        id: 'test_scene',
        name: 'Test Scene',
        description: 'Test description',
        areaName: 'Test Area',
        backgroundImage: 'assets/bedroom.png',
        hotspots: [],
        exits: {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SceneViewer(
              scene: scene,
              onHotspotTapped: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('renders hotspots', (tester) async {
      final scene = models.Scene(
        id: 'test_scene',
        name: 'Test Scene',
        description: 'Test description',
        areaName: 'Test Area',
        backgroundImage: 'assets/bedroom.png',
        hotspots: [
          models.Hotspot(
            id: 'hotspot_1',
            label: 'Test Hotspot',
            description: 'Test description',
            position: models.Offset(0.5, 0.5),
            radius: 40,
            type: models.HotspotType.examine,
          ),
        ],
        exits: {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SceneViewer(
              scene: scene,
              onHotspotTapped: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(PlaceholderImage), findsOneWidget);
    });

    testWidgets('calls onHotspotTapped when hotspot is tapped', (tester) async {
      final scene = models.Scene(
        id: 'test_scene',
        name: 'Test Scene',
        description: 'Test description',
        areaName: 'Test Area',
        backgroundImage: 'assets/bedroom.png',
        hotspots: [
          models.Hotspot(
            id: 'hotspot_1',
            label: 'Test Hotspot',
            description: 'Test description',
            position: models.Offset(0.5, 0.5),
            radius: 40,
            type: models.HotspotType.examine,
          ),
        ],
        exits: {},
      );

      String? tappedId;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SceneViewer(
              scene: scene,
              onHotspotTapped: (id) => tappedId = id,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();

      expect(tappedId, 'hotspot_1');
    });

    testWidgets('shows hotspot info when selected', (tester) async {
      final scene = models.Scene(
        id: 'test_scene',
        name: 'Test Scene',
        description: 'Test description',
        areaName: 'Test Area',
        backgroundImage: 'assets/bedroom.png',
        hotspots: [
          models.Hotspot(
            id: 'hotspot_1',
            label: 'Test Hotspot',
            description: 'Test description',
            position: models.Offset(0.5, 0.5),
            radius: 40,
            type: models.HotspotType.examine,
          ),
        ],
        exits: {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SceneViewer(
              scene: scene,
              onHotspotTapped: (_) {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();

      expect(find.text('Test description'), findsOneWidget);
    });
  });
}
