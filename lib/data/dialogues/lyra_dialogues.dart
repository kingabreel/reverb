import '../../models/dialogue.dart';

class LyraDialogues {
  static DialogueTree getLyraFirstEncounter() {
    final nodes = {
      'node_1': DialogueNode(
        id: 'node_1',
        character: 'Lyra',
        text: 'Você... você é real?',
        options: [
          DialogueOption(
            id: 'option_1_1',
            text: 'Quem é você?',
            nextDialogueId: 'node_2',
          ),
          DialogueOption(
            id: 'option_1_2',
            text: 'O que aconteceu aqui?',
            nextDialogueId: 'node_3',
          ),
        ],
      ),
      'node_2': DialogueNode(
        id: 'node_2',
        character: 'Lyra',
        text: 'Meu nome é Lyra. Eu trabalhava aqui. Antes.',
        options: [
          DialogueOption(
            id: 'option_2_1',
            text: 'Você está ferida?',
            nextDialogueId: 'node_4',
            statChanges: {'confiança': 5.0},
          ),
        ],
      ),
      'node_3': DialogueNode(
        id: 'node_3',
        character: 'Lyra',
        text: 'O tempo não funciona aqui como deveria.',
        options: [
          DialogueOption(
            id: 'option_3_1',
            text: 'Como assim?',
            nextDialogueId: 'node_5',
          ),
        ],
      ),
      'node_4': DialogueNode(
        id: 'node_4',
        character: 'Lyra',
        text: 'Não é nada. Você precisa ir.',
        options: [
          DialogueOption(
            id: 'option_4_1',
            text: 'Deixe-me ajudar.',
            nextDialogueId: 'node_6',
            statChanges: {'ruptura': -5.0},
          ),
        ],
      ),
      'node_5': DialogueNode(
        id: 'node_5',
        character: 'Lyra',
        text: 'Sem tempo para explicar. Você entenderá depois.',
        options: [
          DialogueOption(
            id: 'option_5_1',
            text: 'Eu vou descobrir.',
            nextDialogueId: 'node_6',
            statChanges: {'sincronia': 5.0},
          ),
        ],
      ),
      'node_6': DialogueNode(
        id: 'node_6',
        character: 'Lyra',
        text: 'Talvez você seja diferente. Adeus.',
        options: [],
        isEnd: true,
      ),
    };

    return DialogueTree(
      id: 'lyra_ruins_first',
      npcName: 'Lyra',
      nodes: nodes,
      rootNodeId: 'node_1',
    );
  }

