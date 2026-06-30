import 'package:flutter/material.dart';
import '../models/dialogue.dart';
import '../services/game_service.dart';

class DialogueViewer extends StatefulWidget {
  final DialogueTree dialogueTree;
  final VoidCallback onComplete;
  final GameService gameService;

  const DialogueViewer({
    required this.dialogueTree,
    required this.onComplete,
    required this.gameService,
    super.key,
  });

  @override
  State<DialogueViewer> createState() => _DialogueViewerState();
}

class _DialogueViewerState extends State<DialogueViewer> {
  late DialogueNode currentNode;

  @override
  void initState() {
    super.initState();
    currentNode = widget.dialogueTree.getRootNode();
  }

  void _selectOption(DialogueOption option) {
    if (option.statChanges != null) {
      option.statChanges!.forEach((stat, delta) {
        _applyStat(stat, delta);
      });
    }

    if (option.choiceKey != null) {
      widget.gameService.recordChoice(option.choiceKey!, true);
    }

    if (currentNode.itemReceived != null) {
      widget.gameService.addInventoryItem(currentNode.itemReceived!);
    }

    if (currentNode.clueDiscovered != null) {
      widget.gameService.addClue(currentNode.clueDiscovered!);
    }

    final nextNode = widget.dialogueTree.getNodeById(option.nextDialogueId);
    if (nextNode == null) {
      widget.onComplete();
      return;
    }

    if (nextNode.isEnd) {
      _applyStatChanges(nextNode);
      widget.onComplete();
      return;
    }

    setState(() {
      currentNode = nextNode;
    });
  }

  void _applyStatChanges(DialogueNode node) {
    if (node.itemReceived != null) {
      widget.gameService.addInventoryItem(node.itemReceived!);
    }
    if (node.clueDiscovered != null) {
      widget.gameService.addClue(node.clueDiscovered!);
    }
  }

  void _applyStat(String stat, double delta) {
    switch (stat) {
      case 'sincronia':
        widget.gameService.updateSincronia(delta);
        break;
      case 'ruptura':
        widget.gameService.updateRuptura(delta);
        break;
      case 'lyraConfianca':
        widget.gameService.updateLyraConfianca(delta);
        break;
      case 'judeLoyalty':
        widget.gameService.updateJudeLoyalty(delta);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentNode.character,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: const Color(0xFF00D9FF),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          currentNode.text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        if (currentNode.options.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: currentNode.options
                .map((option) => _OptionButton(
              option: option,
              onPressed: () => _selectOption(option),
            ))
                .toList(),
          ),
      ],
    );
  }
}

class _OptionButton extends StatelessWidget {
  final DialogueOption option;
  final VoidCallback onPressed;

  const _OptionButton({
    required this.option,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00D9FF).withValues(alpha: 0.1),
            side: const BorderSide(
              color: Color(0xFF00D9FF),
              width: 1,
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text(
            option.text,
            style: const TextStyle(
              color: Color(0xFF00D9FF),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
