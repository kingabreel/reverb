# REVERB - Spec-Driven Breakdown

**Data:** 2026-08-15  
**Objetivo:** Organizar o projeto existente em unidades de funcionalidade independentes, cada uma com critérios de validação claros.

---

## Metodologia

Cada spec segue o formato:
- **Nome:** Funcionalidade
- **Descrição:** O que faz
- **Status:** ✅ Completo / ⚠️ Parcial / ❌ Ausente
- **Arquivos Envolvidos:** Componentes de código
- **O que já existe:** Implementação atual
- **O que está incompleto:** Gaps identificados
- **O que está incorreto:** Bugs, divergências, modelos mortos
- **Dependências:** Outras funcionalidades necessárias
- **Banco/API:** Camadas de dados envolvidas
- **Riscos de alterar:** Impacto de mudanças
- **Prioridade sugerida:** Alta / Média / Baixa
- **Critérios de validação:** Como verificar se está funcionando

---

## Spec 1: Application Bootstrap

**Descrição:** Inicialização da aplicação Flutter, configuração de tema e orientação de tela.

**Status:** ✅ Completo

### O que já existe
- `main.dart` com `main()` assíncrono
- `SystemChrome.setPreferredOrientations` (landscape only)
- `ReverbApp` widget raiz com Material 3 e tema escuro
- `ColorScheme.fromSeed` com cor semente `#00D9FF`

### O que está incorreto
- Sem configuração de `debugShowCheckedModeBanner` (mostra banner vermelho em debug)

### Dependências
- Nenhuma (entrypoint)

### Banco/API
- Nenhum

### Riscos de alterar
- Baixo. Mudanças em `main.dart` afetam toda a aplicação, mas é um arquivo pequeno.

### Prioridade
- Baixa

### Critérios de validação
- `flutter run` inicia sem crash
- Orientação landscape funciona em device/emulador
- Tema escuro aplicado consistentemente

---

## Spec 2: Global State Management

**Descrição:** Estado global do jogo, orquestração central via singleton.

**Status:** ✅ Completo (estruturalmente)

### O que já existe
- `GameService` como singleton (`factory` + `_instance`)
- Métodos para modificar as 4 variáveis de jogo
- Métodos para inventário, pistas e escolhas
- Inicialização a partir de save ou novo jogo

### O que está incorreto
- `GameService()` expõe `currentState` como campo público (`late GameState currentState`), permitindo mutação externa direta
- Sem validação de limites nas variáveis (ex: `sincronia` pode ir abaixo de 0 ou acima de 100 sem restrição)

### Dependências
- Spec 3 (Persistence)
- Spec 4 (GameState Model)

### Banco/API
- Nenhum (orquestra SaveService e GameState)

### Riscos de alterar
- Médio. Qualquer mudança na assinatura do `GameService` quebra todas as screens e widgets que o injetam.

### Prioridade
- Alta (é o backbone do estado)

### Critérios de validação
- `GameService()` retorna a mesma instância em chamadas repetidas
- `startNewGame()` reseta todas as variáveis para 0
- `saveGame()` persiste estado atual

---

## Spec 3: Persistence Layer

**Descrição:** Salvamento e carregamento do estado do jogo.

**Status:** ⚠️ Parcial

### O que já existe
- `SaveService` com `saveGame()`, `loadGame()`, `deleteSave()`, `hasSave()`
- Serialização JSON de `GameState`
- Armazenamento em `Map<String, String>` em memória
- Tratamento de erros com `try/catch`

### O que está incompleto
- **Persistência em disco inexistente:** dados são perdidos ao fechar o app
- Sem múltiplos slots de save
- Sem metadados de save (thumbnail, data, capítulo)
- `deleteSave()` não é chamado em lugar nenhum

### O que está incorreto
- `SaveService` usa `Map<String, String>` mas armazena JSON, então o tipo deveria ser `Map<String, String>` apenas para a chave, mas o valor é uma string longa — tecnicamente funciona, mas é semanticamente confuso
- `initializeGame()` em `GameService` carrega save automaticamente, mas `startNewGame()` sobrescreve sem confirmar com usuário

### Dependências
- Spec 4 (GameState Model) — para serialização

### Banco/API
- Nenhum (precisa de `shared_preferences` ou similar para disco)

