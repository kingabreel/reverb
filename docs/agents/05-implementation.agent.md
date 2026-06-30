# Implementação: Act 1 - Estrutura Completa

## Status: PRONTO PARA COMPILAÇÃO

## Arquitetura Implementada

### 1. Modelos de Dados (lib/models/)
- `game_state.dart`: Estado global + variáveis de jogo
- `scene.dart`: Estrutura de cenas, capítulos, atos e hotspots
- `dialogue.dart`: Árvores de diálogo, nós e opções

### 2. Camada de Negócio (lib/services/)
- `game_service.dart`: Orquestrador central do jogo
- `save_service.dart`: Persistência (MVP em memória)

### 3. Dados (lib/data/)
- `content_repository.dart`: Act 1 completo com 3 capítulos, 10 cenas, 2 árvores de diálogo

### 4. Apresentação

#### Screens (lib/screens/)
- `main_menu_screen.dart`: Menu inicial, continuar, novo jogo
- `game_screen.dart`: Tela de jogo com header, cenas e diálogos

#### Widgets (lib/widgets/)
- `scene_viewer.dart`: Renderização de cenas com hotspots interativos
- `dialogue_viewer.dart`: Sistema de diálogos com ramificação
- `inventory_widget.dart`: Painel de itens
- `statistics_widget.dart`: Painel de dimensões temporais

## Act 1 Completo

### Capítulo 1: O Fim é o Começo
- Cena 1: Quarto de Kael (hotspots: relógio, janela, mochila)
- Cena 2: Rua para a escola (hotspots: som distante, beco)
- Cena 3: Ruínas de Aethelgard (hotspots: metal, luz pulsante)
- Cena 4: Encontro com Lyra (hotspots: Lyra, relógio quebrado)

Diálogo: 7 nós com escolhas que afetam sincronia e confiança

### Capítulo 2: Pegadas Inversas
- Cena 1: Escola - sala de aula (hotspots: professor, Jude)
- Cena 2: Biblioteca (hotspots: computador, jornais)
- Cena 3: Quarto - noite (hotspots: mural, relógio investigação)

### Capítulo 3: O Eclipse de 2031
- Cena 1: Observatório externo (hotspots: céu noturno, entrada)
- Cena 2: Interior (hotspots: telescópio, notas antigas)
- Cena 3: Ponto de Sincronia (hotspots: Lyra 30 anos, relatório)

Diálogo: 7 nós com revelações sobre paradoxo

## Fluxo de Jogo

1. Menu inicial
2. Novo jogo / Continuar
3. Explorar cenas
4. Clicar em hotspots
5. Interagir com NPCs (diálogos)
6. Escolhas afetam: Sincronia, Ruptura, Confiança, Lealdade
7. Itens coletados persistem no inventário
8. Save automático ao fim de capítulo

## Próximas Implementações (Opcional)

### Fase 2: Atos 2-4
- Mapa 4: Arquivos proibidos
- Mapa 5: Observatório (já implementado em Act 1)
- Mapa 6: Linha Quebrada
- Mapa 7: Último Acesso
- Mapa 8: Núcleo

### Fase 3: Sistema de Finais
- Calcular final baseado em Sincronia/Ruptura
- Implementar 5 rotas de final
- Cinemáticas de conclusão

### Fase 4: Polish
- Animações de transição
- Efeitos sonoros
- Persistência em arquivo (local_storage)
- Tela de opções

## Como Compilar

```bash
flutter pub get
flutter run
```

## Estrutura de Pastas

```
lib/
├── main.dart
├── models/
│   ├── game_state.dart
│   ├── scene.dart
│   └── dialogue.dart
├── services/
│   ├── game_service.dart
│   └── save_service.dart
├── data/
│   └── content_repository.dart
├── screens/
│   ├── main_menu_screen.dart
│   └── game_screen.dart
└── widgets/
    ├── scene_viewer.dart
    ├── dialogue_viewer.dart
    ├── inventory_widget.dart
    └── statistics_widget.dart
```

## Integração com Assets

- Uma imagem única: `assets/bedroom.png` (reutilizada em todos os cenários)
- Pubspec configurado com asset path

## Notas de Implementação

- Sem comentários no código, como solicitado
- Código modular e separado em packages
- GameService como singleton para estado global
- Save em memória (implementar SharedPreferences para persistência real)
- Posições de hotspots em coordenadas relativas (0.0 a 1.0)
