import 'package:flutter_test/flutter_test.dart';
import 'package:reverb/models/game_state.dart';

void main() {
  group('GameState', () {
    test('initializes with default values', () {
      final state = GameState();
      expect(state.sincronia.value, 0.0);
      expect(state.ruptura.value, 0.0);
      expect(state.lyraConfianca.value, 0.0);
      expect(state.judeLoyalty.value, 0.0);
      expect(state.inventario, isEmpty);
      expect(state.discoveredClues, isEmpty);
      expect(state.choicesMade, isEmpty);
      expect(state.kaeAge, 15);
      expect(state.lyraAge, 35);
    });

    test('addInventoryItem adds unique items', () {
      final state = GameState();
      state.addInventoryItem('relógio');
      expect(state.inventario, contains('relógio'));
      state.addInventoryItem('relógio');
      expect(state.inventario.length, 1);
    });

    test('removeInventoryItem removes items', () {
      final state = GameState();
      state.addInventoryItem('relógio');
      state.removeInventoryItem('relógio');
      expect(state.inventario, isEmpty);
    });

    test('addClue adds unique clues', () {
      final state = GameState();
      state.addClue('pista_1');
      expect(state.discoveredClues, contains('pista_1'));
      state.addClue('pista_1');
      expect(state.discoveredClues.length, 1);
    });

    test('recordChoice stores boolean values', () {
      final state = GameState();
      state.recordChoice('choice_1', true);
      expect(state.wasChoiceMade('choice_1'), true);
      state.recordChoice('choice_2', false);
      expect(state.wasChoiceMade('choice_2'), false);
    });

    test('saveProgress updates timestamp and chapter', () {
      final state = GameState();
      state.saveProgress('chapter1');
      expect(state.lastSaveChapter, 'chapter1');
      expect(state.lastSaveTime, isNotNull);
    });

    test('toJson and fromJson round-trip correctly', () {
      final state = GameState();
      state.sincronia.increase(10.0);
      state.addInventoryItem('relógio');
      state.addClue('pista_1');
      state.recordChoice('choice_1', true);
      state.saveProgress('chapter1');

      final json = state.toJson();
      final restored = GameState.fromJson(json);

      expect(restored.sincronia.value, 10.0);
      expect(restored.inventario, contains('relógio'));
      expect(restored.discoveredClues, contains('pista_1'));
      expect(restored.wasChoiceMade('choice_1'), true);
      expect(restored.lastSaveChapter, 'chapter1');
    });
  });

  group('GameVariable', () {
    test('increase adds value', () {
      final variable = GameVariable(name: 'test', value: 10.0);
      variable.increase(5.0);
      expect(variable.value, 15.0);
    });

    test('decrease subtracts value', () {
      final variable = GameVariable(name: 'test', value: 10.0);
      variable.decrease(5.0);
      expect(variable.value, 5.0);
    });

    test('increase clamps to 100 maximum', () {
      final variable = GameVariable(name: 'test', value: 90.0);
      variable.increase(20.0);
      expect(variable.value, 100.0);
    });

    test('decrease clamps to 0 minimum', () {
      final variable = GameVariable(name: 'test', value: 10.0);
      variable.decrease(20.0);
      expect(variable.value, 0.0);
    });
  });
}