### Riscos de alterar
- Baixo. `SaveService` é uma camada fina. Mudar para `shared_preferences` não afixa interface pública.

### Prioridade
- Alta (sem persistência real, o save é inútil)

### Critérios de validação
- Salvar, fechar app, reabrir → estado restaurado
- `hasSave()` retorna `true` após salvar
- `deleteSave()` limpa o estado e `hasSave()` retorna `false`

---

## Spec 4: Game State Model

**Descrição:** Estruturas de dados que representam o estado do jogo.

**Status:** ✅ Completo

### O que já existe
- `GameState` com 4 variáveis (`sincronia`, `ruptura`, `lyraConfianca`, `judeLoyalty`)
- `GameVariable` com métodos `increase/decrease`
- `inventario`, `discoveredClues`, `choicesMade`
- `kaeAge`, `lyraAge`
- Enums `GamePhase` (4 atos) e `GameChapter` (12 capítulos)
- Serialização JSON completa (`toJson`/`fromJson`)

### O que está incorreto
- `GameVariable` permite valores negativos e acima de 100 sem validação
- `choicesMade` usa `Map<String, bool>` mas poderia ser mais flexível (ex: `Map<String, dynamic>`) para armazenar payloads complexos
- `GameState` não tem métodos de negócio (ex: `isSynchronized()`, `isRuptured()`), apenas getters/setters simples — isso força `GameService` a ter lógica que poderia estar no modelo

### Dependências
- Nenhuma (modelo puro)

### Banco/API
- Nenhum

### Riscos de alterar
- Baixo. Modelos são DTOs. Mudanças quebras serialização existente (JSON), então `fromJson` precisa ser backward-compatible.

### Prioridade
- Média (funciona, mas pode ser refinado)

### Critérios de validação
- `GameState()` inicializa com valores padrão
- `toJson()`/`fromJson()` round-trip sem perda
- `addInventoryItem()` não duplica itens
- `recordChoice()` armazena corretamente

---

## Spec 5: Scene Graph & Navigation

**Descrição:** Mapa de cenas interconectadas, sistema de saídas e transições.

**Status:** ✅ Completo (estruturalmente)

### O que já existe
- `GameMap` com `getScene()`, `getExitsFrom()`, `getDestination()`
- `Scene` com `exits` (Map<String, String>)
- `SceneExit` model definido (mas não usado)
- `navigation_panel.dart` lista saídas disponíveis

### O que está incorreto
- `SceneExit` model existe em `scene.dart` mas não é usado em lugar nenhum — o sistema usa `Map<String, String>` diretamente em `Scene.exits`, o que é menos type-safe
- `linkedSceneId` em `Hotspot` não é utilizado na lógica de navegação (`_handleHotspotInteraction` usa apenas `actionValue` + `exits`)
- `Hotspot.actionType` existe mas não é consultado em `game_screen.dart`
- Navegação não valida se destino existe antes de transicionar (embora `getScene()` retorne null e evite crash)

### Dependências
- Spec 6 (Scene Rendering)
- Spec 7 (Hotspot System)

### Banco/API
- Nenhum

### Riscos de alterar
- Médio. Mudar `Scene.exits` para `List<SceneExit>` quebra todos os `content_repository.dart` e `navigation_panel.dart`.

### Prioridade
- Média (funciona, mas tem technical debt)

### Critérios de validação
- Navegar de `scene_quarto` para `scene_sala` funciona
- `navigation_panel.dart` lista saídas corretamente
- Tentar navegar para cena inexistente não crasha

---

## Spec 6: Scene Rendering

**Descrição:** Renderização visual de cenas com fundo e hotspots interativos.

**Status:** ⚠️ Parcial

### O que já existe
- `scene_viewer.dart` com `Image.asset`, `LayoutBuilder`, `Stack`
- Posicionamento relativo de hotspots (0.0-1.0)
- Seleção visual de hotspot com highlight
- Info box com label e descrição

### O que está incompleto
- **19 assets ausentes** no código (referenciados mas não existem em `assets/`)
- Sem loading state enquanto imagem carrega
- Sem tratamento de erro para asset faltoso
- Hotspots de `examine` não exibem descrição ao serem clicados (apenas selecionam)

