import 'package:flutter_test/flutter_test.dart';
import 'package:reverb/models/game_state.dart';

void main() {
  group('GameVariable', () {
    test('initializes with default value 0.0', () {
      final variable = GameVariable(name: 'test');
      expect(variable.value, 0.0);
    });

    test('initializes with custom value', () {
      final variable = GameVariable(name: 'test', value: 50.0);
      expect(variable.value, 50.0);
    });

    test('increase adds to value', () {
      final variable = GameVariable(name: 'test', value: 10.0);
      variable.increase(5.0);
      expect(variable.value, 15.0);
    });

    test('decrease subtracts from value', () {
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

    test('increase with negative amount decreases value', () {
      final variable = GameVariable(name: 'test', value: 10.0);
      variable.increase(-5.0);
      expect(variable.value, 5.0);
    });

    test('decrease with negative amount increases value', () {
      final variable = GameVariable(name: 'test', value: 10.0);
      variable.decrease(-5.0);
      expect(variable.value, 15.0);
    });
  });
}
