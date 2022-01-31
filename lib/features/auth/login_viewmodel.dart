import 'package:flutter/material.dart';
import 'package:note_app/features/auth/create_account_page.dart';
import 'package:note_app/features/home/home_page.dart';
import 'package:note_app/shared/db/app_database.dart';
import 'package:note_app/shared/db/dao/user_dao.dart';
import 'package:note_app/shared/providers/user_provider.dart';
import 'package:note_app/shared/services/preferences_service.dart';
import 'package:provider/provider.dart';

class LoginViewModel {
  late final UserDao _db;
  final BuildContext context;
  late final UserProvider _userProvider;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  LoginViewModel(this.context) {
    _db = Provider.of<AppDatabase>(context, listen: false).userDao;
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    final result = await _db.signIn(email: email, password: password);
    return result;
  }

  Future<void> signIn(GlobalKey<FormState> key) async {
    if (key.currentState!.validate()) {
      User? user = await login(
        email: emailController.text,
        password: passwordController.text,
      );
      if (user != null) {
        PrefsService.save(user.id);
        _userProvider = Provider.of<UserProvider>(context, listen: false);
        _userProvider.setUser = user;
        navigatorHome();
      } else {
        showSnackBar();
      }
    }
  }

  void navigatorHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false);
  }

  showSnackBar() {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Usuário ou senha incorretos, tente novamente!',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  void navigatorCreateAccount() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CreateAccountPage()));
  }
}