### O que está incorreto
- `Image.asset` com `fit: BoxFit.cover` pode distorcer proporções se aspect ratio da imagem != aspect ratio da tela
- Sem fallback visual quando asset não carrega (crasha em runtime)

### Dependências
- Spec 7 (Hotspot System)
- Spec 14 (Asset Pipeline)

### Banco/API
- Nenhum (Flutter asset bundle)

### Riscos de alterar
- Baixo. `scene_viewer.dart` é widget autossuficiente.

### Prioridade
- Alta (sem assets, maioria das cenas quebram)

### Critérios de validação
- Todas as 20 cenas carregam sem erro
- Hotspots aparecem nas posições corretas
- Selecionar hotspot mostra info box
- Clicar em hotspot de examine exibe descrição

---

## Spec 7: Hotspot Interaction System

**Descrição:** Sistema de interação com pontos clicáveis nas cenas.

**Status:** ⚠️ Parcial

### O que já existe
- `HotspotType` enum: `examine`, `navigate`, `dialogue`, `item`
- `Hotspot` model com `position`, `radius`, `type`, `actionValue`
- `_handleHotspotInteraction()` em `game_screen.dart`

### O que está incompleto
- `HotspotType.examine` não executa ação (apenas seleciona visualmente)
- `HotspotType.item` não existe implementação de coleta
- Sem feedback visual diferenciado por tipo (todos são círculos iguais)
- Sem animação de clique/press

### O que está incorreto
- `_handleHotspotInteraction()` usa `firstWhere` sem tratar `StateError` se `hotspotId` não existir (embora o `orElse` previna crash, retorna hotspot vazio que é ignorado)
- `hotspot_contato_madrugada` em `scene_distrito_sucateiros` é do tipo `dialogue` mas não há diálogo correspondente no `ContentRepository`

### Dependências
- Spec 6 (Scene Rendering)
- Spec 8 (Dialogue System)
- Spec 9 (Inventory System)

### Banco/API
- Nenhum

### Riscos de alterar
- Baixo. `_handleHotspotInteraction` é método privado de `GameScreen`.

### Prioridade
- Média (navegação funciona, mas examine está quebrado)

### Critérios de validação
- Clicar em hotspot `navigate` troca de cena
- Clicar em hotspot `dialogue` abre bottom sheet
- Clicar em hotspot `examine` exibe SnackBar ou info box com descrição
- Clicar em hotspot `item` adiciona item ao inventário

---

## Spec 8: Dialogue Engine

**Descrição:** Motor de diálogos ramificados com stat changes.

**Status:** ⚠️ Parcial

### O que já existe
- `DialogueTree`, `DialogueNode`, `DialogueOption`
- `statChanges` (Map<String, double>) aplicado via `DialogueViewer`
- `choiceKey` registrado em `GameState`
- `itemReceived` e `clueDiscovered` nos nós

### O que está incompleto
- Apenas 2 árvores de diálogo implementadas (Lyra ruins, Jude school)
- Falta diálogo para `hotspot_lyra_janela_30` (`scene_torre_topo`)
- Falta diálogo para `hotspot_contato_madrugada` (`scene_distrito_sucateiros`)
- Falta diálogo para `hotspot_balcao_arquivista` (`scene_arquivo_morto`)
- Falta diálogo para `hotspot_npc_clara` (`scene_escola_abandonada`)
- Sem validação de pré-condições para exibir diálogos (ex: variável mínima de confiança)
- Sem persistência de progresso de diálogo (se sair do diálogo, recomeça do início)

### O que está incorreto
- `DialogueViewer._applyStatChanges()` aplica itens/pistas apenas no nó final (`isEnd`), mas deveria aplicar no nó atual também quando o jogador faz uma escolha
- `statChanges` usa strings em português (`'confiança'`, `'ruptura'`, `'sincronia'`) mas `GameService.getStat()` espera os mesmos nomes — funciona, mas é frágil (sem enum ou constante)

### Dependências
- Spec 2 (Global State)
- Spec 4 (GameState Model)
- Spec 9 (Inventory System)

### Banco/API
- Nenhum (dados hardcoded em `content_repository.dart`)

### Riscos de alterar
- Médio. `content_repository.dart` tem 1007 linhas hardcoded. Mudar estrutura de diálogo quebra todas as árvores existentes.

