# Quickstart: Spec-Driven Reverb Project

**Date**: 2026-08-16  
**Feature**: 001-spec-driven  
**Purpose**: Validation and run guide for the spec-driven transformation

## Prerequisites

- Flutter SDK 3.44.2+
- Dart SDK 3.12.2+
- Git (for version control)
- A code editor (VS Code recommended)

## Setup Commands

```bash
# Clone repository (if not already done)
git clone <repository-url> reverb
cd reverb

# Install dependencies
flutter pub get

# Verify no critical analysis errors
flutter analyze
```

## Running the Application

```bash
# Run on connected device/emulator
flutter run

# Run on web
flutter run -d web

# Run on desktop
flutter run -d windows  # or macos, linux
```

**Expected Outcome**: App launches in landscape orientation, showing main menu with "NOVO JOGO", "CONTINUAR" (if save exists), and "SAIR" buttons.

## Validation Scenarios

### Scenario 1: Main Menu Navigation

**Prerequisites**: App built and running

**Steps**:
1. Launch app
2. Verify "REVERB" title displays in cyan
3. Verify "Time Flows Backward" subtitle displays
4. Tap "NOVO JOGO"
5. Verify GameScreen loads with scene name "Quarto" in header
6. Tap save icon (floppy disk) in header
7. Verify "Jogo salvo com sucesso" SnackBar appears
8. Tap menu icon (hamburger) in header
9. Verify return to main menu
10. Verify "CONTINUAR" button now appears
11. Tap "CONTINUAR"
12. Verify returns to GameScreen

**Pass Criteria**: All navigation flows work without crashes.

### Scenario 2: Scene Navigation via Hotspots

**Prerequisites**: GameScreen active

**Steps**:
1. On "Quarto" scene, tap "Sair" hotspot (right side)
2. Verify scene changes to "Sala"
3. Verify header updates to "SALA"
4. Tap "Cozinha" hotspot (if visible)
5. Verify scene changes to "Cozinha"
6. Navigate back to "Sala" then "Quarto"

**Pass Criteria**: Scene transitions work, header updates correctly.

### Scenario 3: Dialogue System

**Prerequisites**: GameScreen active, in a scene with dialogue hotspot

**Steps**:
1. Navigate to "Ruínas de Aethelgard" (via Rua → Beco → Ruínas)
2. Tap "Lyra" hotspot
3. Verify bottom sheet opens with dialogue
4. Select dialogue options
5. Verify stat changes apply (if visible)
6. Complete dialogue to end
7. Verify bottom sheet closes

**Pass Criteria**: Dialogue tree traverses correctly, options lead to next nodes.

### Scenario 4: Save/Load Persistence

**Prerequisites**: App running

**Steps**:
1. Start new game
2. Navigate through 2-3 scenes
3. Tap save icon
4. Close app completely
5. Relaunch app
6. Tap "CONTINUAR"
7. Verify returns to last saved scene (currently returns to scene_quarto due to incomplete save restoration)

**Current Known Issue**: Save restoration does not restore scene position, only state variables. This is tracked in SPEC_DRIVEN.md.

**Pass Criteria**: State variables (inventory, stats) persist; scene position restoration is a known gap.

### Scenario 5: Asset Loading

**Prerequisites**: App running

**Steps**:
1. Navigate to "Quarto" scene (uses bedroom.png - exists)
2. Verify image loads correctly
3. Navigate to "Sala" scene (uses living_room.png - missing)
4. Verify app does NOT crash (placeholder should render)

**Current Known Issue**: 19 of 20 assets are missing. Scene rendering may show errors or blank screens.

**Pass Criteria**: App remains stable; missing assets do not cause crashes.

## Spec Completion Checklist

For each spec defined in `docs/SPEC_DRIVEN.md`, verify:

- [ ] **Spec 14 - Asset Pipeline**: All referenced assets exist or have placeholders
- [ ] **Spec 3 - Persistence**: Save data persists across app restarts
- [ ] **Spec 7 - Hotspot Interaction**: All hotspot types (examine, navigate, dialogue, item) have implemented actions
- [ ] **Spec 8 - Dialogue Engine**: All dialogue hotspots have corresponding dialogue trees
- [ ] **Spec 12 - Game Screen**: Inventory, statistics, and navigation panels are integrated
- [ ] **Spec 15 - Content Data**: Content is organized and maintainable

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "Unable to load asset" error | Asset file missing; see Spec 14 |
| Save not persisting | In-memory only; see Spec 3 |
| Dialogue not opening | Hotspot type not mapped; see Spec 7 |
| Blank screen on scene | Missing asset or incorrect path; see Spec 14 |

## Next Steps

After validating baseline:
1. Review `docs/SPEC_DRIVEN.md` for prioritized spec list
2. Begin with Spec 14 (Asset Pipeline) as highest priority
3. Follow with Spec 3 (Persistence) and Spec 8 (Dialogue Engine)
4. Each spec should be implemented, tested, and validated independently
