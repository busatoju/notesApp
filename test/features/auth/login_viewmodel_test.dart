import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/features/auth/create_account_page.dart';
import 'package:note_app/features/auth/login_page.dart';
import 'package:note_app/features/auth/login_viewmodel.dart';
import 'package:note_app/shared/db/app_database.dart';
import 'package:note_app/shared/db/dao/user_dao.dart';
import 'package:note_app/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../matchers/matchers.dart';

void main() {
  late final LoginViewModel viewModel;
  late UserProvider userProvider;
  late Widget pump;
  late UserDao db;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  setUp(() {
    pump = pumpProvider(Builder(builder: (context) {
      viewModel = LoginViewModel(context);

      db = Provider.of<AppDatabase>(context, listen: false).userDao;
      userProvider = Provider.of<UserProvider>(context);

      return Scaffold(
        body: Form(
          key: _formKey,
          child: const LoginPage(),
        ),
      );
    }));
  });

  testWidgets(
      'Deve verificar se o usuario existe no banco, para então direcionar para home page',
      (tester) async {
    await tester.pumpWidget(pump);

    final int userId = await db.createAccount(UsersCompanion.insert(
        username: 'Teste', password: 'Teste123', email: 'email@teste.com'));

    viewModel.emailController.text = 'email@teste.com';
    viewModel.passwordController.text = 'Teste123';

    await viewModel.signIn(_formKey);
    expect(userProvider.user?.id, userId);
  });

  testWidgets('Deve verificar se direciona para CreateAccountPage',
      (tester) async {
    await tester.pumpWidget(pump);

    viewModel.navigatorCreateAccount();
    await tester.pumpAndSettle();

    final createAccount = find.byType(CreateAccountPage);
    expect(createAccount, findsOneWidget);
  });
}
