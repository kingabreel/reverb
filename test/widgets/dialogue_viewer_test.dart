import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reverb/models/dialogue.dart';
import 'package:reverb/services/game_service.dart';
import 'package:reverb/widgets/dialogue_viewer.dart';

void main() {
  group('DialogueViewer', () {
    testWidgets('renders dialogue text', (tester) async {
      final dialogueTree = DialogueTree(
        id: 'test',
        npcName: 'Test NPC',
        nodes: {
          'node_1': DialogueNode(
            id: 'node_1',
            character: 'Test NPC',
            text: 'Hello, world!',
            options: [
              DialogueOption(
                id: 'opt_1',
                text: 'Hi',
                nextDialogueId: 'node_end',
              ),
            ],
          ),
          'node_end': DialogueNode(
            id: 'node_end',
            character: '',
            text: '',
            options: [],
            isEnd: true,
          ),
        },
        rootNodeId: 'node_1',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DialogueViewer(
              dialogueTree: dialogueTree,
              gameService: GameService(),
              onComplete: () {},
            ),
          ),
        ),
      );

      expect(find.text('Hello, world!'), findsOneWidget);
      expect(find.text('Test NPC'), findsOneWidget);
    });

    testWidgets('renders dialogue options', (tester) async {
      final dialogueTree = DialogueTree(
        id: 'test',
        npcName: 'Test NPC',
        nodes: {
          'node_1': DialogueNode(
            id: 'node_1',
            character: 'Test NPC',
            text: 'Hello!',
            options: [
              DialogueOption(
                id: 'opt_1',
                text: 'Option 1',
                nextDialogueId: 'node_end',
              ),
              DialogueOption(
                id: 'opt_2',
                text: 'Option 2',
                nextDialogueId: 'node_end',
              ),
            ],
          ),
          'node_end': DialogueNode(
            id: 'node_end',
            character: '',
            text: '',
            options: [],
            isEnd: true,
          ),
        },
        rootNodeId: 'node_1',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DialogueViewer(
              dialogueTree: dialogueTree,
              gameService: GameService(),
              onComplete: () {},
            ),
          ),
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
    });

    testWidgets('calls onComplete when dialogue ends', (tester) async {
      bool completed = false;
      final dialogueTree = DialogueTree(
        id: 'test',
        npcName: 'Test NPC',
        nodes: {
          'node_1': DialogueNode(
            id: 'node_1',
            character: 'Test NPC',
            text: 'Goodbye!',
            options: [
              DialogueOption(
                id: 'opt_1',
                text: 'Leave',
                nextDialogueId: 'node_end',
              ),
            ],
          ),
          'node_end': DialogueNode(
            id: 'node_end',
            character: '',
            text: '',
            options: [],
            isEnd: true,
          ),
        },
        rootNodeId: 'node_1',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DialogueViewer(
              dialogueTree: dialogueTree,
              gameService: GameService(),
              onComplete: () => completed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Leave'));
      await tester.pump();

      expect(completed, true);
    });
  });
}
