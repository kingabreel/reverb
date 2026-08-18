# Data Model: Spec-Driven Reverb Project

**Date**: 2026-08-16  
**Feature**: 001-spec-driven  
**Status**: Design Complete

## Entities

### Spec (Feature Specification)

A spec is the primary unit of work in the spec-driven workflow.

| Field | Type | Description |
|-------|------|-------------|
| id | String | Unique identifier (e.g., "001-asset-pipeline") |
| name | String | Human-readable name |
| description | String | What the spec accomplishes |
| priority | Enum | CRITICAL, HIGH, MEDIUM, LOW |
| status | Enum | DRAFT, IN_PROGRESS, COMPLETE, BLOCKED |
| dependencies | List<String> | IDs of specs that must complete first |
| files | List<String> | Source files involved |
| validationCriteria | List<String> | How to verify the spec is complete |

**State Transitions**:
- DRAFT → IN_PROGRESS (when implementation begins)
- IN_PROGRESS → COMPLETE (when validation criteria met)
- Any → BLOCKED (when dependency is blocking)

### SpecUnit (Functional Unit)

A spec unit is an independently implementable and testable functionality identified from the existing codebase.

| Field | Type | Description |
|-------|------|-------------|
| specId | String | Parent spec reference |
| name | String | Functionality name |
| existingImplementation | String | What currently exists |
| gaps | List<String> | What is incomplete |
| issues | List<String> | What is incorrect |
| riskLevel | Enum | HIGH, MEDIUM, LOW |
| suggestedPriority | Enum | CRITICAL, HIGH, MEDIUM, LOW |

### ContentScene

A scene in the game world, defined in data.

| Field | Type | Description |
|-------|------|-------------|
| id | String | Unique scene identifier (e.g., "scene_quarto") |
| name | String | Display name |
| areaName | String | Geographic area (e.g., "Casa") |
| backgroundImage | String | Asset path |
| hotspots | List<Hotspot> | Interactive points |
| exits | Map<String, String> | Exit name → destination scene ID |

### Hotspot

An interactive point within a scene.

| Field | Type | Description |
|-------|------|-------------|
| id | String | Unique identifier |
| label | String | Display text |
| description | String | Text shown on examine |
| position | Offset | Normalized coordinates (0.0-1.0) |
| radius | double | Clickable area size |
| type | HotspotType | examine, navigate, dialogue, item |
| actionValue | String? | Exit ID or dialogue context |
| linkedSceneId | String? | Target scene for navigation |

### HotspotType

Enumeration of hotspot interaction types.

| Value | Description |
|-------|-------------|
| examine | Show description text |
| navigate | Transition to another scene |
| dialogue | Open dialogue tree |
| item | Collect item to inventory |

### DialogueTree

A branching conversation tree.

| Field | Type | Description |
|-------|------|-------------|
| id | String | Unique tree identifier |
| npcName | String | Speaking character |
| rootNodeId | String | Entry point node ID |
| nodes | Map<String, DialogueNode> | All nodes by ID |

### DialogueNode

A single node in a dialogue tree.

| Field | Type | Description |
|-------|------|-------------|
| id | String | Unique node identifier |
| character | String | Speaker name |
| text | String | Dialogue text |
| options | List<DialogueOption> | Player choices |
| itemReceived | String? | Item granted on enter |
| clueDiscovered | String? | Clue granted on enter |
| isEnd | bool | Whether this terminates the dialogue |

### DialogueOption

A selectable choice within a dialogue node.

| Field | Type | Description |
|-------|------|-------------|
| id | String | Unique option identifier |
| text | String | Display text |
| nextDialogueId | String | Target node ID |
| choiceKey | String? | Choice tracking key |
| statChanges | Map<String, double>? | Variable modifications |

### GameState

The global state of a play session.

| Field | Type | Description |
|-------|------|-------------|
| currentPhase | GamePhase | Current act (1-4) |
| currentChapter | GameChapter | Current chapter (1-12) |
| kaeAge | int | Protagonist age |
| lyraAge | int | Lyra age |
| sincronia | GameVariable | Synchronization metric |
| ruptura | GameVariable | Paradox rupture metric |
| lyraConfianca | GameVariable | Lyra trust metric |
| judeLoyalty | GameVariable | Jude loyalty metric |
| inventario | List<String> | Collected items |
| discoveredClues | List<String> | Found clues |
| choicesMade | Map<String, bool> | Tracked decisions |
| lastSaveTime | DateTime? | Last save timestamp |
| lastSaveChapter | String? | Last saved chapter |

### GameVariable

A numeric game variable with bounds.

| Field | Type | Description |
|-------|------|-------------|
| name | String | Variable identifier |
| value | double | Current value |

**Validation Rules**:
- Value should be clamped to 0-100 range (not currently enforced)
- Increase/decrease methods should enforce bounds (not currently implemented)

### Asset

A game resource file.

| Field | Type | Description |
|-------|------|-------------|
| path | String | Asset path relative to assets/ |
| exists | bool | Whether file exists in bundle |
| usedBy | List<String> | Scene IDs that reference this asset |

**Current State**: 20 assets referenced, 1 exists, 19 missing.

## Relationships

```
Spec (1) ──→ (N) SpecUnit
SpecUnit ──→ ContentScene (via files)
ContentScene ──→ (N) Hotspot
ContentScene ──→ (N) ContentScene (via exits)
DialogueTree ──→ (N) DialogueNode
DialogueNode ──→ (N) DialogueOption
GameState ──→ (N) GameVariable
GameState ──→ (N) ContentScene (via currentScene)
Asset ──→ (N) ContentScene (via backgroundImage)
```

## Validation Rules

1. **Scene IDs**: Must be unique across the game map
2. **Exit Destinations**: Must reference existing scene IDs
3. **Dialogue Node References**: `nextDialogueId` must reference existing node in same tree
4. **Hotspot Positions**: Normalized coordinates must be within [0.0, 1.0]
5. **Asset Paths**: Must be declared in `pubspec.yaml` assets section
6. **Stat Change Keys**: Must match `GameState` variable names (currently string-based, fragile)
7. **Choice Keys**: Must be unique across the game for tracking purposes
