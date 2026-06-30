import '../models/scene.dart';
import '../models/game_map.dart';
import '../models/dialogue.dart';

class ContentRepository {
  static final ContentRepository _instance = ContentRepository._internal();

  factory ContentRepository() {
    return _instance;
  }

  ContentRepository._internal();

  GameMap getGameMap() {
    final scenes = _buildAllScenes();

    return GameMap(
      id: 'game_world',
      name: 'Mundo de Reverb',
      scenes: scenes,
      startSceneId: 'scene_quarto',
    );
  }

  Map<String, Scene> _buildAllScenes() {
    return {
      'scene_quarto': Scene(
        id: 'scene_quarto',
        name: 'Quarto',
        description: 'Seu quarto. Você acorda. Uma porta à direita.',
        areaName: 'Casa',
        backgroundImage: 'assets/bedroom.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_relógio',
            label: 'Relógio',
            description: 'Um relógio digital comum, marcando 05:03.',
            position: Offset(0.45, 0.15),
            radius: 40,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_janela',
            label: 'Janela',
            description: 'Janelas com vista para o pátio.',
            position: Offset(0.2, 0.3),
            radius: 60,
            type: HotspotType.navigate,
            actionValue: 'window_view',
            linkedSceneId: 'scene_janela',
          ),
          Hotspot(
            id: 'hotspot_cama',
            label: 'Cama',
            description: 'Uma cama simples com lençóis limpos.',
            position: Offset(0.65, 0.75),
            radius: 50,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_porta_saída',
            label: 'Sair',
            description: 'Abra a porta e saia para a sala.',
            position: Offset(0.95, 0.5),
            radius: 50,
            type: HotspotType.navigate,
            actionValue: 'exit_sala',
          ),
        ],
        exits: {
          'exit_sala': 'scene_sala',
          'window_view': 'scene_janela',
        },
      ),
      'scene_janela': Scene(
        id: 'scene_janela',
        name: 'Janela do Quarto',
        description: 'A vista da janela do quarto. O pátio está calmo.',
        areaName: 'Casa',
        backgroundImage: 'assets/window.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_volta_quarto',
            label: 'Voltar',
            description: 'Voltar para o quarto.',
            position: Offset(0.05, 0.5),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_quarto',
            linkedSceneId: 'scene_quarto',
          ),
        ],
        
        exits: {
          'exit_quarto': 'scene_quarto',
        },
      ),
      'scene_sala': Scene(
        id: 'scene_sala',
        name: 'Sala',
        description: 'A sala da casa. Sofá, TV, janelas com vista para a rua.',
        areaName: 'Casa',
        backgroundImage: 'assets/living_room.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_sofá',
            label: 'Sofá',
            description: 'Um sofá confortável, um pouco desgastado.',
            position: Offset(0.7, 0.7),
            radius: 60,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_janela_sala',
            label: 'Janela',
            description: 'Vista para a rua principal. Dia comum.',
            position: Offset(0.1, 0.3),
            radius: 50,
            type: HotspotType.navigate,
            actionValue: 'exit_janela_sala',
          ),
          Hotspot(
            id: 'hotspot_tv',
            label: 'TV',
            description: 'Uma TV antiga. A tela está desligada.',
            position: Offset(0.6, 0.5),
            radius: 40,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_volta_quarto',
            label: 'Quarto',
            description: 'Voltar para o quarto.',
            position: Offset(0.95, 0.5),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_quarto',
            icon: 'right_arrow'
          ),
          Hotspot(
            id: 'hotspot_ir_cozinha',
            label: 'Cozinha',
            description: 'Entrada da cozinha.',
            position: Offset(0.9, 0.9),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_cozinha',
            icon: 'down_arrow'
          ),
          Hotspot(
            id: 'hotspot_ir_banheiro',
            label: 'Banheiro',
            description: 'Entrada do banheiro.',
            position: Offset(0.5, 0.9),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_banheiro',
            icon: 'down_arrow'
          ),
          Hotspot(
            id: 'hotspot_porta_saída_casa',
            label: 'Sair',
            description: 'A porta que leva para a rua principal.',
            position: Offset(0.05, 0.9),
            radius: 45,
            type: HotspotType.navigate,
            actionValue: 'exit_rua',
            icon: 'left_arrow'
          ),
        ],
        exits: {
          'exit_quarto': 'scene_quarto',
          'exit_cozinha': 'scene_cozinha',
          'exit_banheiro': 'scene_banheiro',
          'exit_rua': 'scene_rua_principal',
          'exit_janela_sala': 'scene_janela_sala'
        },
      ),
      'scene_janela_sala': Scene(
        id: 'scene_janela_sala',
        name: 'Janela da Sala',
        description: 'A vista da janela da sala. Nada para ver aqui',
        areaName: 'Casa',
        backgroundImage: 'assets/window_living_room.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_volta_sala',
            label: 'Voltar',
            description: 'Voltar para o sala.',
            position: Offset(0.5, 0.5),
            radius: 60,
            type: HotspotType.navigate,
            actionValue: 'exit_sala',
            linkedSceneId: 'scene_sala',
          ),
        ],
        
        exits: {
          'exit_sala': 'scene_sala',
        },
      ),
      'scene_cozinha': Scene(
        id: 'scene_cozinha',
        name: 'Cozinha',
        description: 'A cozinha. Geladeira, fogão, pia com louça acumulada.',
        areaName: 'Casa',
        backgroundImage: 'assets/kitchen.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_geladeira',
            label: 'Geladeira',
            description: 'Uma geladeira branca, barulhento.',
            position: Offset(0.92, 0.5),
            radius: 50,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_fogão',
            label: 'Fogão',
            description: 'Um fogão de 4 bocas. Precisa de limpeza.',
            position: Offset(0.8, 0.8),
            radius: 45,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_mesa_cozinha',
            label: 'Mesa',
            description: 'Uma mesa de madeira. Tem algumas tigelas e pratos.',
            position: Offset(0.5, 0.8),
            radius: 45,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_volta_sala_coz',
            label: 'Voltar',
            description: 'Voltar para a sala.',
            position: Offset(0.05, 0.5),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_sala_coz',
          ),
        ],
        exits: {
          'exit_sala_coz': 'scene_sala',
        },
      ),
      'scene_banheiro': Scene(
        id: 'scene_banheiro',
        name: 'Banheiro',
        description: 'O banheiro. Espelho, chuveiro, pia com azulejos brancos.',
        areaName: 'Casa',
        backgroundImage: 'assets/bathroom.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_espelho',
            label: 'Espelho',
            description: 'Um espelho sobre a pia. Você vê seu reflexo.',
            position: Offset(0.5, 0.5),
            radius: 40,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_chuveiro',
            label: 'Chuveiro',
            description: 'Um box com chuveiro. Vidro ligeiramente embaçado.',
            position: Offset(0.9, 0.4),
            radius: 50,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_volta_sala_ban',
            label: 'Voltar',
            description: 'Voltar para a sala.',
            position: Offset(0.06, 0.5),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_sala_ban',
          ),
        ],
        exits: {
          'exit_sala_ban': 'scene_sala',
        },
      ),
      'scene_rua_principal': Scene(
        id: 'scene_rua_principal',
        name: 'Rua Principal',
        description: 'A rua principal. Casas, árvores. Aethelgard ao longe.',
        areaName: 'Rua',
        backgroundImage: 'assets/street_day.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_sua_casa',
            label: 'Sua casa',
            description: 'Pode voltar para casa.',
            position: Offset(0.1, 0.6),
            radius: 50,
            type: HotspotType.navigate,
            actionValue: 'exit_casa',
          ),
          Hotspot(
            id: 'hotspot_beco_lateral',
            label: 'Beco',
            description: 'Um beco que leva às ruínas de Aethelgard.',
            position: Offset(0.3, 0.7),
            radius: 45,
            type: HotspotType.navigate,
            actionValue: 'exit_beco',
          ),
          Hotspot(
            id: 'hotspot_caminho_escola',
            label: 'Escola',
            description: 'O caminho que leva até a escola.',
            position: Offset(0.8, 0.5),
            radius: 55,
            type: HotspotType.navigate,
            actionValue: 'exit_escola',
          ),
        ],
        exits: {
          'exit_casa': 'scene_sala',
          'exit_beco': 'scene_beco',
          'exit_escola': 'scene_rua_escola',
        },
      ),
      'scene_beco': Scene(
        id: 'scene_beco',
        name: 'Beco',
        description: 'Um beco escuro. Luz azul pisca nas profundezas.',
        areaName: 'Rua',
        backgroundImage: 'assets/ruines.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_ruínas_entrada',
            label: 'Ruínas',
            description: 'As ruínas do Instituto. Portal azul pisca.',
            position: Offset(0.7, 0.4),
            radius: 60,
            type: HotspotType.navigate,
            actionValue: 'exit_ruinas',
          ),
          Hotspot(
            id: 'hotspot_volta_rua_beco',
            label: 'Voltar',
            description: 'Voltar para a rua principal.',
            position: Offset(0.1, 0.5),
            radius: 45,
            type: HotspotType.navigate,
            actionValue: 'exit_rua_beco',
          ),
        ],
        exits: {
          'exit_ruinas': 'scene_ruinas',
          'exit_rua_beco': 'scene_rua_principal',
        },
      ),
      'scene_ruinas': Scene(
        id: 'scene_ruinas',
        name: 'Ruínas de Aethelgard',
        description: 'Instituto destruído. Fumaça, metal, luz azul pulsante.',
        areaName: 'Aethelgard',
        backgroundImage: 'assets/deep_ruines.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_metal_fragmento',
            label: 'Fragmento',
            description: 'Metal deformado, ainda quente.',
            position: Offset(0.3, 0.5),
            radius: 35,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_luz_pulsante',
            label: 'Luz azul',
            description: 'Uma luz que pisca ritmicamente.',
            position: Offset(0.7, 0.3),
            radius: 50,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_lyra_ruinas',
            label: 'Lyra',
            description: 'Mulher com olhos azuis, caída nos escombros.',
            position: Offset(0.5, 0.6),
            radius: 80,
            type: HotspotType.dialogue,
          ),
          Hotspot(
            id: 'hotspot_volta_beco',
            label: 'Voltar',
            description: 'Voltar para o beco.',
            position: Offset(0.1, 0.7),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_beco_volta',
          ),
        ],
        exits: {
          'exit_beco_volta': 'scene_beco',
        },
      ),
      'scene_rua_escola': Scene(
        id: 'scene_rua_escola',
        name: 'Caminho Escola',
        description: 'Caminho até a escola. Ruas comuns, casas.',
        areaName: 'Rua',
        backgroundImage: 'assets/bedroom.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_escola_entrada',
            label: 'Escola',
            description: 'Entrada da escola. Portão de ferro.',
            position: Offset(0.8, 0.5),
            radius: 55,
            type: HotspotType.navigate,
            actionValue: 'exit_escola_entrada',
          ),
          Hotspot(
            id: 'hotspot_volta_rua_principal',
            label: 'Voltar',
            description: 'Voltar para a rua principal.',
            position: Offset(0.1, 0.5),
            radius: 45,
            type: HotspotType.navigate,
            actionValue: 'exit_rua_volta',
          ),
        ],
        exits: {
          'exit_escola_entrada': 'scene_escola',
          'exit_rua_volta': 'scene_rua_principal',
        },
      ),
      'scene_escola': Scene(
        id: 'scene_escola',
        name: 'Escola - Sala de Aula',
        description: 'Sala de aula. Carteiras, quadro, professor, Jude dormindo.',
        areaName: 'Escola',
        backgroundImage: 'assets/bedroom.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_professor',
            label: 'Professor',
            description: 'Professor entediado, aula de matemática.',
            position: Offset(0.5, 0.2),
            radius: 50,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_jude',
            label: 'Jude',
            description: 'Melhor amigo. Dormindo na carteira.',
            position: Offset(0.7, 0.5),
            radius: 40,
            type: HotspotType.dialogue,
          ),
          Hotspot(
            id: 'hotspot_entrada_biblioteca',
            label: 'Biblioteca',
            description: 'Entrada da biblioteca escolar.',
            position: Offset(0.1, 0.5),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_biblioteca',
          ),
          Hotspot(
            id: 'hotspot_saida_escola',
            label: 'Sair',
            description: 'Sair da sala de aula.',
            position: Offset(0.95, 0.5),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_escola_saida',
          ),
        ],
        exits: {
          'exit_biblioteca': 'scene_biblioteca',
          'exit_escola_saida': 'scene_rua_escola',
        },
      ),
      'scene_biblioteca': Scene(
        id: 'scene_biblioteca',
        name: 'Biblioteca',
        description: 'Biblioteca da escola. Livros, computadores, silêncio.',
        areaName: 'Escola',
        backgroundImage: 'assets/bedroom.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_computador',
            label: 'Computador',
            description: 'Terminal com arquivos municipais.',
            position: Offset(0.5, 0.5),
            radius: 60,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_jornais_antigos',
            label: 'Jornais',
            description: 'Reportagens sobre "Catástrofe de Aethelgard".',
            position: Offset(0.2, 0.4),
            radius: 50,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_volta_sala_aula',
            label: 'Voltar',
            description: 'Voltar para a sala de aula.',
            position: Offset(0.95, 0.5),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_sala_aula',
          ),
        ],
        exits: {
          'exit_sala_aula': 'scene_escola',
        },
      ),
    };
  }

  DialogueTree getDialogueForNpc(String npcId, String context) {
    if (npcId == 'lyra' && context == 'ruinas_first') {
      return _getLyraFirstEncounter();
    }
    if (npcId == 'jude' && context == 'school') {
      return _getJudeDialogue();
    }
    return DialogueTree(
      id: 'empty',
      npcName: 'Unknown',
      nodes: {},
      rootNodeId: 'root',
    );
  }

  DialogueTree _getLyraFirstEncounter() {
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

  DialogueTree _getJudeDialogue() {
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

