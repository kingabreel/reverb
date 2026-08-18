import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reverb/services/save_service.dart';
import 'package:reverb/models/game_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SaveService', () {
    late SaveService saveService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      saveService = SaveService();
    });

    test('hasSave returns false initially', () async {
      final hasSave = await saveService.hasSave();
      expect(hasSave, false);
    });

    test('saveGame and loadGame round-trip', () async {
      final state = GameState();
      state.sincronia.increase(25.0);
      state.addInventoryItem('relógio');
      state.addClue('pista_1');
      state.recordChoice('choice_1', true);

      await saveService.saveGame(state);
      final loaded = await saveService.loadGame();

      expect(loaded, isNotNull);
      expect(loaded!.sincronia.value, 25.0);
      expect(loaded.inventario, contains('relógio'));
      expect(loaded.discoveredClues, contains('pista_1'));
      expect(loaded.wasChoiceMade('choice_1'), true);
    });

    test('loadGame returns null when no save exists', () async {
      final loaded = await saveService.loadGame();
      expect(loaded, isNull);
    });

    test('deleteSave removes save data', () async {
      final state = GameState();
      await saveService.saveGame(state);
      
      var hasSave = await saveService.hasSave();
      expect(hasSave, true);

      await saveService.deleteSave();
      hasSave = await saveService.hasSave();
      expect(hasSave, false);
    });
  });
}
