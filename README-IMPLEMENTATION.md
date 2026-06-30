# REVERB - A Temporal Narrative Game

## Visão Geral

**Reverb** é um jogo narrativo de ficção científica em primeira pessoa desenvolvido em Flutter. A história acompanha dois protagonistas cujas realidades temporais são invertidas após uma catástrofe quântica em 2026.

Kael avança linealmente no tempo (2026-2046, envelhecendo de 15 a 35 anos).
Lyra vive em entropia reversa (2046-2026, rejuvenescendo de 35 a 15 anos).

Eles se encontram apenas em janelas de alinhamento temporal a cada 5 anos, vivendo um romance impossível através de um paradoxo quântico.

## Estrutura do Jogo

### Act 1: O Efeito Causal (Implementado)

**Capítulo 1: O Fim é o Começo** (2026)
- Kael sobrevive à explosão de Aethelgard
- Conhece Lyra aos 35 anos, recebe um relógio quebrado
- Introdução ao paradoxo temporal

**Capítulo 2: Pegadas Inversas** (2028-2030)
- Kael investe 3 anos investigando Lyra
- Descobre que ela é uma criança de 7 anos
- Pistas sobre a conspiração do pai

**Capítulo 3: O Eclipse de 2031** (2031)
- Primeiro alinhamento temporal planejado
- Encontro com Lyra aos 30 anos
- Revelações sobre o paradoxo

## Como Compilar e Rodar

### Pré-requisitos
- Flutter 3.12+ instalado
- Dart SDK
- iOS/Android SDK (conforme necessário)

### Instalação

```bash
cd /home/kingabreel/projects/reverb
flutter pub get
flutter run
```

### Em diferentes plataformas

```bash
flutter run -d chrome          # Web
flutter run -d windows         # Windows
flutter run -d macos           # macOS
flutter run -d ios             # iOS (requer Xcode)
flutter run -d android         # Android (requer Android Studio)
```

## Estrutura de Pastas

```
lib/
├── main.dart                  # Ponto de entrada
├── models/                    # Estruturas de dados
│   ├── game_state.dart       # Estado global do jogo
│   ├── scene.dart            # Cenas, capítulos, atos
│   └── dialogue.dart         # Diálogos e árvores
├── services/                  # Lógica de negócio
│   ├── game_service.dart     # Orquestrador central
│   └── save_service.dart     # Persistência
├── data/                      # Conteúdo do jogo
│   └── content_repository.dart
├── screens/                   # Telas principais
│   ├── main_menu_screen.dart
│   └── game_screen.dart
└── widgets/                   # Componentes reutilizáveis
    ├── scene_viewer.dart
    ├── dialogue_viewer.dart
    ├── inventory_widget.dart
    └── statistics_widget.dart

docs/
├── Reverb-Game.md            # Design document completo
└── agents/                    # Planejamento de implementação
    ├── 00-overview.agent.md
    ├── 01-systems.agent.md
    ├── 02-scenes.agent.md
    ├── 03-dialogues.agent.md
    ├── 04-ui.agent.md
    └── 05-implementation.agent.md

assets/
└── bedroom.png               # Imagem única (reutilizada em todos os cenários)
```

## Sistema de Jogo

### Variáveis de Estado
- **Sincronia**: Afinidade temporal entre Kael e Lyra (0-100)
- **Ruptura**: Taxa de distorção temporal causada por paradoxos (0-100)
- **Confiança**: Nível de confiança de Lyra em Kael (0-100)
- **Lealdade**: Lealdade de Jude a Kael (0-100)

### Mecânicas
- **Hotspots Interativos**: Clique em objetos nas cenas para examinar
- **Diálogos Ramificados**: Escolhas afetam variáveis e desbloqueiam pistas
- **Inventário**: Cole itens narrativos importantes
- **Save Automático**: Ao fim de cada capítulo

## Menu Principal

- **Novo Jogo**: Inicia uma nova partida
- **Continuar**: Carrega o último save
- **Sair**: Fecha o aplicativo

## Interface de Jogo

### Header
- Capítulo e título da cena
- Botões: Salvar, Menu

### Cena Principal
- Imagem de fundo
- Hotspots interativos (círculos azuis)
- Botão "Próximo" para avançar

### Painel de Diálogo
- Fala do NPC
- Opções de resposta
- Efeitos nas variáveis

### Painel Lateral (Futuro)
- Inventário
- Dimensões Temporais
- Pistas descobertas

## Desenvolvendo Novos Conteúdos

### Adicionar Nova Cena

1. Editar `lib/data/content_repository.dart`
2. Criar objetos `Scene` com hotspots
3. Adicionar a cena a um `Chapter`

### Adicionar Novo Diálogo

1. Criar `DialogueTree` em `content_repository.dart`
2. Definir `DialogueNode` com opções
3. Referenciar em `_handleHotspotInteraction`

### Adicionar Novo Capítulo

1. Criar `Chapter` com `List<Scene>`
2. Adicionar a `Act`
3. Configurar `nextChapterId` para navegação

## Notas Técnicas

- **Padrão Singleton**: `GameService` gerencia estado global
- **Serialização**: `GameState` implementa `toJson()` e `fromJson()`
- **Save em Memória**: MVP usa `Map<String, String>`. Substituir por SharedPreferences para persistência real
- **Coordenadas Relativas**: Hotspots usam posições 0.0-1.0 para escalabilidade

## Próximas Fases

### Fase 2: Acts 2-4
- Implementar capítulos 4-12
- Expandir diálogos para todos os NPCs
- Adicionar mais cenas e hotspots

### Fase 3: Sistema de Finais
- Calcular final baseado em Sincronia/Ruptura
- Implementar 5 rotas narrativas
- Cinemáticas de conclusão

### Fase 4: Polish
- Animações de transição
- Efeitos sonoros
- Tela de opções (volume, brilho, etc)
- Persistência em arquivo

## Créditos

**Narrativa**: Reverb-Game.md design document
**Desenvolvimento**: Flutter/Dart
**Engine**: Flutter 3.12+

## Licença

Privado - Projeto pessoal
