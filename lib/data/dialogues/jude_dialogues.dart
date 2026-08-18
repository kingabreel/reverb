import '../../models/dialogue.dart';

class JudeDialogues {
  static DialogueTree getJudeSchoolDialogue() {
    final nodes = {
      'node_1': DialogueNode(
        id: 'node_1',
        character: 'Jude',
        text: 'Ei, acordou! Aula entediante, né?',
        options: [
          DialogueOption(
            id: 'option_1_1',
            text: 'Vamo para a biblioteca?',
            nextDialogueId: 'node_2',
          ),
        ],
      ),
      'node_2': DialogueNode(
        id: 'node_2',
        character: 'Jude',
        text: 'Claro. Preciso dormir mais.',
        options: [],
        isEnd: true,
      ),
    };

    return DialogueTree(
      id: 'jude_school',
      npcName: 'Jude',
      nodes: nodes,
      rootNodeId: 'node_1',
    );
  }
}
