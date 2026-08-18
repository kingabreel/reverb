# REVERB - Baseline do Projeto

**Data:** 2026-08-15  
**Versão:** 0.1.0+1  
**Status:** MVP funcional com divergência entre código e documentação

---

## 1. Visão Geral

Projeto de jogo narrativo point-and-click desenvolvido em Flutter. A aplicação compila sem erros críticos, porém apresenta **divergência estrutural entre a documentação existente e o código implementado**.

### Stack Tecnológica
- **Framework:** Flutter 3.44.2
- **Linguagem:** Dart 3.12.2
- **Design System:** Material 3
- **Dependências externas:** Nenhuma (apenas SDK Flutter)
- **Persistência:** Em memória (sem disco)

---

## 2. Arquitetura Atual

### Padrão Arquitetural
- **Estado global:** Singleton `GameService`
- **Repositório de conteúdo:** Singleton `ContentRepository`
- **Navegação:** Grafo de cenas via `GameMap` → `Scene.exits` (Map<String, String>)
- **Separacao:** models / services / data / screens / widgets

### Fluxo de Dados
```
GameService (estado)
  ├── SaveService (persistência em memória)
  ├── GameState (variáveis, inventário, escolhas)
  └── ContentRepository (cenas e diálogos)
        └── GameMap (grafo de cenas)
```

---

## 3. Estrutura Real de Arquivos

```
lib/
├── main.dart
├── models/
│   ├── game_state.dart
│   ├── game_map.dart
│   ├── scene.dart
│   └── dialogue.dart
├── services/
│   ├── game_service.dart
│   └── save_service.dart
├── data/
│   └── content_repository.dart
│   └── content_repository.dart.bak
├── screens/
│   ├── main_menu_screen.dart
│   └── game_screen.dart
└── widgets/
    ├── scene_viewer.dart
    ├── dialogue_viewer.dart
    ├── inventory_widget.dart
    ├── statistics_widget.dart
    └── navigation_panel.dart
```

**Total:** 12 arquivos Dart + 1 backup

---

## 4. Assets

### Assets Referenciados no Código
| Asset | Status |
|-------|--------|
| assets/abandoned_school.png | **AUSENTE** |
| assets/bathroom.png | **AUSENTE** |
| assets/bedroom.png | ✅ Presente |
| assets/deep_ruines.png | **AUSENTE** |
| assets/kael_apartment.png | **AUSENTE** |
| assets/kitchen.png | **AUSENTE** |
| assets/living_room.png | **AUSENTE** |
| assets/municipal_archive.png | **AUSENTE** |
| assets/old_observatory.png | **AUSENTE** |
| assets/perimeter.png | **AUSENTE** |
| assets/ruines.png | **AUSENTE** |
| assets/school_basement.png | **AUSENTE** |
| assets/school_office.png | **AUSENTE** |
| assets/scrapyard_district.png | **AUSENTE** |
| assets/static_forest.png | **AUSENTE** |
| assets/street_day.png | **AUSENTE** |
| assets/tower_apex.png | **AUSENTE** |
| assets/tower_base.png | **AUSENTE** |
| assets/window_living_room.png | **AUSENTE** |
| assets/window.png | **AUSENTE** |

**Total referenciado:** 20  
**Total existente:** 1  
**Total ausente:** 19

**Impacto:** O aplicativo quebra em runtime ao carregar qualquer cena exceto `scene_quarto` (que usa `bedroom.png`). Erro: `Unable to load asset`.

---

## 5. Conteúdo Implementado (Baseline Real)

### Cenas (20 registradas, 20 únicas)

