# Arquitetura de Navegação Refatorada - REVERB Game

## Visão Geral

O sistema de navegação foi refatorado de um modelo linear (capítulos → cenas sequenciais) para um modelo de grafo (scene graph), permitindo livre navegação entre locais do mundo do jogo.

## Estrutura de Dados

### 1. Scene Model (lib/models/scene.dart)

```dart
enum HotspotType {
  examine,      // Apenas examina
  navigate,     // Abre portal para outro local
  dialogue,     // Inicia conversa com NPC
  item,         // Coleta item (future)
}

class Hotspot {
  String id;                    // hotspot_porta_saída, hotspot_lyra, etc
  String label;                 // Exibição: "Sair", "Lyra"
  String description;           // Descrição ao inspecionar
  Offset position;              // Posição normalizada (0.0-1.0)
  double radius;                // Raio clicável
  HotspotType type;            // Tipo de interação
  String? actionValue;          // Qual exit usar: 'exit_sala', 'exit_beco'
}

class Scene {
  String id;                    // scene_quarto, scene_sala
  String name;                  // "Quarto", "Sala"
  String description;           // Descrição textual
  String areaName;              // "Casa", "Rua", "Escola"
  String backgroundImage;       // assets/bedroom.png
  List<Hotspot> hotspots;      // Pontos interativos
  Map<String, String> exits;   // {"exit_sala": "scene_sala", ...}
}
```

### 2. GameMap Model (lib/models/game_map.dart)

```dart
class GameMap {
  String id;                    // game_world
  String name;                  // Título do mapa
  Map<String, Scene> scenes;   // Todas as cenas indexadas por ID
  String startSceneId;          // Cena inicial: scene_quarto
}
```

## Fluxo de Navegação

### Modelo Linear (ANTIGO)

```
Act 1
  └── Chapter 1 (scenes: [scene_1_1, scene_1_2, scene_1_3, scene_1_4])
        └── Scene 1.1 (nextSceneId = scene_1_2)
        └── Scene 1.2 (nextSceneId = scene_1_3)
        ...
```

**Problema:** Um caminho apenas. Sem liberdade de movimento. "Next" button força sequência.

### Modelo de Grafo (NOVO)

```
GameMap
  ├── scene_quarto (exits: {exit_sala: scene_sala})
  ├── scene_sala (exits: {exit_quarto, exit_cozinha, exit_banheiro, exit_rua})
  ├── scene_cozinha (exits: {exit_sala})
  ├── scene_banheiro (exits: {exit_sala})
  ├── scene_rua_principal (exits: {exit_casa, exit_beco, exit_escola})
  ├── scene_beco (exits: {exit_ruinas, exit_rua_beco})
  ├── scene_ruinas (exits: {exit_beco_volta})
  ├── scene_rua_escola (exits: {exit_escola, exit_rua_volta})
  ├── scene_escola (exits: {exit_biblioteca, exit_escola_saida})
  └── scene_biblioteca (exits: {exit_sala_aula})
```

**Vantagem:** Múltiplos caminhos. Livre retorno. Mundo aberto simulado.

## Fluxo de Interação

### 1. Clique em Hotspot

```
SceneViewer.onTap(hotspotId)
  → GameScreen._handleHotspotInteraction(hotspotId)
    ├─ [Se tipo == navigate]
    │   └─ _navigateToScene(destinationId)
    │       → setState(currentScene = novaScene)
    │
    ├─ [Se tipo == dialogue]
    │   └─ _showDialogueForHotspot(hotspotId)
    │       → DialogueViewer em BottomSheet
    │
    └─ [Se tipo == examine]
        └─ Exibir SnackBar com hotspot.description
```

### 2. Navegação Automática

```dart
// Hotspot com actionValue
Hotspot(
  id: 'hotspot_porta_saída',
  type: HotspotType.navigate,
  actionValue: 'exit_sala',  // ← Qual exit usar
)

// GameScreen resolve
final destinationId = currentScene.exits['exit_sala']
// = 'scene_sala'

_navigateToScene('scene_sala')
// Carrega Scene por ID global via GameMap
```

### 3. Resolução de Exit

```
Scene.exits = {
  'exit_sala': 'scene_sala',      // Nome → ID de destino
  'exit_cozinha': 'scene_cozinha',
  'exit_banheiro': 'scene_banheiro',
  'exit_rua': 'scene_rua_principal'
}

// Quando hotspot com actionValue='exit_sala' é clicado:
currentScene.exits['exit_sala']  // Retorna 'scene_sala'
gameMap.getScene('scene_sala')   // Retorna objeto Scene
```

