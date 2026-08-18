import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_state.dart';

class SaveService {
  static const String _gameDataKey = 'reverb_game_save';

  Future<void> saveGame(GameState state) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(state.toJson());
      await prefs.setString(_gameDataKey, jsonString);
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
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_gameDataKey);
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
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_gameDataKey);
  }

  Future<bool> hasSave() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_gameDataKey);
  }
}