### Prioridade
- Alta (é o coração narrativo do jogo)

### Critérios de validação
- Diálogo de Lyra abre e percorre todos os 7 nós
- Escolhas aplicam `statChanges` corretamente
- Itens são adicionados ao inventário nos nós corretos
- Diálogo fecha ao alcançar `isEnd`

---

## Spec 9: Inventory System

**Descrição:** Gerenciamento de itens colecionáveis do jogador.

**Status:** ⚠️ Parcial

### O que já existe
- `GameState.inventario` (List<String>)
- `GameService.addInventoryItem()` / `removeInventoryItem()`
- `inventory_widget.dart` com visual de itens

### O que está incompleto
- `InventoryWidget` **não está integrado** à `GameScreen`
- Nenhum item programado para ser coletado nos diálogos existentes
- Sem uso de itens em gameplay (ex: relógio quebrado não é adicionado ao inventário)
- Sem descrição ou detalhe de item (apenas label)
- Sem sistema de "usar item" em hotspots ou cenas

### Dependências
- Spec 2 (Global State)
- Spec 7 (Dialogue Engine)

### Banco/API
- Nenhum

### Riscos de alterar
- Baixo. `InventoryWidget` é widget autossuficiente.

### Prioridade
- Baixa (não bloqueia gameplay atual)

### Critérios de validação
- Item adicionado via diálogo aparece no widget
- Widget lista todos os itens sem duplicar
- Inventário persiste entre cenas

---

## Spec 10: Statistics System

**Descrição:** Painel de barras visuais para as 4 variáveis de jogo.

**Status:** ⚠️ Parcial

### O que já existe
- `statistics_widget.dart` com `_StatBar` usando `LinearProgressIndicator`
- Bindings direto a `gameService.currentState`
- Normalização 0-100 com `clamp`

### O que está incompleto
- `StatisticsWidget` **não está integrado** à `GameScreen`
- Sem atualização dinâmica durante diálogos (precisa de `setState` no `GameScreen` ou `ValueListenableBuilder`)
- Sem tooltip ou detalhamento do que cada variável significa
- Sem notificação visual quando variável atinge threshold

### Dependências
- Spec 2 (Global State)

### Banco/API
- Nenhum

### Riscos de alterar
- Baixo.

### Prioridade
- Baixa (cosmético, não bloqueia gameplay)

### Critérios de validação
- Barras refletem valores corretos após stat changes
- Atualização visual em tempo real
- Layout responsivo

---

## Spec 11: Main Menu

**Descrição:** Tela inicial com opções de Novo Jogo, Continuar e Sair.

**Status:** ✅ Completo

### O que já existe
- `MainMenuScreen` com verificação de save
- `MenuButton` reutilizável
- Navegação para `GameScreen`
- Background gradiente sci-fi

### O que está incompleto
- Sem animação de transição
- Sem versão ou créditos
- Sem configuração de idioma

### O que está incorreto
- `hasSave` é verificado uma única vez em `initState()`. Se o save for criado enquanto o menu está aberto (não possível atualmente, mas possível no futuro), não atualiza.

### Dependências
- Spec 3 (Persistence) — para `hasSave()`

### Banco/API
- Nenhum

### Riscos de alterar
- Baixo.

### Prioridade
- Baixa

### Critérios de validação
- "Continuar" aparece apenas quando há save
- "Novo Jogo" reseta estado e navega
- "Sair" fecha app (ou volta em mobile)

---

## Spec 12: Game Screen & HUD

**Descrição:** Tela principal de jogo com header, cena e controles.

**Status:** ⚠️ Parcial

### O que já existe
- `GameScreen` com estado de cena atual
- `GameHeader` com nome da localização, botões de save e menu
- Navegação entre cenas via hotspots
- Integração com `SceneViewer` e `DialogueViewer`

### O que está incompleto
- Sem integração com `InventoryWidget`
- Sem integração com `StatisticsWidget`
- `showNavigationPanel` sempre `false` — `NavigationPanel` nunca aparece
- Sem botão de inventário/estatísticas no header
- Sem transição visual entre cenas (cutscene/fade)
- Sem tratamento de cena inicial baseado em save (sempre começa em `scene_quarto`)