| ID | Nome | Area | Background | Hotspots |
|----|------|------|------------|----------|
| scene_quarto | Quarto | Casa | bedroom.png | 4 |
| scene_janela | Janela do Quarto | Casa | window.png | 1 |
| scene_sala | Sala | Casa | living_room.png | 6 |
| scene_janela_sala | Janela da Sala | Casa | window_living_room.png | 1 |
| scene_cozinha | Cozinha | Casa | kitchen.png | 4 |
| scene_banheiro | Banheiro | Casa | bathroom.png | 3 |
| scene_rua_principal | Rua Principal | Rua | street_day.png | 3 |
| scene_beco | Beco | Rua | ruines.png | 2 |
| scene_ruinas | Ruínas de Aethelgard | Aethelgard | deep_ruines.png | 4 |
| scene_perimetro_exclusao | Perímetro de Exclusão | Aethelgard | perimeter.png | 4 |
| scene_distrito_sucateiros | Distrito dos Sucateiros | Subúrbio | scrapyard_district.png | 4 |
| scene_arquivo_morto | Arquivo Morto Municipal | Centro | municipal_archive.png | 4 |
| scene_floresta_estatica | Floresta Estática | Periferia | static_forest.png | 4 |
| scene_apartamento_kael | Apartamento de Monitoramento | Zona de Contenção B | kael_apartment.png | 4 |
| scene_escola_abandonada | Escola Primária St. Jude (Fachada) | Distrito Antigo | abandoned_school.png | 3 |
| scene_escola_diretoria | Diretoria da Escola | Escola St. Jude | school_office.png | 3 |
| scene_escola_subsolo | Subsolo da Escola | Escola St. Jude | school_basement.png | 2 |
| scene_torre_base | Base da Torre de Oakhaven | Montanha Alta | tower_base.png | 3 |
| scene_observatorio_antigo | Observatório Astronômico Abandonado | Montanha Alta | old_observatory.png | 3 |
| scene_torre_topo | Plataforma Superior da Torre | Topo do Mundo | tower_apex.png | 2 |

### Áreas do Mundo
- Casa
- Rua
- Aethelgard
- Subúrbio
- Centro
- Periferia
- Zona de Contenção B
- Distrito Antigo
- Escola St. Jude
- Montanha Alta
- Topo do Mundo

### Navegação (Grafo)
- Cena inicial: `scene_quarto`
- Conexões implementadas via `Scene.exits` (Map<String, String>)
- Exemplo: `scene_sala` → `scene_quarto`, `scene_cozinha`, `scene_banheiro`, `scene_rua_principal`, `scene_janela_sala`

### Diálogos
- **Total de árvores:** 2
- **Total de nós:** 14
- **Contextos disponíveis:**
  - `lyra / ruinas_first` → 7 nós, 3 ramos
  - `jude / school` → 2 nós, 1 ramo

### Itens e Pistas
- Inventário: lista de strings (`List<String>`)
- Pistas descobertas: lista de strings (`List<String>`)
- Nenhum item ou pista programada nos diálogos atuais

---

## 6. Modelos

### game_state.dart
- Enums: `GamePhase` (4), `GameChapter` (12)
- Classes: `GameVariable`, `GameState`
- Variáveis: `sincronia`, `ruptura`, `lyraConfianca`, `judeLoyalty`
- Coleções: `inventario`, `discoveredClues`, `choicesMade`
- Serialização JSON: `toJson()` / `fromJson()`

### scene.dart
- Enums: `HotspotType` (examine, navigate, dialogue, item)
- Classes: `Offset`, `Hotspot`, `Scene`, `Chapter`, `Act`
- **Modelo não utilizado:** `SceneExit` (definido mas não referenciado em nenhum outro arquivo)
- Navegação: `Scene.exits` como `Map<String, String>`

### game_map.dart
- Classe: `GameMap`
- Métodos: `getScene()`, `getStartScene()`, `getExitsFrom()`, `getDestination()`, `getScenesByArea()`, `getAllAreas()`

### dialogue.dart
- Classes: `DialogueOption`, `DialogueNode`, `DialogueTree`
- Suporte a: `statChanges`, `choiceKey`, `itemReceived`, `clueDiscovered`, `isEnd`

---

## 7. Serviços

### game_service.dart
- Tipo: Singleton
- Responsabilidades: orquestração, acesso a estado, métodos de atualização de variáveis
- Métodos expostos: `initializeGame()`, `startNewGame()`, `saveGame()`, `updateSincronia()`, `updateRuptura()`, `updateLyraConfianca()`, `updateJudeLoyalty()`, `recordChoice()`, `addInventoryItem()`, `removeInventoryItem()`, `addClue()`, `getStat()`

### save_service.dart
- **Persistência:** Apenas `Map<String, String>` em memória
- Chave: `reverb_game_save`
- Métodos: `saveGame()`, `loadGame()`, `deleteSave()`, `hasSave()`
- **Problema:** Dados são perdidos ao fechar o aplicativo

---

## 8. Screens

### main_menu_screen.dart
- Widgets: `MainMenuScreen`, `MenuButton`
- Funcionalidade: verificação de save, novo jogo, continuar, sair
- Estado local: `hasSave`

### game_screen.dart
- Widgets: `GameScreen`, `GameHeader`
- Funcionalidades:
  - Inicialização do `GameMap`
  - Navegação entre cenas via `_navigateToScene()`
  - Save manual via ícone
  - Tratamento de hotspots: `navigate` e `dialogue`
  - **Problema:** `HotspotType.examine` não possui feedback (apenas seleção visual)
  - Diálogos exibidos via `showModalBottomSheet`
