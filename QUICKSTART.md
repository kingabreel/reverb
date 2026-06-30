# 🚀 Quick Start - REVERB

## Em 3 Passos

### 1️⃣ Clonar / Abrir
```bash
cd /home/kingabreel/projects/reverb
```

### 2️⃣ Instalar Dependências
```bash
flutter pub get
```

### 3️⃣ Rodar
```bash
flutter run
```

---

## 📱 Plataformas

```bash
flutter run                    # Auto-detecta (Android/iOS/Web)
flutter run -d windows         # Windows
flutter run -d web             # Browser
flutter run -d macos           # macOS
```

---

## 🎮 Gameplay

1. **Menu Principal**: Novo Jogo ou Continuar
2. **Cena**: Clique nos hotspots azuis (◯)
3. **Exame**: Leia a descrição do objeto
4. **Personagem**: Clique em Lyra para diálogo
5. **Escolha**: Selecione opção de diálogo
6. **Próximo**: Botão "Próximo" avança cena

---

## 📂 Estrutura

```
lib/
├── models/        → Dados (GameState, Scene, Dialogue)
├── services/      → Lógica (GameService, SaveService)
├── data/          → Conteúdo (ContentRepository)
├── screens/       → Telas (Menu, Game)
└── widgets/       → UI (SceneViewer, DialogueViewer)
```

---

## 🔨 Para Desenvolvedores

### Adicionar Nova Cena

Edite `lib/data/content_repository.dart`:

```dart
Scene(
  id: 'scene_name',
  name: 'Meu Cenário',
  backgroundImage: 'assets/bedroom.png',
  hotspots: [
    Hotspot(
      id: 'hotspot_1',
      label: 'Objeto',
      description: 'Descrição...',
      position: Offset(0.5, 0.5),  // x, y (0-1)
      radius: 40,
    ),
  ],
  nextSceneId: 'next_scene',
)
```

### Adicionar Novo Diálogo

```dart
DialogueTree(
  id: 'dialogue_key',
  npcName: 'Lyra',
  nodes: {
    'node_1': DialogueNode(
      id: 'node_1',
      character: 'Lyra',
      text: 'Fala aqui...',
      options: [
        DialogueOption(
          id: 'opt_1',
          text: 'Resposta do jogador',
          nextDialogueId: 'node_2',
          statChanges: {'sincronia': 5.0},
        ),
      ],
    ),
  },
  rootNodeId: 'node_1',
)
```

### Adicionar Novo Capítulo

```dart
Chapter(
  id: 'chapter_X',
  number: 'X',
  title: 'Título',
  objective: 'Objetivo aqui',
  scenes: [scene1, scene2, scene3],
  nextChapterId: 'chapter_Y',
)
```

---

## 📊 Variáveis de Jogo

```dart
gameService.currentState.sincronia      // 0-100: Afinidade temporal
gameService.currentState.ruptura         // 0-100: Distorção
gameService.currentState.lyraConfianca   // 0-100: Confiança
gameService.currentState.judeLoyalty     // 0-100: Lealdade
```

---

## 💾 Save/Load

```dart
// Salvar
await gameService.saveGame();

// Carregar
await gameService.initializeGame();

// Novo jogo
await gameService.startNewGame();
```

---

## 📚 Documentação

| Arquivo | Conteúdo |
|---------|----------|
| `docs/Reverb-Game.md` | Roteiro narrativo completo |
| `docs/FILE_STRUCTURE.md` | Mapa de arquivos |
| `docs/IMPLEMENTATION_SUMMARY.md` | Resumo técnico |
| `docs/DELIVERY_CHECKLIST.md` | Checklist final |
| `docs/VISUAL_SUMMARY.md` | Visão geral visual |
| `docs/agents/*.md` | Planejamento por agente |

---

## 🎯 Próximas Ações

### Para Continuar Desenvolvimento
1. Adicione Acts 2-4 seguindo padrão de Act 1
2. Implemente mais diálogos em ContentRepository
3. Adicione novos hotspots em cada cena
4. Teste cada capítulo

### Para Polish
1. Adicione animações em SceneViewer
2. Implemente áudio em DialogueViewer
3. Troque SaveService por SharedPreferences
4. Adicione menu de opções

---

## 🐛 Debug

```bash
# Analisar código
dart analyze lib/

# Ver warnings
dart analyze lib/ --no-fatal-infos

# Modo debug
flutter run --debug

# Verbose
flutter run -v
```

---

## ❓ FAQ

**P: Onde adiciono itens ao inventário?**
R: Em DialogueNode, use `itemReceived: 'item_name'`

**P: Como mudo uma variável?**
R: Em DialogueOption, use `statChanges: {'sincronia': 5.0}`

**P: Posso adicionar mais atores?**
R: Sim! Crie novo DialogueTree e referencie em hotspots

**P: Como faço save persistir?**
R: Substitua SaveService por `flutter_secure_storage` ou `shared_preferences`

---

## 🎮 Enjoy!

```
╔════════════════════════════════╗
║                              ║
║   REVERB - Ready to Play!   ║
║                              ║
║   Time Flows Backward        ║
║                              ║
╚════════════════════════════════╝
```

**Versão**: 0.1.0 (Act 1)
**Status**: ✅ Compilável e Jogável
**Próximo**: Acts 2-4