### O que está incorreto
- `_initializeGame()` ignora fase/capítulo salvo — sempre carrega `scene_quarto` como início
- `_continueGame()` carrega estado salvo mas não restaura cena/capítulo corretos (não usa `currentPhase`/`currentChapter` do `GameState`)
- Diálogos abertos via bottom sheet não atualizam header após fechar (embora `setState` no `onComplete` tente)

### Dependências
- Spec 6 (Scene Rendering)
- Spec 7 (Hotspot Interaction)
- Spec 8 (Dialogue Engine)
- Spec 9 (Inventory)
- Spec 10 (Statistics)
- Spec 3 (Persistence)

### Banco/API
- Nenhum

### Riscos de alterar
- Médio. `GameScreen` é o widget central. Mudanças afetam toda a experiência de jogo.

### Prioridade
- Alta (é a tela principal)

### Critérios de validação
- Cena carrega corretamente ao iniciar
- Navegação entre cenas funciona
- Save manual funciona
- Header mostra localização correta
- Continue retoma na cena salva (não implementado ainda)

---

## Spec 13: Dialogue UI

**Descrição:** Interface de usuário para exibição de diálogos ramificados.

**Status:** ✅ Completo (funcionalmente)

### O que já existe
- `DialogueViewer` em `showModalBottomSheet`
- `_OptionButton` para cada escolha
- Aplicação de stat changes e recordação de escolhas
- Fechamento automático em nó `isEnd`

### O que está incompleto
- Sem animação de digitação de texto
- Sem indicação de qual personagem está falando (apenas nome em texto)
- Sem highlight na escolha selecionada antes de confirmar
- Sem skip/animation speed control
- Sem som ou efeito visual ao abrir/fechar

### Dependências
- Spec 8 (Dialogue Engine)

### Banco/API
- Nenhum

### Riscos de alterar
- Baixo. Widget é reutilizável e auto-contido.

### Prioridade
- Baixa (funcional, faltam polish)

### Critérios de validação
- Diálogo abre em bottom sheet
- Opções são clicáveis
- Escolhas aplicam mudanças no estado
- Bottom sheet fecha ao final do diálogo

---

## Spec 14: Asset Pipeline

**Descrição:** Gerenciamento e carregamento de recursos visuais.

**Status:** ❌ Crítico

### O que já existe
- `pubspec.yaml` com `assets/` declarado
- 16 arquivos PNG em `assets/`
- Carregamento via `Image.asset` em `scene_viewer.dart`

### O que está incorreto
- `content_repository.dart` referencia **7 assets que não existem**:
  - `abandoned_school.png`
  - `kael_apartment.png`
  - `old_observatory.png`
  - `school_basement.png`
  - `school_office.png`
  - `tower_apex.png`
  - `tower_base.png`
- **3 assets existem mas não são referenciados:**
  - `deep_ruines_clock.png`
  - `interieur_ruines.png`
  - `street_night.png`
- Sem placeholders ou imagens geradas proceduralmente para cenas sem asset

### Dependências
- Spec 6 (Scene Rendering)

### Banco/API
- Nenhum (Flutter asset bundle)

### Riscos de alterar
- Baixo. Adicionar/remover assets não afeta lógica, apenas visual.

### Prioridade
- Crítica (app quebra em runtime ao acessar cenas com assets faltosos)

### Critérios de validação
- Toda cena carrega sua imagem sem erro
- Nenhum `Unable to load asset` no console
- Assets existentes são usados, ausentes são substituídos por placeholders

---

## Spec 15: Content Data (Cenas e Diálogos)

**Descrição:** Dados hardcoded de cenas, hotspots, diálogos e narrativa.

**Status:** ⚠️ Parcial

### O que já existe
- 20 cenas com áreas, descrições e hotspots
- 2 árvores de diálogo funcionais
- Sistema de exits conectando cenas

### O que está incompleto
- Faltam diálogos para 4 hotspots do tipo `dialogue`
- Sem dados de itens colecionáveis (nenhum item programado)
- Sem dados de pistas (`discoveredClues` nunca populado)
- Sem conteúdo de Acts 2-4
- Sem sistema de condições (ex: "só mostra este diálogo se `sincronia > 50`")

