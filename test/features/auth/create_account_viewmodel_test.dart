import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/features/auth/create_account_page.dart';
import 'package:note_app/features/auth/create_account_viewmodel.dart';
import 'package:note_app/features/auth/login_page.dart';
import 'package:note_app/shared/db/app_database.dart';
import 'package:note_app/shared/db/dao/user_dao.dart';
import 'package:provider/provider.dart';
import '../../matchers/matchers.dart';

void main() {
  late Widget pump;
  late CreateAccountViewModel viewModel;
  late UserDao userDao;
  final _formKey = GlobalKey<FormState>();

  setUp(() {
    pump = pumpProvider(Builder(builder: (context) {
      viewModel = CreateAccountViewModel(context);
      userDao = Provider.of<AppDatabase>(context, listen: false).userDao;

      return Form(
        key: _formKey,
        child: const CreateAccountPage(),
      );
    }));
  });
  testWidgets('Deve validar se o usuário está sendo criado', (tester) async {
    await tester.pumpWidget(pump);

    viewModel.nameController.text = 'Teste';
    viewModel.emailController.text = 'teste@gmail.com';
    viewModel.passwordController.text = 'Teste123';

    viewModel.createAccount(_formKey);

    final User? user =
        await userDao.signIn(email: 'teste@gmail.com', password: 'Teste123');

    expect(user!.username, 'Teste');
  });

  testWidgets('Deve verificar se direciona para a tela Login', (tester) async {
    await tester.pumpWidget(pump);

    viewModel.navigatorPop();
    await tester.pumpAndSettle();

    final login = find.byType(LoginPage);

    expect(login, findsOneWidget);
  });
}
