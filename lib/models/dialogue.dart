class DialogueOption {
  final String id;
  final String text;
  final String nextDialogueId;
  final String? choiceKey;
  final Map<String, double>? statChanges;

  DialogueOption({
    required this.id,
    required this.text,
    required this.nextDialogueId,
    this.choiceKey,
    this.statChanges,
  });
}

class DialogueNode {
  final String id;
  final String character;
  final String text;
  final List<DialogueOption> options;
  final String? itemReceived;
  final String? clueDiscovered;
  final bool isEnd;

  DialogueNode({
    required this.id,
    required this.character,
    required this.text,
    required this.options,
    this.itemReceived,
    this.clueDiscovered,
    this.isEnd = false,
  });
}

class DialogueTree {
  final String id;
  final String npcName;
  final Map<String, DialogueNode> nodes;
  final String rootNodeId;

  DialogueTree({
    required this.id,
    required this.npcName,
    required this.nodes,
    required this.rootNodeId,
  });

  DialogueNode getRootNode() => nodes[rootNodeId]!;
  DialogueNode? getNodeById(String nodeId) => nodes[nodeId];
}
