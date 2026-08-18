# Tasks: Transform Reverb into Spec-Driven Project

**Input**: Design documents from `/specs/001-spec-driven/`

**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/, quickstart.md

**Tests**: Tests are OPTIONAL - only include them if explicitly requested in the feature specification.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Mobile**: `lib/` at repository root
- **Tests**: `test/` at repository root

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure for spec-driven workflow

- [x] T001 Add `shared_preferences` dependency to `pubspec.yaml`
- [ ] T002 [P] Create placeholder asset `assets/placeholder.png`
- [ ] T003 [P] Create `PlaceholderImage` widget in `lib/widgets/placeholder_image.dart`
- [ ] T004 [P] Create `lib/data/assets_map.dart` with asset path constants

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T005 [P] Implement asset validation utility in `lib/services/asset_service.dart`
- [x] T006 [P] Add dialogue fallback system in `lib/data/content_repository.dart` for unimplemented dialogue contexts
- [x] T007 [P] Add bounds clamping to `GameVariable` in `lib/models/game_state.dart`

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Asset Pipeline & Scene Rendering (Priority: P1) 🎯 MVP

**Goal**: All 20 scenes render without crashes using real assets or placeholders.

**Independent Test**: Launch the app, navigate through all 20 scenes, verify no "Unable to load asset" errors, and confirm each scene displays its background.

- [x] T008 [P] [US1] Update `SceneViewer` to use `PlaceholderImage` fallback in `lib/widgets/scene_viewer.dart`
- [x] T009 [P] [US1] Update `content_repository.dart` to reference assets via `assets_map.dart` constants
- [ ] T010 [US1] Verify all 20 scenes load without runtime asset errors

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Persistent Save System (Priority: P1)

**Goal**: Game progress persists across app restarts using disk storage.

**Independent Test**: Start a new game, modify state, save, close app, relaunch, tap "Continuar", and verify full state restoration.

- [x] T011 [P] [US2] Implement disk persistence in `lib/services/save_service.dart` using `shared_preferences`
- [x] T012 [P] [US2] Update `GameScreen` to restore current scene from save state in `lib/screens/game_screen.dart`
- [x] T013 [US2] Test full save/load cycle: new game → modify state → save → close → relaunch → continue → verify state

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Complete Dialogue Engine (Priority: P2)

**Goal**: All dialogue hotspots have functional dialogue trees or visible fallbacks.

**Independent Test**: Navigate to each scene with dialogue hotspots, tap the NPC, and verify dialogue opens with options that progress the story.

- [x] T014 [P] [US3] Create dialogue tree for `hotspot_lyra_janela_30` in `lib/data/dialogues/lyra_dialogues.dart`
- [x] T015 [P] [US3] Create dialogue tree for `hotspot_contato_madrugada` in `lib/data/dialogues/lyra_dialogues.dart`
- [x] T016 [P] [US3] Create dialogue tree for `hotspot_balcao_arquivista` in `lib/data/dialogues/lyra_dialogues.dart`
- [x] T017 [P] [US3] Create dialogue tree for `hotspot_npc_clara` in `lib/data/dialogues/lyra_dialogues.dart`
- [x] T018 [US3] Wire new dialogue trees into `content_repository.dart` and verify all dialogue hotspots open correctly

**Checkpoint**: All dialogue hotspots should have functional content

---

## Phase 6: User Story 4 - Game Screen HUD Integration (Priority: P2)

**Goal**: Inventory, statistics, and navigation panels are visible and update in real-time on the GameScreen.

**Independent Test**: Start a game, trigger inventory/stat changes via dialogue, and verify panels are visible and update without navigation.

- [x] T019 [P] [US4] Integrate `InventoryWidget` into `GameScreen` in `lib/screens/game_screen.dart`
- [x] T020 [P] [US4] Integrate `StatisticsWidget` into `GameScreen` in `lib/screens/game_screen.dart`
- [x] T021 [P] [US4] Add navigation toggle button to `GameHeader` in `lib/screens/game_screen.dart`
- [x] T022 [US4] Connect `NavigationPanel` to `GameScreen` and verify exits list updates per scene

**Checkpoint**: GameScreen HUD is fully integrated and reactive

---

## Phase 7: User Story 5 - Content Data Refactoring (Priority: P3)

**Goal**: Game content is organized into maintainable, modular files by type.

**Independent Test**: Verify scene data, dialogue data, and asset mappings are in separate files, each editable independently, and the game loads correctly.

- [x] T023 [P] [US5] Extract Casa area scenes to `lib/data/scenes/casa_scenes.dart`
- [x] T024 [P] [US5] Extract Rua area scenes to `lib/data/scenes/rua_scenes.dart`
- [x] T025 [P] [US5] Extract Aethelgard area scenes to `lib/data/scenes/aethelgard_scenes.dart`
- [x] T026 [P] [US5] Extract remaining area scenes to `lib/data/scenes/` by area
- [x] T027 [P] [US5] Move all dialogue trees to `lib/data/dialogues/lyra_dialogues.dart` and `lib/data/dialogues/jude_dialogues.dart`
- [x] T028 [US5] Update `content_repository.dart` facade to compose content from new modules

**Checkpoint**: Content is modular and maintainable

---

## Phase 8: User Story 6 - Hotspot Interaction Polish (Priority: P3)

**Goal**: All hotspot types provide appropriate visual and textual feedback.