### O que está incorreto
- `content_repository.dart` tem 1007 linhas em um único arquivo — difícil manutenção
- `content_repository.dart.bak` presente (lixo)
- Dados misturados: algumas cenas seguem narrativa de "2026-2031" (Act 1 docs), outras seguem narrativa de "Distrito dos Sucateiros/Torre de Oakhaven" (código atual)
- Nomes de variáveis em português nos `statChanges` (`'confiança'`, `'sincronia'`) — inconsistente com `GameState` que usa camelCase

### Dependências
- Spec 8 (Dialogue Engine)
- Spec 14 (Asset Pipeline)

### Banco/API
- Nenhum (dados hardcoded)

### Riscos de alterar
- Alto. `content_repository.dart` é o arquivo mais crítico. Erros de digitação em IDs de cena/diálogo quebram navegação silenciosamente (null pointer ou hotspot não encontrado).

### Prioridade
- Alta (conteúdo é o produto do jogo)

### Critérios de validação
- Todas as cenas são acessíveis a partir da cena inicial
- Todos os diálogos abrem corretamente
- Todos os hotspots têm ação definida
- Nenhuma referência circular ou cena órfã

---

## Spec 16: Navigation Panel UI

**Descrição:** Painel visual que lista saídas disponíveis da cena atual.

**Status:** ❌ Não integrado

### O que já existe
- `navigation_panel.dart` implementado
- Recebe `GameMap`, `currentSceneId`, `onDestinationSelected`
- Renderiza botões para cada exit

### O que está incompleto
- **Não está conectado** à `GameScreen`
- `showNavigationPanel` em `GameScreen` sempre é `false`
- Sem botão no `GameHeader` para abrir o painel
- Sem animação de abertura/fechamento

### Dependências
- Spec 5 (Scene Graph & Navigation)
- Spec 12 (Game Screen & HUD)

### Banco/API
- Nenhum

### Riscos de alterar
- Baixo. Widget autossuficiente.

### Prioridade
- Baixa (navegação por hotspots funciona, painel é enhancement)

### Critérios de validação
- Painel aparece ao clicar em botão de navegação
- Lista saídas corretas da cena atual
- Clicar em saída navega para destino correto

---

## Espec 17: Narrative & Endings

**Descrição:** Sistema de finais baseado em variáveis e escolhas.

**Status:** ❌ Ausente

### O que já existe
- `GameState` com `sincronia`, `ruptura`, `choicesMade`
- `GamePhase` enum (4 atos)
- Documentação em `Reverb-Game.md` menciona 5 finais

### O que está incompleto
- Sem cálculo de final
- Sem tela de final
- Sem cinemática de conclusão
- Sem transição entre atos
- `GameChapter` enum existe mas não é usado para navegação ou progresso

### Dependências
- Spec 2 (Global State)
- Spec 3 (Persistence)
- Spec 15 (Content Data)

### Banco/API
- Nenhum

### Riscos de alterar
- Baixo. Funcionalidade nova, não quebra nada existente.

### Prioridade
- Baixa (Fase 3, após Acts 2-4)

### Critérios de validação
- Ao completar conteúdo, jogo avalia variáveis
- Exibe uma das 5 rotas de final
- Salva estado de final concluído

---

## Matriz de Dependências

```
Spec 1 (Bootstrap)
  └── Spec 2 (State)
        └── Spec 3 (Persistence)
        └── Spec 4 (Models)
              └── Spec 5 (Scene Graph)
                    └── Spec 6 (Rendering)
                          └── Spec 7 (Hotspots)
                                └── Spec 8 (Dialogue)
                                      ├── Spec 9 (Inventory)
                                      └── Spec 10 (Statistics)
                              └── Spec 14 (Assets)
                        └── Spec 15 (Content Data)
              └── Spec 12 (Game Screen)
                    ├── Spec 11 (Main Menu)
                    └── Spec 16 (Nav Panel)
                          └── Spec 5 (Scene Graph)
        └── Spec 17 (Endings)
```

---

## Ordem de Implementação Sugerida

### Fase 1: Estabilização (Fundação)
1. **Spec 14 — Asset Pipeline** (Crítica)
   - Por que primeiro: 7 cenas quebram sem assets. É bloqueador para qualquer teste de navegação.
   - Ação: Corrigir referências quebradas ou criar placeholders.