## Componentes Principais

### GameScreen (lib/screens/game_screen.dart)

**Responsabilidades:**
- Gerenciar estado da cena atual
- Interpretar cliques em hotspots
- Navegar entre cenas
- Gerenciar diálogos

**Métodos-chave:**
```dart
void _initializeGame()
  // Carrega GameMap e define cena inicial

void _navigateToScene(String sceneId)
  // Busca Scene no GameMap e atualiza currentScene

void _handleHotspotInteraction(String hotspotId)
  // Verifica tipo do hotspot e executa ação apropriada

void _showDialogueForHotspot(String hotspotId)
  // Abre diálogo baseado em contexto do hotspot
```

### ContentRepository (lib/data/content_repository.dart)

**Responsabilidades:**
- Construir GameMap com todas as cenas
- Fornecer árvores de diálogo por NPC/contexto
- Manter dados narrativos

**Métodos-chave:**
```dart
GameMap getGameMap()
  // Retorna mapa completo com 8+ cenas interconectadas

Map<String, Scene> _buildAllScenes()
  // Constrói cada cena com hotspots e exits

DialogueTree getDialogueForNpc(String npcId, String context)
  // Retorna árvore de diálogo: 'lyra'/'ruinas_first', etc
```

### GameMap (lib/models/game_map.dart)

**Responsabilidades:**
- Índicar todas as cenas por ID
- Resolver conexões entre cenas
- Consultar estrutura do mundo

**Métodos-chave:**
```dart
Scene? getScene(String sceneId)
  // Busca Scene por ID global

String? getDestination(String fromSceneId, String exitId)
  // Resolve: (scene_quarto, exit_sala) → scene_sala

List<String> getExitsFrom(String sceneId)
  // Retorna todas as saídas disponíveis de uma cena
```

## Integração com Hotspots

### Exemplo: Sair do Quarto

```dart
// Em content_repository.dart
Scene(
  id: 'scene_quarto',
  exits: {
    'exit_sala': 'scene_sala'  // Uma saída chamada 'exit_sala'
  },
  hotspots: [
    Hotspot(
      id: 'hotspot_porta_saída',
      type: HotspotType.navigate,
      actionValue: 'exit_sala',  // Refere a 'exit_sala' acima
      position: Offset(0.95, 0.5),
      label: 'Sair',
    ),
  ],
)

// User clica no hotspot
// GameScreen._handleHotspotInteraction('hotspot_porta_saída') é chamado

// Se tipo == navigate e actionValue != null:
final destinationId = currentScene.exits['exit_sala']
// currentScene.exits['exit_sala'] = 'scene_sala'

_navigateToScene('scene_sala')
// Busca: gameMap.getScene('scene_sala')
// Atualiza: currentScene = Scene(id: 'scene_sala', ...)
```

## Exemplo: Integração Completa

### Passo 1: User vê Quarto
```
GameScreen.currentScene = gameMap.getScene('scene_quarto')
→ Renderiza SceneViewer com hotspot_porta_saída
```

### Passo 2: User clica na porta
```
SceneViewer.GestureDetector.onTap(hotspot_porta_saída)
→ GameScreen._handleHotspotInteraction('hotspot_porta_saída')
```

### Passo 3: GameScreen resolve ação
```
hotspot = Scene.hotspots.find('hotspot_porta_saída')
hotspot.type = HotspotType.navigate
hotspot.actionValue = 'exit_sala'

destinationId = currentScene.exits['exit_sala']
// = 'scene_sala'

_navigateToScene('scene_sala')
```

### Passo 4: Atualiza UI
```
setState(() {
  currentScene = gameMap.getScene('scene_sala')
})
→ SceneViewer rebuld com nova cena
```

## Vantagens da Nova Arquitetura

1. **Flexibilidade:** Múltiplos caminhos sem mudança de código
2. **Reutilização:** Hotspots reutilizáveis com actionValue
3. **Escalabilidade:** Adicionar cenas é apenas adicionar ao Map
4. **Manutenibilidade:** Conexões claras no formato Map<String, String>
5. **Testabilidade:** GameMap é independente da UI
6. **Liberdade do Jogador:** Livre exploração em vez de linear progression

## Melhorias Futuras

1. **Mapa Visual:** Renderizar grafo como mapa clicável
2. **Fast Travel:** Viagem instantânea para cenas descobertas
3. **Obstáculos:** Alguns exits marcados como "bloqueados" até requisitos
4. **Transições:** Animações entre cenas
5. **Exploração:** Sistema de "descoberta" de novas áreas
