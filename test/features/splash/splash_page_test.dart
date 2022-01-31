import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/features/splash/splash_page.dart';
import '../../matchers/matchers.dart';

void main() {
  late Widget pump;

  setUp(() {
    pump = pumpProvider(
      Builder(builder: (context) {
        return const SplashPage();
      }),
    );
  });

  testWidgets('Deve encontrar a Splash Page ao inicializar a aplicação',
      (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(pump);

      final splash = find.byType(SplashPage);
      expect(splash, findsOneWidget);
      final circular = find.byType(CircularProgressIndicator);
      expect(circular, findsOneWidget);
    });
  });
}
