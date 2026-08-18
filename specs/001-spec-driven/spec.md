# Feature Specification: Transform Reverb into Spec-Driven Project

**Feature Branch**: `001-spec-driven`

**Created**: 2026-08-16

**Status**: Draft

**Input**: User description: "Transformar projeto existente em Spec-Driven"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Asset Pipeline & Scene Rendering (Priority: P1)

As a player, I want all game scenes to render without crashes so that I can explore the game world.

**Why this priority**: 19 of 20 referenced assets are missing. The app crashes when navigating to any scene except the starting scene. This is a critical blocker for all gameplay.

**Independent Test**: Launch the app, navigate through all 20 scenes, and verify no "Unable to load asset" errors occur. Every scene should display either its real background or a placeholder.

**Acceptance Scenarios**:

1. **Given** the app is running, **When** I navigate to any scene, **Then** the scene renders without crashing
2. **Given** a scene with a missing asset, **When** the scene loads, **Then** a placeholder image is displayed with the asset name visible
3. **Given** a scene with an existing asset, **When** the scene loads, **Then** the real image is displayed

---

### User Story 2 - Persistent Save System (Priority: P1)

As a player, I want my game progress to persist between sessions so that I can continue my adventure after closing the app.

**Why this priority**: Current save system is in-memory only. All progress is lost when the app closes. This is essential for any game with save/load functionality.

**Independent Test**: Start a new game, navigate through scenes, collect items, modify stats, save the game, close the app completely, relaunch, and verify all progress is restored.

**Acceptance Scenarios**:

1. **Given** I have a save file, **When** I launch the app and tap "Continuar", **Then** I return to the exact scene and state
2. **Given** I have no save file, **When** I launch the app, **Then** only "Novo Jogo" and "Sair" buttons are available
3. **Given** I have a save file, **When** I start a new game, **Then** the old save is overwritten after confirmation

---

### User Story 3 - Complete Dialogue Engine (Priority: P2)

As a player, I want all interactive characters to have dialogue so that I can progress through the story.

**Why this priority**: 4 dialogue hotspots exist but have no corresponding dialogue trees. Players encounter dead-end interactions that break immersion.

**Independent Test**: Navigate to each scene with dialogue hotspots, tap the NPC, and verify a dialogue tree opens with multiple options that progress the story and apply stat changes.

**Acceptance Scenarios**:

1. **Given** I tap a dialogue hotspot, **When** the dialogue tree exists, **Then** a bottom sheet opens with character name, text, and options
2. **Given** I select a dialogue option with stat changes, **When** the dialogue advances, **Then** the game variables are updated
3. **Given** I tap a dialogue hotspot without an implemented tree, **When** the fallback triggers, **Then** a placeholder dialogue explains the content is coming soon

---

### User Story 4 - Game Screen HUD Integration (Priority: P2)

As a player, I want to see my inventory and stats during gameplay so that I can track my progress and resources.

**Why this priority**: InventoryWidget and StatisticsWidget exist but are not integrated into the GameScreen. Players cannot see their collected items or current stat values during gameplay.

**Independent Test**: Start a game, open a dialogue that grants an item or modifies a stat, and verify the inventory and statistics panels are visible and update in real-time on the GameScreen.

**Acceptance Scenarios**:

1. **Given** I am playing the game, **When** I collect an item, **Then** the item appears in the inventory panel
2. **Given** I am playing the game, **When** a dialogue changes a stat, **Then** the statistics panel updates to reflect the new value
3. **Given** I am playing the game, **When** I tap the navigation button, **Then** the navigation panel shows available exits for the current scene

---

### User Story 5 - Content Data Refactoring (Priority: P3)

As a developer, I want game content organized into maintainable files so that I can easily update scenes, dialogues, and assets without breaking the build.

**Why this priority**: content_repository.dart is 1007 lines of hardcoded data. It is difficult to review, maintain, and extend. This is a developer experience improvement that reduces technical debt.

**Independent Test**: Verify that scene data, dialogue data, and asset mappings are in separate files, each can be edited independently, and the game still loads correctly after changes.

