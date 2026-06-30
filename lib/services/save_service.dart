import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/game_state.dart';

class SaveService {
  static const String _gameDataKey = 'reverb_game_save';
  final Map<String, String> _memoryStorage = {};

  Future<void> saveGame(GameState state) async {
    try {
      final jsonString = jsonEncode(state.toJson());
      _memoryStorage[_gameDataKey] = jsonString;
      if (kDebugMode) {
        print('Game saved successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving game: $e');
      }
    }
  }

  Future<GameState?> loadGame() async {
    try {
      final jsonString = _memoryStorage[_gameDataKey];
      if (jsonString != null) {
        final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
        return GameState.fromJson(jsonMap);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading game: $e');
      }
      return null;
    }
  }

  Future<void> deleteSave() async {
    _memoryStorage.remove(_gameDataKey);
  }

  bool hasSave() {
    return _memoryStorage.containsKey(_gameDataKey);
  }
}
