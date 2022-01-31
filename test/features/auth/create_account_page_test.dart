import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/features/auth/create_account_page.dart';
import 'package:note_app/features/auth/login_page.dart';
import '../../matchers/matchers.dart';

void main() {
  late Widget pump;

  setUp(() {
    pump = pumpProvider(const CreateAccountPage());
  });
  testWidgets('Deve validar a tela [Create Account]', (tester) async {
    await tester.pumpWidget(pump);
    //Deve encontrar campo de nome na tela [CreateAccountPage]
    final nameTextField =
        find.byWidgetPredicate((widget) => textField(widget, 'Nome'));
    expect(nameTextField, findsOneWidget);
    //Deve encontrar campo de email na tela [CreateAccountPage]
    final emailTextFieldCreateAccount =
        find.byWidgetPredicate((widget) => textField(widget, 'E-mail'));

    expect(emailTextFieldCreateAccount, findsOneWidget);
    //Deve encontrar campo de senha na tela [CreateAccountPage]
    final passwordTextFieldCreateAccount =
        find.byWidgetPredicate((widget) => textField(widget, 'Senha'));
    expect(passwordTextFieldCreateAccount, findsOneWidget);

    //Deve encontrar o botão para navegar para tela de login
    final loginButton = find.byWidgetPredicate(
        (widget) => textButton(widget, 'Já possui uma conta? Acesse já!'));

    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    //Deve encontrat a tela de Login
    final loginPage = find.byType(LoginPage);

    expect(loginPage, findsOneWidget);
  });
}
