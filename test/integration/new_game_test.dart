import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reverb/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('New Game Flow Integration', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('app launches and shows main menu', (tester) async {
      await tester.pumpWidget(const ReverbApp());
      await tester.pumpAndSettle();

      expect(find.text('REVERB'), findsOneWidget);
      expect(find.text('Time Flows Backward'), findsOneWidget);
      expect(find.text('NOVO JOGO'), findsOneWidget);
      expect(find.text('SAIR'), findsOneWidget);
    });

    testWidgets('main menu shows continuar when save exists', (tester) async {
      await tester.pumpWidget(const ReverbApp());
      await tester.pumpAndSettle();

      expect(find.text('CONTINUAR'), findsNothing);
    });
  });
}
