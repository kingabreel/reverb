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
        exits: {'exit_sala': 'scene_sala', 'window_view': 'scene_janela'},
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

        exits: {'exit_quarto': 'scene_quarto'},
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
            icon: 'right_arrow',
          ),
          Hotspot(
            id: 'hotspot_ir_cozinha',
            label: 'Cozinha',
            description: 'Entrada da cozinha.',
            position: Offset(0.9, 0.9),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_cozinha',
            icon: 'down_arrow',
          ),
          Hotspot(
            id: 'hotspot_ir_banheiro',
            label: 'Banheiro',
            description: 'Entrada do banheiro.',
            position: Offset(0.5, 0.9),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_banheiro',
            icon: 'down_arrow',
          ),
          Hotspot(
            id: 'hotspot_porta_saída_casa',
            label: 'Sair',
            description: 'A porta que leva para a rua principal.',
            position: Offset(0.05, 0.9),
            radius: 45,
            type: HotspotType.navigate,
            actionValue: 'exit_rua',
            icon: 'left_arrow',
          ),
        ],
        exits: {
          'exit_quarto': 'scene_quarto',
          'exit_cozinha': 'scene_cozinha',
          'exit_banheiro': 'scene_banheiro',
          'exit_rua': 'scene_rua_principal',
          'exit_janela_sala': 'scene_janela_sala',
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

        exits: {'exit_sala': 'scene_sala'},
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
        exits: {'exit_sala_coz': 'scene_sala'},
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
        exits: {'exit_sala_ban': 'scene_sala'},
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
            id: 'hotspot_perimetro_exclusao',
            label: 'Perimetro exclusão',
            description: 'O caminho que leva até o perímetro.',
            position: Offset(0.8, 0.5),
            radius: 55,
            type: HotspotType.navigate,
            actionValue: 'exit_perimetro_exclusao',
          ),
        ],
        exits: {
          'exit_casa': 'scene_sala',
          'exit_beco': 'scene_beco',
          'exit_perimetro_exclusao': 'scene_perimetro_exclusao',
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
        exits: {'exit_beco_volta': 'scene_beco'},
      ),
      'scene_perimetro_exclusao': Scene(
        id: 'scene_perimetro_exclusao',
        name: 'Perímetro de Exclusão',
        description:
            'Cerca de arame farpado ao redor de Aethelgard. Drones patrulham o céu. O ar cheira a ozônio e fumaça.',
        areaName: 'Aethelgard',
        backgroundImage: 'assets/perimeter.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_drones_patrulha',
            label: 'Drones de Vigilância',
            description:
                'Holofotes varrem o chão. Ir de dia é detecção certa; melhor agir à noite.',
            position: Offset(0.5, 0.2),
            radius: 45,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_subestacao_irradiada',
            label: 'Subestação Alpha',
            description:
                'Uma área altamente instável. Sem um medidor Geiger, avançar aqui é suicídio.',
            position: Offset(0.8, 0.6),
            radius: 55,
            type: HotspotType.navigate,
            actionValue: 'exit_subestacao_errada',
          ),
          Hotspot(
            id: 'hotspot_cerca_cortada',
            label: 'Cerca Rompida',
            description:
                'Um corte na grade que parece dar acesso aos fundos das ruínas.',
            position: Offset(0.3, 0.7),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_invasao_ruinas',
          ),
          Hotspot(
            id: 'hotspot_perimetro_volta',
            label: 'Voltar',
            description: 'Retornar para a rua principal.',
            position: Offset(0.05, 0.5),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_rua_principal',
            icon: 'left_arrow',
          ),
        ],
        exits: {
          'exit_subestacao_errada': 'scene_perimetro_exclusao',
          'exit_invasao_ruinas': 'scene_ruinas',
          'exit_rua_principal': 'scene_rua_principal',
        },
      ),
      'scene_distrito_sucateiros': Scene(
        id: 'scene_distrito_sucateiros',
        name: 'Distrito dos Sucateiros',
        description:
            'Uma favela tecnológica vertical. Luzes de neon baratas piscam entre fiação exposta e becos úmidos.',
        areaName: 'Subúrbio',
        backgroundImage: 'assets/scrapyard_district.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_contato_madrugada',
            label: 'Docas de Carga',
            description:
                'O contrabandista de tecnologia só aparece aqui durante a madrugada.',
            position: Offset(0.75, 0.5),
            radius: 50,
            type: HotspotType.dialogue,
          ),
          Hotspot(
            id: 'hotspot_beco_armadilha',
            label: 'Beco Escuro',
            description:
                'Um atalho silencioso, mas com forte risco de emboscada se você não estiver armado.',
            position: Offset(0.4, 0.6),
            radius: 45,
            type: HotspotType.navigate,
            actionValue: 'exit_beco_errado',
          ),
          Hotspot(
            id: 'hotspot_banca_pecas',
            label: 'Banca de Sucata',
            description:
                'Componentes quânticos velhos e ferramentas de hacking improvisadas.',
            position: Offset(0.2, 0.7),
            radius: 40,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_sucateiros_volta',
            label: 'Voltar',
            description: 'Retornar para a rua principal.',
            position: Offset(0.05, 0.9),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_rua_principal',
            icon: 'left_arrow',
          ),
        ],
        exits: {
          'exit_beco_errado': 'scene_distrito_sucateiros',
          'exit_rua_principal': 'scene_rua_principal',
        },
      ),
      'scene_arquivo_morto': Scene(
        id: 'scene_arquivo_morto',
        name: 'Arquivo Morto Municipal',
        description:
            'Prateleiras colossais de poeira e papel. O silêncio é quebrado apenas pelo zumbido das lâmpadas fluorescentes antigas.',
        areaName: 'Centro',
        backgroundImage: 'assets/municipal_archive.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_balcao_arquivista',
            label: 'Balcão de Atendimento',
            description:
                'A arquivista só trabalha em horário comercial. À noite, o local fica sob tranca.',
            position: Offset(0.5, 0.4),
            radius: 40,
            type: HotspotType.dialogue,
          ),
          Hotspot(
            id: 'hotspot_labirinto_papeis',
            label: 'Corredor de Registros Cíveis',
            description:
                'Milhares de pastas antigas. Investigar sem uma coordenada precisa fará você perder horas do seu dia.',
            position: Offset(0.85, 0.5),
            radius: 60,
            type: HotspotType.navigate,
            actionValue: 'exit_perda_tempo',
          ),
          Hotspot(
            id: 'hotspot_arquivos_aethelgard',
            label: 'Terminal Histórico',
            description:
                'Registros antigos da fundação do Instituto antes do sigilo corporativo.',
            position: Offset(0.2, 0.5),
            radius: 35,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_arquivo_volta',
            label: 'Voltar',
            description: 'Sair do prédio municipal.',
            position: Offset(0.05, 0.8),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_rua_principal',
            icon: 'left_arrow',
          ),
        ],
        exits: {
          'exit_perda_tempo': 'scene_arquivo_morto',
          'exit_rua_principal': 'scene_rua_principal',
        },
      ),
      'scene_floresta_estatica': Scene(
        id: 'scene_floresta_estatica',
        name: 'Floresta Estática',
        description:
            'Os limites da cidade afetados pela Fratura. Folhas flutuam congeladas no ar e a névoa entrópica distorce o horizonte.',
        areaName: 'Periferia',
        backgroundImage: 'assets/static_forest.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_caixa_descarte',
            label: 'Tronco Oco',
            description:
                'Um ponto onde as linhas se cruzam. Lyra deixa objetos no futuro dela que aparecem aqui para você no presente.',
            position: Offset(0.5, 0.7),
            radius: 40,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_trilha_anomala',
            label: 'Trilha Norte',
            description:
                'Se o vento estiver soprando para trás, esta trilha avança. Caso contrário, você andará em círculos.',
            position: Offset(0.8, 0.4),
            radius: 50,
            type: HotspotType.navigate,
            actionValue: 'exit_loop_floresta',
          ),
          Hotspot(
            id: 'hotspot_nevoa_temporal',
            label: 'Névoa Entrópica',
            description:
                'A névoa diminui apenas durante o amanhecer. Cruzá-la agora causará fadiga severa.',
            position: Offset(0.2, 0.3),
            radius: 55,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_floresta_volta',
            label: 'Voltar',
            description: 'Deixar os limites da floresta.',
            position: Offset(0.05, 0.6),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_rua_principal',
            icon: 'left_arrow',
          ),
        ],
        exits: {
          'exit_loop_floresta': 'scene_floresta_estatica',
          'exit_rua_principal': 'scene_rua_principal',
        },
      ),
      // Scenes from cap 2
      'scene_apartamento_kael': Scene(
        id: 'scene_apartamento_kael',
        name: 'Apartamento de Monitoramento',
        description:
            'Seu novo lar compulsório. Pequeno, frio e vigiado. O zumbido da tornozeleira eletrônica em sua perna é constante.',
        areaName: 'Zona de Contenção B',
        backgroundImage: 'assets/kael_apartment.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_tornozeleira',
            label: 'Tornozeleira Eletrônica',
            description:
                'Emite um pulso de rádio a cada 10 segundos. Se eu sair do perímetro urbano sem um indutor de pulso, o Setor 4 saberá instantaneamente.',
            position: Offset(0.5, 0.85),
            radius: 30,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_quadro_investigacao',
            label: 'Mural de Linhas',
            description:
                'Fotos cortadas de jornais, mapas e um nome circulado em vermelho: LYRA THORNE.',
            position: Offset(0.3, 0.4),
            radius: 60,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_janela_vigia',
            label: 'Janela',
            description:
                'Uma viatura militar da DSCE está estacionada na esquina. Eles estão sempre olhando.',
            position: Offset(0.75, 0.35),
            radius: 45,
            type: HotspotType.navigate,
            actionValue: 'exit_janela_vigia',
          ),
          Hotspot(
            id: 'hotspot_porta_apartamento',
            label: 'Sair para o Corredor',
            description: 'Acesso às escadas de incêndio do prédio.',
            position: Offset(0.95, 0.6),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_corredor',
          ),
        ],
        exits: {
          'exit_janela_vigia': 'scene_janela_vigia',
          'exit_corredor': 'scene_distrito_sucateiros',
        },
      ),
      'scene_escola_abandonada': Scene(
        id: 'scene_escola_abandonada',
        name: 'Escola Primária St. Jude (Fachada)',
        description:
            'Abandonada desde a explosão de 2026. Parquinhos enferrujados e pichações de advertência biológica nas paredes de tijolos.',
        areaName: 'Distrito Antigo',
        backgroundImage: 'assets/abandoned_school.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_npc_clara',
            label: 'Zeladora Clara',
            description:
                'Uma senhora idosa que se recusa a deixar as redondezas da escola.',
            position: Offset(0.65, 0.6),
            radius: 50,
            type: HotspotType.dialogue,
          ),
          Hotspot(
            id: 'hotspot_porta_principal_escola',
            label: 'Porta Principal',
            description:
                'Trancada com correntes pesadas e um cadeado eletrônico militar antigo.',
            position: Offset(0.45, 0.55),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_escola_interior',
          ),
          Hotspot(
            id: 'hotspot_retorno_escola_rua',
            label: 'Voltar',
            description: 'Retornar para o veículo ou para o mapa urbano.',
            position: Offset(0.05, 0.5),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_rua_principal',
            icon: 'left_arrow',
          ),
        ],
        exits: {
          'exit_escola_interior': 'scene_escola_diretoria',
          'exit_rua_principal': 'scene_distrito_sucateiros',
        },
      ),
      'scene_escola_diretoria': Scene(
        id: 'scene_escola_diretoria',
        name: 'Diretoria da Escola',
        description:
            'Armários de arquivos revirados. Cadeiras quebradas e poeira acumulada cobrindo fichas de alunos antigos.',
        areaName: 'Escola St. Jude',
        backgroundImage: 'assets/school_office.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_gaveteiro_t',
            label: 'Arquivos Letras T-Z',
            description:
                'Onde deveriam estar os registros de "Thorne". O gaveteiro está trancado por um segredo de engrenagens mecânicas.',
            position: Offset(0.25, 0.6),
            radius: 45,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_computador_diretoria',
            label: 'Terminal da Secretaria',
            description:
                'Um computador antigo com monitor de fósforo verde. Parece ter energia residual, mas pede uma senha administrativa.',
            position: Offset(0.6, 0.5),
            radius: 40,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_alcapao_subsolo',
            label: 'Alçapão Inundado',
            description:
                'Leva ao porão de arquivos mortos da escola. Há um cadeado enferrujado.',
            position: Offset(0.5, 0.85),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_escola_subsolo',
          ),
        ],
        exits: {'exit_escola_subsolo': 'scene_escola_subsolo'},
      ),
      'scene_escola_subsolo': Scene(
        id: 'scene_escola_subsolo',
        name: 'Subsolo da Escola',
        description:
            'Um porão escuro, úmido e mofado. Canos estourados gotejam água radioativa azulada. Uma densa névoa entrópica flutua aqui.',
        areaName: 'Escola St. Jude',
        backgroundImage: 'assets/school_basement.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_caixa_estatica',
            label: 'Cofre Quântico Oculto',
            description:
                'Um cofre que não deveria pertencer a uma escola primária. Ele vibra sutilmente na mesma frequência do relógio de Lyra.',
            position: Offset(0.5, 0.5),
            radius: 50,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_volta_diretoria',
            label: 'Subir',
            description: 'Voltar para a diretoria.',
            position: Offset(0.05, 0.5),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_diretoria_volta',
          ),
        ],
        exits: {'exit_diretoria_volta': 'scene_escola_diretoria'},
      ),
      // Scenes from cap 3
      'scene_torre_base': Scene(
        id: 'scene_torre_base',
        name: 'Base da Torre de Oakhaven',
        description:
            'Uma megaestrutura de aço que rasga as nuvens. O perímetro está trancado por portões pneumáticos da DSCE e geradores de pulso blindados.',
        areaName: 'Montanha Alta',
        backgroundImage: 'assets/tower_base.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_portao_pneumatico',
            label: 'Portão de Alta Segurança',
            description:
                'Trancado por um sistema de criptografia que exige sobrecarga de energia externa. Forçá-lo disparará os alarmes civis.',
            position: Offset(0.5, 0.65),
            radius: 50,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_gerador_blindado',
            label: 'Subestação de Alimentação',
            description:
                'Alimenta a grade de defesa da torre. Precisa ser sincronizado com uma frequência reversa para abrir os portões sem alertar Vesper.',
            position: Offset(0.8, 0.7),
            radius: 45,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_mapa_retorno_torre',
            label: 'Voltar ao Distrito',
            description:
                'Retornar para a oficina de Jude para buscar ferramentas.',
            position: Offset(0.05, 0.5),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_to_sucateiros',
            icon: 'left_arrow',
          ),
        ],
        exits: {
          'exit_to_sucateiros': 'scene_distrito_sucateiros',
          'exit_torre_topo': 'scene_torre_topo',
        },
      ),
      'scene_observatorio_antigo': Scene(
        id: 'scene_observatorio_antigo',
        name: 'Observatório Astronômico Abandonado',
        description:
            'Anexo à colina da torre. A cúpula de vidro está estilhaçada, mas o telescópio de refração quântica e os computadores de lentes ainda recebem energia.',
        areaName: 'Montanha Alta',
        backgroundImage: 'assets/old_observatory.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_telescopio_quantico',
            label: 'Telescópio de Refração',
            description:
                'Capaz de enxergar flutuações na luz UV causadas pela distorção temporal. Essencial para mapear o epicentro do Eclipse.',
            position: Offset(0.4, 0.45),
            radius: 60,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_console_lentes',
            label: 'Console de Alinhamento',
            description:
                'Controla a rotação dos espelhos da torre. Exige a calibração de três vetores magnéticos.',
            position: Offset(0.7, 0.6),
            radius: 40,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_saida_observatorio',
            label: 'Sair para a Base',
            description: 'Voltar para a base da torre.',
            position: Offset(0.05, 0.8),
            radius: 40,
            type: HotspotType.navigate,
            actionValue: 'exit_to_torre_base',
          ),
        ],
        exits: {'exit_to_torre_base': 'scene_torre_base'},
      ),
      'scene_torre_topo': Scene(
        id: 'scene_torre_topo',
        name: 'Plataforma Superior da Torre',
        description:
            'Acima da névoa do mundo. O vento é violento, o céu está coalhado de estrelas estáticas que não piscam. O Motor de Transmissão ronca no centro.',
        areaName: 'Topo do Mundo',
        backgroundImage: 'assets/tower_apex.png',
        hotspots: [
          Hotspot(
            id: 'hotspot_antena_transmissora',
            label: 'Núcleo da Antena',
            description:
                'Onde o feixe de energia taquiônica se concentrará às 03:14.',
            position: Offset(0.5, 0.3),
            radius: 55,
            type: HotspotType.examine,
          ),
          Hotspot(
            id: 'hotspot_lyra_janela_30',
            label: 'Silhueta na Névoa',
            description:
                'Uma mulher vestindo um sobretudo militar gasto, observando as estrelas. Ela parece forte, focada... e viva.',
            position: Offset(0.5, 0.65),
            radius: 70,
            type: HotspotType.dialogue,
          ),
        ],
        exits: {'exit_descida_emergencia': 'scene_torre_base'},
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
