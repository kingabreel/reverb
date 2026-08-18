# Research: Transform Reverb into Spec-Driven Project

**Date**: 2026-08-16  
**Feature**: 001-spec-driven  
**Status**: Complete

## Research Tasks

### Task 1: Establish Project Constitution

**Question**: What principles should govern the Reverb project?

**Decision**: Adopt a lightweight constitution aligned with Flutter game development best practices.

**Rationale**: The existing `.specify/memory/constitution.md` is a template with no content. A lightweight constitution is appropriate for a game project that needs flexibility for narrative content while maintaining code quality.

**Alternatives Considered**:
- Full enterprise constitution (overkill for game project)
- No constitution (leads to inconsistent decisions)

**Chosen Principles**:
1. **Modular Architecture**: Separate models, services, data, screens, and widgets
2. **Data-Driven Content**: Game narrative and scenes defined in data, not code
3. **Testable Units**: Each spec independently implementable and verifiable
4. **Offline-First**: No network dependencies; all content bundled
5. **Spec-First Development**: All features begin with a written specification

---

### Task 2: Persistence Strategy

**Question**: What storage mechanism should replace in-memory persistence?

**Decision**: Use `shared_preferences` for save data in Phase 1, with `hive` or `isar` as future options for complex state.

**Rationale**: 
- `shared_preferences` is officially maintained by Flutter team
- Simple key-value storage sufficient for game save state (JSON serialization already implemented)
- No additional dependencies beyond Flutter SDK ecosystem
- Easy migration path to more robust solutions later

**Alternatives Considered**:
- SQLite (too heavy for simple save data)
- File I/O (more complex, error-prone)
- Keep in-memory only (unacceptable for game with save/load)

---

### Task 3: Asset Pipeline Strategy

**Question**: How to handle 19 missing assets referenced in code?

**Decision**: Create a `lib/widgets/placeholder_image.dart` widget that renders a colored placeholder with asset name when image fails to load. Replace missing asset references with a single `assets/placeholder.png`.

**Rationale**:
- Allows development to continue without all assets
- Visual feedback in UI shows where assets are missing
- Single placeholder asset reduces bundle size
- Can be replaced with real assets during content phase

**Alternatives Considered**:
- Generate assets procedurally (too complex for MVP)
- Remove scenes with missing assets (loses content)
- Crash on missing assets (current broken state)

---

### Task 4: Content Data Organization

**Question**: How to organize the 1007-line `content_repository.dart`?

**Decision**: Split into multiple files by content type while maintaining the singleton pattern.

**Rationale**:
- Single file is difficult to maintain and review
- Narrative content (dialogues) and scene data have different lifecycles
- Easier for writers/content creators to work on dialogues separately from scene geometry

**Proposed Structure**:
```
lib/data/
├── content_repository.dart      # Facade/orchestrator
├── scenes/
│   ├── casa_scenes.dart
│   ├── rua_scenes.dart
│   ├── aethelgard_scenes.dart
│   └── ...
├── dialogues/
│   ├── lyra_dialogues.dart
│   ├── jude_dialogues.dart
│   └── ...
└── assets_map.dart              # Asset path constants
```

**Alternatives Considered**:
- Keep single file (current state, works but scales poorly)
- JSON/YAML data files (requires asset loading, more complex)
- Database (overkill for static content)

---

### Task 5: Testing Strategy

**Question**: What testing approach fits a Flutter game project?

**Decision**: Widget tests for UI components, unit tests for models/services, integration tests for critical user journeys.

**Rationale**:
- Flutter has strong widget testing support
- Game logic (state transitions, dialogue trees) is testable without UI
- Critical paths (new game, save/load, navigation) should have integration tests

**Alternatives Considered**:
- No tests (current state, risky for refactoring)
- 100% coverage (unrealistic for game content)

---

### Task 6: Dialogue System Extension

**Question**: How to handle missing dialogues for existing hotspots?

**Decision**: Implement a dialogue fallback system that shows "Not yet implemented" placeholder dialogue when a hotspot's dialogue context is not found in ContentRepository.

**Rationale**:
- Prevents crashes when navigating to scenes with unimplemented dialogues
- Makes missing content visible during development
- Can be replaced with real content without code changes

**Alternatives Considered**:
- Crash on missing dialogue (current behavior for some hotspots)
- Hide dialogue hotspots entirely (loses content tracking)

---

## Decisions Summary

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Constitution | Lightweight, 5 principles | Appropriate for game project |
| Persistence | shared_preferences | Official, simple, sufficient |
| Assets | Placeholder widget | Enables continued development |
| Content | Split by type | Maintainability |
| Testing | Widget + Unit + Integration | Balanced coverage |
| Dialogues | Fallback system | Development visibility |