  static DialogueTree getLyraTowerDialogue() {
    final nodes = {
      'node_1': DialogueNode(
        id: 'node_1',
        character: 'Lyra',
        text: 'Você chegou. Eu não acreditava que realmente viria.',
        options: [
          DialogueOption(
            id: 'option_1_1',
            text: 'Claro que vim. O relógio não parava de piscar.',
            nextDialogueId: 'node_2',
            statChanges: {'sincronia': 5.0},
          ),
          DialogueOption(
            id: 'option_1_2',
            text: 'Quem é você? Como sabe meu nome?',
            nextDialogueId: 'node_3',
            statChanges: {'confiança': -2.0},
          ),
        ],
      ),
      'node_2': DialogueNode(
        id: 'node_2',
        character: 'Lyra',
        text: 'O relógio... você ainda o tem? Ele é a única âncora que temos.',
        options: [
          DialogueOption(
            id: 'option_2_1',
            text: 'Está comigo. Sempre.',
            nextDialogueId: 'node_4',
            statChanges: {'sincronia': 3.0},
          ),
        ],
      ),
      'node_3': DialogueNode(
        id: 'node_3',
        character: 'Lyra',
        text: 'Eu sei de coisas que ainda não aconteceram. É... complicado.',
        options: [
          DialogueOption(
            id: 'option_3_1',
            text: 'Tente explicar. Por favor.',
            nextDialogueId: 'node_4',
            statChanges: {'confiança': 3.0},
          ),
        ],
      ),
      'node_4': DialogueNode(
        id: 'node_4',
        character: 'Lyra',
        text: 'Não temos tempo para tudo agora. O eclipse começa em minutos. Precisamos estar prontos.',
        options: [
          DialogueOption(
            id: 'option_4_1',
            text: 'Estou pronto. O que fazemos?',
            nextDialogueId: 'node_5',
          ),
        ],
      ),
      'node_5': DialogueNode(
        id: 'node_5',
        character: 'Lyra',
        text: 'Fique perto. Quando a luz mudar, não solte minha mão. Não importa o que aconteça.',
        options: [
          DialogueOption(
            id: 'option_5_1',
            text: 'Não vou soltar.',
            nextDialogueId: 'node_end',
            statChanges: {'sincronia': 5.0, 'confiança': 5.0},
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
    };

    return DialogueTree(
      id: 'lyra_tower',
      npcName: 'Lyra',
      nodes: nodes,
      rootNodeId: 'node_1',
    );
  }

  static DialogueTree getContatoMadrugadaDialogue() {
    final nodes = {
      'node_1': DialogueNode(
        id: 'node_1',
        character: 'Vendedor',
        text: 'Não te conheço. E não trabalho de graça.',
        options: [
          DialogueOption(
            id: 'option_1_1',
            text: 'Tenho crédito. E informação.',
            nextDialogueId: 'node_2',
            statChanges: {'confiança': 2.0},
          ),
          DialogueOption(
            id: 'option_1_2',
            text: 'Só preciso de um indutor de pulso.',
            nextDialogueId: 'node_2',
          ),
        ],
      ),
      'node_2': DialogueNode(
        id: 'node_2',
        character: 'Vendedor',
        text: 'Informação é moeda forte por aqui. O que você tem?',
        options: [
          DialogueOption(
            id: 'option_2_1',
            text: 'Sei que a DSCE está vasculhando o perímetro.',
            nextDialogueId: 'node_3',
            statChanges: {'sincronia': 3.0},
          ),
        ],
      ),
      'node_3': DialogueNode(
        id: 'node_3',
        character: 'Vendedor',
        text: 'Hmm. Isso vale um desconto. Volta à meia-noite. Sozinho.',
        options: [
          DialogueOption(
            id: 'option_3_1',
            text: 'Estarei aqui.',
            nextDialogueId: 'node_end',
          ),
        ],
        itemReceived: 'indutor_pulso',
      ),
      'node_end': DialogueNode(
        id: 'node_end',
        character: '',
        text: '',
        options: [],
        isEnd: true,
      ),
    };

    return DialogueTree(
      id: 'contato_madrugada',
      npcName: 'Vendedor',
      nodes: nodes,
      rootNodeId: 'node_1',
    );
  }

  static DialogueTree getBalcaoArquivistaDialogue() {
    final nodes = {
      'node_1': DialogueNode(
        id: 'node_1',
        character: 'Arquivista',
        text: 'Este prédio fecha às 18h. Você não deveria estar aqui.',
        options: [
          DialogueOption(
            id: 'option_1_1',
            text: 'Só preciso de um registro antigo.',
            nextDialogueId: 'node_2',
            statChanges: {'confiança': -2.0},
          ),
          DialogueOption(
            id: 'option_1_2',
            text: 'Perdi o horário. Posso dar uma olhada rápida?',
            nextDialogueId: 'node_2',
          ),
        ],
      ),
      'node_2': DialogueNode(
        id: 'node_2',
        character: 'Arquivista',
        text: 'Registros de Aethelgard são sigilosos. Mesmo os antigos.',
        options: [
          DialogueOption(
            id: 'option_2_1',
            text: 'Sei que há algo sobre uma explosão em 2026.',
            nextDialogueId: 'node_3',
            statChanges: {'ruptura': 3.0},
          ),
        ],
      ),
      'node_3': DialogueNode(
        id: 'node_3',
        character: 'Arquivista',
        text: '...Você não é da imprensa, é? Certo. Pasta 47-B. Não diga que fui eu.',
        options: [
          DialogueOption(
            id: 'option_3_1',
            text: 'Obrigado. Não direi.',
            nextDialogueId: 'node_end',
          ),
        ],
        clueDiscovered: 'pasta_47b',
      ),
      'node_end': DialogueNode(
        id: 'node_end',
        character: '',
        text: '',
        options: [],
        isEnd: true,
      ),
    };

    return DialogueTree(
      id: 'balcao_arquivista',
      npcName: 'Arquivista',
      nodes: nodes,
      rootNodeId: 'node_1',
    );
  }

  static DialogueTree getClaraDialogue() {
    final nodes = {
      'node_1': DialogueNode(
        id: 'node_1',
        character: 'Clara',
        text: 'Você não é daqui. Posso sentir. Ninguém mais vem para este lugar.',
        options: [
          DialogueOption(
            id: 'option_1_1',
            text: 'Estou procurando uma aluna chamada Lyra.',
            nextDialogueId: 'node_2',
            statChanges: {'sincronia': 2.0},
          ),
          DialogueOption(
            id: 'option_1_2',
            text: 'Só estava explorando. Esta escola... é estranha.',
            nextDialogueId: 'node_2',
          ),
        ],
      ),
      'node_2': DialogueNode(
        id: 'node_2',
        character: 'Clara',
        text: 'Lyra... houve uma menina com esse nome. Anos atrás. Antes do incêndio.',
        options: [
          DialogueOption(
            id: 'option_2_1',
            text: 'Incêndio?',
            nextDialogueId: 'node_3',
            statChanges: {'ruptura': 2.0},
          ),
        ],
      ),
      'node_3': DialogueNode(
        id: 'node_3',
        character: 'Clara',
        text: 'O laboratório pegou fogo. Ninguém entrou lá depois. Dizem que é... maldição.',
        options: [
          DialogueOption(
            id: 'option_3_1',
            text: 'Onde fica o laboratório?',
            nextDialogueId: 'node_4',
          ),
        ],
      ),
      'node_4': DialogueNode(
        id: 'node_4',
        character: 'Clara',
        text: 'Subindo as escadas, porta trancada. Mas eu já vi você... em outro lugar. Ou será que foi um sonho?',
        options: [
          DialogueOption(
            id: 'option_4_1',
            text: 'Talvez eu seja um sonho.',
            nextDialogueId: 'node_end',
            statChanges: {'sincronia': 4.0},
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
    };

    return DialogueTree(
      id: 'clara_escola',
      npcName: 'Clara',
      nodes: nodes,
      rootNodeId: 'node_1',
    );
  }
}
