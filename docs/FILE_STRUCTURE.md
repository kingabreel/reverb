# 📁 Estrutura Completa do Projeto

## Raiz
```
reverb/
├── android/                    (Android native)
├── ios/                        (iOS native)
├── lib/                        🎯 PRINCIPAL
├── assets/
│   └── bedroom.png             (Imagem única reutilizada)
├── docs/
│   ├── Reverb-Game.md          (Design document original)
│   ├── IMPLEMENTATION_SUMMARY.md (Este documento)
│   └── agents/
│       ├── 00-overview.agent.md
│       ├── 01-systems.agent.md
│       ├── 02-scenes.agent.md
│       ├── 03-dialogues.agent.md
│       ├── 04-ui.agent.md
│       └── 05-implementation.agent.md
├── pubspec.yaml                (Dependências)
├── pubspec.lock                (Lock file)
├── README.md                   (README original)
└── README-IMPLEMENTATION.md    (Guia de implementação)
```

## lib/ - Código Dart

### models/ - Estruturas de Dados (3 arquivos)
```
models/
├── game_state.dart             (GameState, GamePhase, GameChapter, GameVariable)
├── scene.dart                  (Scene, Chapter, Act, Hotspot, Offset)
└── dialogue.dart               (DialogueNode, DialogueOption, DialogueTree)
```

### services/ - Lógica de Negócio (2 arquivos)
```
services/
├── game_service.dart           (Singleton GameService)
└── save_service.dart           (SaveService para persistência)
```

### data/ - Repositório de Conteúdo (1 arquivo)
```
data/
└── content_repository.dart     (ContentRepository com Act 1, diálogos, cenas)
```

### screens/ - Telas Principais (2 arquivos)
```
screens/
├── main_menu_screen.dart       (MainMenuScreen, MenuButton)
└── game_screen.dart            (GameScreen, GameHeader)
```

### widgets/ - Componentes Reutilizáveis (4 arquivos)
```
widgets/
├── scene_viewer.dart           (SceneViewer - renderização de cenas)
├── dialogue_viewer.dart        (DialogueViewer - sistema de diálogos)
├── inventory_widget.dart       (InventoryWidget - painel de itens)
└── statistics_widget.dart      (StatisticsWidget - dimensões temporais)
```

### Root lib/
```
lib/
└── main.dart                   (Ponto de entrada - ReverbApp)
```

## docs/ - Documentação

### agents/ - Planejamento por Agente (5 MDs)
```
docs/agents/
├── 00-overview.agent.md        (Objetivo, pilares, estrutura)
├── 01-systems.agent.md         (Menu, save, loop, escolhas, paradoxo)
├── 02-scenes.agent.md          (8 mapas, cenários, hotspots, economia)
├── 03-dialogues.agent.md       (Diálogos, personagens, conversas)
├── 04-ui.agent.md              (Menu, tela, inventário, feedback)
└── 05-implementation.agent.md  (IMPLEMENTAÇÃO CONCLUÍDA)
```

### Root docs/
```
docs/
├── Reverb-Game.md              (Roteiro completo da narrativa)
├── IMPLEMENTATION_SUMMARY.md   (Resumo da implementação)
└── agents/                     (Ver acima)
```

## assets/ - Recursos Multimídia

```
assets/
└── bedroom.png                 (Única imagem, reutilizada em todos os cenários)
```

## Configuração

```
pubspec.yaml                   (Dependências Flutter)
pubspec.lock                   (Lock file gerado automaticamente)
analysis_options.yaml          (Configuração de análise Dart)
reverb.iml                      (Arquivo de projeto IDE)
README.md                       (README original do projeto)
README-IMPLEMENTATION.md       (Guia de implementação)
```

## Arquivo por Arquivo - Responsabilidades

### lib/models/
- **game_state.dart** (90 linhas)
  - GameState: Gerencia todas as variáveis de jogo
  - Serialização JSON para save/load
  - 4 variáveis principais

- **scene.dart** (60 linhas)
  - Scene: Uma cena individual com hotspots
  - Chapter: Coleção de cenas
  - Act: Coleção de capítulos
  - Hotspot: Objeto interativo na cena

- **dialogue.dart** (40 linhas)
  - DialogueNode: Um nó na árvore de diálogo
  - DialogueOption: Uma opção de resposta
  - DialogueTree: Árvore completa de diálogo

### lib/services/
- **game_service.dart** (70 linhas)
  - Singleton que orquestra todo o jogo
  - Acesso centralizado ao estado
  - Métodos de modificação do estado

- **save_service.dart** (40 linhas)
  - Persistência em memória (MVP)
  - Serialização JSON
  - Interface clean para save/load

### lib/data/
- **content_repository.dart** (450 linhas)
  - Act 1 completo (3 capítulos, 10 cenas)
  - 14 nós de diálogo
  - 30+ hotspots
  - Método factory para cada ato

### lib/screens/
- **main_menu_screen.dart** (110 linhas)
  - MainMenuScreen: Tela inicial
  - MenuButton: Botão reutilizável
  - Lógica de novo jogo / continuar

- **game_screen.dart** (90 linhas)
  - GameScreen: Tela principal de jogo
  - GameHeader: Cabeçalho com informações
  - Orquestra cenas, diálogos e saves

### lib/widgets/
- **scene_viewer.dart** (150 linhas)
  - SceneViewer: Renderiza cena com imagem de fundo
  - Hotspots interativos com posição relativa
  - Seleção e info de hotspots

- **dialogue_viewer.dart** (120 linhas)
  - DialogueViewer: Renderiza árvore de diálogo
  - Aplicação de escolhas e stat changes
  - DialogueViewer: Botões de opção

- **inventory_widget.dart** (60 linhas)
  - InventoryWidget: Painel de itens
  - _InventoryItem: Item individual

- **statistics_widget.dart** (80 linhas)
  - StatisticsWidget: Painel de dimensões temporais
  - _StatBar: Barra visual de progresso

### lib/main.dart (30 linhas)
- ReverbApp: Widget raiz
- Configuração de tema
- Navegação inicial

## Total de Linhas de Código
- **models/**: ~190
- **services/**: ~110
- **data/**: ~450
- **screens/**: ~200
- **widgets/**: ~410
- **main.dart**: ~30
- **TOTAL**: ~1390 linhas de Dart

## Complexidade

- **Classes**: 15+
- **Métodos**: 50+
- **Enums**: 2 (GamePhase, GameChapter)
- **Models com Serialização**: 3
- **Widgets Stateful**: 4
- **Widgets Stateless**: 5+

## Escalabilidade

O projeto foi estruturado para:
✅ Adicionar novos capítulos facilmente (copiar padrão Act 1)
✅ Novos diálogos sem alterar código existente
✅ Novos hotspots apenas em data/
✅ Novos widgets sem tocar em screens/
✅ Suportar 12 capítulos (planned)

## Performance

- Sem lazy loading (ok para 12 capítulos)
- Hotspots renderizam com LayoutBuilder
- Uma imagem compartilhada (economia de memória)
- Diálogos instanciados sob demanda
