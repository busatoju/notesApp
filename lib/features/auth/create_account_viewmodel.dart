import 'package:flutter/material.dart';
import 'package:note_app/features/auth/login_page.dart';
import 'package:note_app/shared/db/app_database.dart';
import 'package:note_app/shared/db/dao/user_dao.dart';
import 'package:provider/provider.dart';

class CreateAccountViewModel {
  late final UserDao _db;
  final BuildContext context;
  final GlobalKey<FormState> _createAccountKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  CreateAccountViewModel(this.context) {
    _db = Provider.of<AppDatabase>(context).userDao;
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }
  GlobalKey<FormState> get createAccountKey => _createAccountKey;

  Future<void> createAccount(GlobalKey<FormState> key) async {
    if (key.currentState!.validate()) {
      create(
          email: emailController.text,
          name: nameController.text,
          password: passwordController.text);
      navigatorPop();
    }
  }

  Future<int> create(
      {required String email,
      required String name,
      required String password}) async {
    return await _db.createAccount(UsersCompanion.insert(
        username: name, password: password, email: email));
  }

  void navigatorPop() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
