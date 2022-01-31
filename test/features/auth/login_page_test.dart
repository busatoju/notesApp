import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/features/auth/create_account_page.dart';
import 'package:note_app/features/auth/login_page.dart';
import '../../matchers/matchers.dart';

void main() {
  late Widget pump;

  setUp(() {
    pump = pumpProvider(const LoginPage());
  });

  testWidgets('Deve validar os items em login page e Create account',
      (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(pump);

      //Deve encontrar o campo de texto [E-mail]
      final emailTextField =
          find.byWidgetPredicate((widget) => textField(widget, 'E-mail'));
      expect(emailTextField, findsOneWidget);
      //Deve encontrar o campo de texto [Senha]
      final passwordTextField =
          find.byWidgetPredicate((widget) => textField(widget, 'Senha'));
      expect(passwordTextField, findsOneWidget);

      //Deve encontrar o botão [Acessar]
      final loginButton =
          find.byWidgetPredicate((widget) => elevatedButton(widget, 'Acessar'));
      expect(loginButton, findsOneWidget);

      //Deve encontrar o botão para cadastro [CustomTextButtonWidget]
      final createButton = find.byWidgetPredicate((widget) =>
          textButton(widget, 'Ainda não possui uma conta? Cadastre-se!'));

      expect(createButton, findsOneWidget);

      //Clica no botão
      await tester.tap(createButton);
      //Aguarda navegar para tela [CreateAccount]
      await tester.pumpAndSettle();
      //Deve encontrar a tela [CreateAccountPage]
      final createAccountPage = find.byType(CreateAccountPage);
      expect(createAccountPage, findsOneWidget);
    });
  });
}