**Acceptance Scenarios**:

1. **Given** I want to add a new scene, **When** I edit the scenes data file, **Then** the scene appears in the game without modifying other content
2. **Given** I want to update a dialogue, **When** I edit the dialogues data file, **Then** the new dialogue text appears in the game
3. **Given** I want to change an asset path, **When** I edit the assets map file, **Then** all scenes using that asset reference the new path

---

### User Story 6 - Hotspot Interaction Polish (Priority: P3)

As a player, I want clear feedback when interacting with hotspots so that I understand what each interaction does.

**Why this priority**: Examine hotspots show visual selection but provide no textual feedback. Item collection hotspots are not implemented. This creates confusion about what is interactive.

**Independent Test**: Tap each type of hotspot (examine, navigate, dialogue, item) and verify appropriate feedback is provided for each type.

**Acceptance Scenarios**:

1. **Given** I tap an examine hotspot, **When** the interaction completes, **Then** a SnackBar or info panel displays the description text
2. **Given** I tap an item hotspot, **When** the interaction completes, **Then** the item is added to my inventory and a confirmation is shown
3. **Given** I tap any hotspot, **When** I tap it, **Then** visual feedback indicates the hotspot was pressed

---

### User Story 7 - Automated Testing Suite (Priority: P4)

As a developer, I want automated tests so that I can refactor and extend the codebase with confidence.

**Why this priority**: No tests exist. This is important for long-term maintainability but does not affect the immediate player experience.

**Independent Test**: Run the test suite and verify all tests pass. Add a new test for a model or widget and verify it fails before implementation and passes after.

**Acceptance Scenarios**:

1. **Given** I run `flutter test`, **When** the test suite executes, **Then** all existing tests pass
2. **Given** I add a new widget test, **When** I run tests, **Then** the new test is discovered and executed
3. **Given** I modify existing code, **When** I run tests, **Then** any breaking changes are detected by failing tests

---

### Edge Cases

- What happens when an asset file is corrupted or unreadable?
- How does the system handle a save file from an older version with missing fields?
- What happens when a dialogue tree has circular references?
- How does the game behave when all variables reach their minimum or maximum values?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST render all 20 scenes without crashing, using real assets or placeholders
- **FR-002**: System MUST persist game state to disk and restore it on app relaunch
- **FR-003**: System MUST provide dialogue trees for all dialogue-type hotspots
- **FR-004**: System MUST display inventory and statistics panels on the GameScreen
- **FR-005**: System MUST organize game content data into maintainable, modular files
- **FR-006**: System MUST provide textual feedback when examining hotspots
- **FR-007**: System MUST implement item collection via item-type hotspots
- **FR-008**: System MUST include automated tests for models, services, and critical user journeys

### Key Entities *(include if feature involves data)*

- **Scene**: A game location with background image, hotspots, and exits to other scenes
- **Hotspot**: An interactive point in a scene with type-specific behavior (examine, navigate, dialogue, item)
- **DialogueTree**: A branching conversation with nodes, options, and stat changes
- **GameState**: The global state including variables, inventory, clues, choices, and save metadata
- **Asset**: A background image resource referenced by scenes
- **Spec**: A feature specification unit with priorities, dependencies, and validation criteria

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Player can navigate through all 20 scenes without encountering a crash
- **SC-002**: Game progress persists across app restarts with 100% state restoration
- **SC-003**: 100% of dialogue hotspots have functional dialogue trees or visible fallbacks
- **SC-004**: Inventory and statistics are visible and update in real-time during gameplay
- **SC-005**: Content data files are organized by type (scenes, dialogues, assets) with no single file exceeding 500 lines
- **SC-006**: Hotspot interactions provide appropriate feedback for all 4 hotspot types
- **SC-007**: Test suite covers all models and services with passing tests

## Assumptions

- Assets will be replaced with final artwork during content phase; placeholders are acceptable for development
- shared_preferences is sufficient for save data in the current scope
- The existing Flutter project structure is maintained; no migration to other frameworks
- All development is offline; no network dependencies are introduced
- The spec-driven workflow is adopted for all future feature development