**Independent Test**: Tap each hotspot type (examine, navigate, dialogue, item) and verify expected feedback for each.

- [x] T029 [P] [US6] Implement examine hotspot feedback (SnackBar/info panel) in `lib/screens/game_screen.dart`
- [x] T030 [P] [US6] Implement item collection via `HotspotType.item` in `lib/screens/game_screen.dart`
- [x] T031 [P] [US6] Add press/active animation to hotspots in `lib/widgets/scene_viewer.dart`
- [ ] T032 [US6] Verify all 4 hotspot types provide distinct, appropriate feedback

**Checkpoint**: Hotspot interactions are polished and consistent

---

## Phase 9: User Story 7 - Automated Testing Suite (Priority: P4)

**Goal**: Automated tests exist for models, services, and critical user journeys.

**Independent Test**: Run `flutter test` and verify all tests pass. Add a new test and verify it fails before implementation and passes after.

- [x] T033 [P] [US7] Create unit tests for `GameState` model in `test/models/game_state_test.dart`
- [x] T034 [P] [US7] Create unit tests for `GameVariable` model in `test/models/game_variable_test.dart`
- [x] T035 [P] [US7] Create unit tests for `GameMap` model in `test/models/game_map_test.dart`
- [x] T036 [P] [US7] Create widget tests for `SceneViewer` in `test/widgets/scene_viewer_test.dart`
- [x] T037 [P] [US7] Create widget tests for `DialogueViewer` in `test/widgets/dialogue_viewer_test.dart`
- [x] T038 [P] [US7] Create unit tests for `SaveService` in `test/services/save_service_test.dart`
- [x] T039 [US7] Create integration test for new game flow in `test/integration/new_game_test.dart`

**Checkpoint**: Test suite covers core models, services, and widgets

---

## Phase 10: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T040 [P] Update `docs/BASELINE.md` to reflect current implementation state
- [x] T041 [P] Run `flutter analyze` and fix any new warnings
- [x] T042 [P] Run `flutter test` and verify all tests pass
- [x] T043 Run validation scenarios from `quickstart.md` and verify all pass

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-9)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3 → P4)
- **Polish (Phase 10)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 3 (P2)**: Depends on US1 (scenes must render to see dialogues)
- **User Story 4 (P2)**: Depends on US1 and US2 (HUD needs working scenes and persistent state)
- **User Story 5 (P3)**: Depends on US1, US2, US3 (refactor after core functionality works)
- **User Story 6 (P3)**: Depends on US1 (polish after rendering works)
- **User Story 7 (P4)**: Depends on all previous stories (tests after implementation)

### Within Each User Story

- Models and utilities marked [P] can run in parallel
- Integration tasks depend on their corresponding setup tasks within the story
- Story complete before moving to next priority

---

## Parallel Opportunities

### Phase 1 (Setup)
```bash
# Launch in parallel:
T002: Create placeholder asset
T003: Create PlaceholderImage widget
T004: Create assets_map.dart
```

### Phase 2 (Foundational)
```bash
# Launch in parallel:
T005: Asset validation utility
T006: Dialogue fallback system
T007: GameVariable bounds clamping
```

### Phase 3 (US1)
```bash
# Launch in parallel:
T008: Update SceneViewer with PlaceholderImage
T009: Update content_repository to use assets_map
```

### Phase 4 (US2)
```bash
# Launch in parallel:
T011: Implement disk persistence in SaveService
T012: Update GameScreen scene restoration
```

### Phase 5 (US3)
```bash
# Launch in parallel:
T014: Lyra tower dialogue tree
T015: Contato madrugada dialogue tree
T016: Balcao arquivista dialogue tree
T017: NPC Clara dialogue tree
```

### Phase 6 (US4)
```bash
# Launch in parallel:
T019: Integrate InventoryWidget
T020: Integrate StatisticsWidget
T021: Add navigation toggle button
```

### Phase 7 (US5)
```bash
# Launch in parallel:
T023-T027: Extract scenes and dialogues to separate files
```

### Phase 8 (US6)
```bash
# Launch in parallel:
T029: Examine feedback
T030: Item collection
T031: Press animation
```

### Phase 9 (US7)
```bash
# Launch in parallel:
T033-T038: All unit and widget tests
```

---

## Implementation Strategy

### MVP First (User Stories 1-2 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: User Story 1 (Asset Pipeline)
4. Complete Phase 4: User Story 2 (Persistence)
5. **STOP and VALIDATE**: Test US1 and US2 independently
6. Demo: App runs without crashes and saves progress

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add US1 → Test independently → Deploy/Demo (MVP!)
3. Add US2 → Test independently → Deploy/Demo
4. Add US3 → Test independently → Deploy/Demo
5. Add US4 → Test independently → Deploy/Demo
6. Add US5 → Test independently → Deploy/Demo
7. Add US6 → Test independently → Deploy/Demo
8. Add US7 → Test independently → Deploy/Demo
9. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: US1 (Asset Pipeline)
   - Developer B: US2 (Persistence)
3. After US1/US2 complete:
   - Developer A: US3 (Dialogues)
   - Developer B: US4 (HUD Integration)
4. After core stories complete:
   - Developer A: US5 (Content Refactoring)
   - Developer B: US6 (Hotspot Polish)
5. After implementation complete:
   - Developer A: US7 (Testing)

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break independence