2. **Spec 3 — Persistence Layer** (Alta)
   - Por que: Sem save real, o jogo não tem replay value. É dependência de Spec 12.
   - Ação: Implementar `shared_preferences` para disco.

3. **Spec 7 — Hotspot Interaction** (Média)
   - Por que: Examine não funciona. É dependência de Spec 6.
   - Ação: Implementar ação de examine e feedback visual.

### Fase 2: Core Gameplay
4. **Spec 8 — Dialogue Engine** (Alta)
   - Por que: Diálogos são o coração. Faltam 4 árvores.
   - Ação: Completar diálogos faltantes e adicionar pré-condições.

5. **Spec 15 — Content Data** (Alta)
   - Por que: Dados estão fragmentados. Precisa de refatoring.
   - Ação: Reorganizar `content_repository.dart`, corrigir nomes de variáveis, remover `.bak`.

6. **Spec 5 — Scene Graph & Navigation** (Média)
   - Por que: Modelo `SceneExit` morto e `linkedSceneId` não usado.
   - Ação: Decidir se migra para `SceneExit` ou remove o modelo.

### Fase 3: UX & Polish
7. **Spec 12 — Game Screen & HUD** (Alta)
   - Por que: Tela principal sem inventário/estatísticas integrados.
   - Ação: Integrar widgets, corrigir carregamento de save, adicionar botões.

8. **Spec 9 — Inventory System** (Baixa)
   - Por que: Widget pronto mas não conectado.
   - Ação: Integrar e adicionar itens colecionáveis.

9. **Spec 10 — Statistics System** (Baixa)
   - Por que: Widget pronto mas não conectado.
   - Ação: Integrar e adicionar atualização dinâmica.

10. **Spec 16 — Navigation Panel UI** (Baixa)
    - Por que: Widget pronto mas não conectado.
    - Ação: Conectar e adicionar botão trigger.

### Fase 4: Extensão
11. **Spec 17 — Narrative & Endings** (Baixa)
    - Por que: Requer conteúdo completo de Acts 2-4.
    - Ação: Implementar cálculo de final e tela de conclusão.

12. **Spec 11 — Main Menu** (Baixa)
    - Por que: Funcional, faltam polish.
    - Ação: Animações, créditos.

13. **Spec 4 — Game State Model** (Média)
    - Por que: Funciona, mas pode ser refinado após estabilização.
    - Ação: Adicionar validação de limites e métodos de negócio.

---

## Resumo de Prioridades

| Prioridade | Spec | Motivo |
|------------|------|--------|
| 🔴 Crítica | 14 — Asset Pipeline | App quebra em runtime |
| 🔴 Alta | 3 — Persistence | Sem save real, jogo é inútil após fechar |
| 🟡 Alta | 8 — Dialogue Engine | Coração narrativo, 4 diálogos faltando |
| 🟡 Alta | 15 — Content Data | Dados hardcoded desorganizados |
| 🟡 Alta | 12 — Game Screen | Tela principal incompleta |
| 🟡 Média | 7 — Hotspot Interaction | Examine quebrado |
| 🟡 Média | 5 — Scene Graph | Modelo morto e technical debt |
| 🟢 Baixa | 9 — Inventory | Widget pronto, só integrar |
| 🟢 Baixa | 10 — Statistics | Widget pronto, só integrar |
| 🟢 Baixa | 16 — Nav Panel | Widget pronto, só integrar |
| 🟢 Baixa | 17 — Endings | Conteúdo futuro |
| 🟢 Baixa | 11 — Main Menu | Funcional, polish |
| 🟢 Baixa | 4 — Game State | Funcional, refinamento |
| 🟢 Baixa | 1 — Bootstrap | Funcional, sem mudanças necessárias |
| 🟢 Baixa | 13 — Dialogue UI | Funcional, polish |
| 🟢 Baixa | 2 — Global State | Funcional, technical debt menor |

---

## Notas Técnicas

- **Nenhum banco de dados** é usado atualmente. Tudo é em memória ou hardcoded.
- **Nenhuma API** externa é consumida.
- **Flutter asset bundle** é a única "fonte de dados" externa (imagens).
- O projeto é **100% offline**.
- **Sem testes** unitários ou de widget presentes no projeto.