- Estado local: `currentScene`, `showNavigationPanel`

---

## 9. Widgets

### scene_viewer.dart
- Renderização de cena com `Image.asset`
- Hotspots posicionados por coordenadas relativas (0.0-1.0)
- Seleção visual com highlight
- Info box no rodapé para hotspot selecionado

### dialogue_viewer.dart
- Sistema de diálogos em cascata
- Aplicação de `statChanges` e `choiceKey`
- Coleta de itens e descoberta de pistas (nos nós finais)
- Fechamento automático ao alcançar nó `isEnd`

### inventory_widget.dart
- Painel de itens colecionáveis
- Estado vazio quando `inventario` está vazio
- **Não integrado** à `GameScreen`

### statistics_widget.dart
- Painel de barras para as 4 variáveis de jogo
- Normalização automática (0-100)
- **Não integrado** à `GameScreen`

### navigation_panel.dart
- Lista de saídas disponíveis da cena atual
- Navegação direta via botões
- **Não integrado** à `GameScreen` (prop `showNavigationPanel` sempre false)

---

## 10. Divergências com Documentação

| Tópico | Documentação | Código Real |
|--------|-------------|-------------|
| Cenas | 10 (Act 1) | 20 |
| Estrutura narrativa | Capítulos lineares (2026-2031) | Mundo aberto com grafo de cenas |
| Áreas | Casa, Rua, Aethelgard | 11 áreas |
| Assets | 1 imagem reutilizada | 20 referências, 1 existente |
| Narrativa | "O Fim é o Começo" | Distrito dos Sucateiros, Torre de Oakhaven, etc. |
| Diálogos | 14 nós em múltiplas árvores | 2 árvores (14 nós) |
| GameMap | Mencionado em docs | Implementado com grafo livre |
| NavigationPanel | Não documentado | Implementado mas não conectado |
| content_repository.dart.bak | Não documentado | Presente no repositório |
| SceneExit model | Não documentado | Definido mas não utilizado |

---

## 11. Problemas Conhecidos

### Críticos
1. **Assets ausentes:** 19 de 20 imagens referenciadas não existem
2. **Documentação des sincronizada:** Nenhum documento reflete a narrativa e estrutura atuais
3. **Sem persistência real:** Save perdido ao fechar o app

### Médios
4. **Hotspots de examine sem ação:** `_handleHotspotInteraction` ignora `HotspotType.examine`
5. **Widgets não integrados:** `InventoryWidget`, `StatisticsWidget`, `NavigationPanel` existem mas não são usados em `GameScreen`
6. **Backup file:** `content_repository.dart.bak` sugere refatoring incompleto

### Baixos
7. **Modelo morto:** `SceneExit` definido mas não utilizado
8. **Sem validação de fluxo:** Não há bloqueio de cenas por variáveis ou inventário
9. **Sem sistema de finais:** Apesar do design document mencionar 5 finais, não há cálculo
10. **Warnings:** 24 warnings informativos (deprecações `withValues`)

---

## 12. Métricas Reais

| Métrica | Valor |
|---------|-------|
| Arquivos Dart | 12 |
| Linhas de código (aprox.) | ~2.200 |
| Classes | 20+ |
| Enums | 4 |
| Cenas | 20 |
| Áreas | 11 |
| Hotspots | 70+ |
| Diálogos (nós) | 14 |
| Variáveis de jogo | 4 |
| Assets existentes | 1 |
| Assets ausentes | 19 |

---

## 13. Estado de Compilação

- **Erros críticos:** 0
- **Warnings:** 24 (deprecações e sugestões)
- **Compilação:** `flutter pub get` OK
- **Execução:** Inicia em `scene_quarto`, quebra ao navegar para outras cenas

---

## 14. Baseline para Desenvolvimento

Esta documentação representa o **estado fiel do código** em 2026-08-15. Qualquer trabalho futuro deve considerar:

1. **Assets:** Substituir referências por placeholders ou criar assets reais antes de expandir conteúdo
2. **Documentação:** Atualizar `docs/` para refletir a estrutura de grafo e a narrativa atual
3. **Persistência:** Implementar `shared_preferences` ou similar antes de considerar o save funcional
4. **Integração de widgets:** Conectar `InventoryWidget`, `StatisticsWidget` e `NavigationPanel` à `GameScreen`
5. **Limpeza:** Remover `content_repository.dart.bak` e `SceneExit` se não forem necessários
6. **Narrativa:** Documentar a história atual implementada, pois difere completamente de `Reverb-Game.md`
