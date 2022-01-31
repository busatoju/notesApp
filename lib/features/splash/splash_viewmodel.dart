import 'package:flutter/material.dart';
import 'package:note_app/features/auth/login_page.dart';
import 'package:note_app/features/home/home_page.dart';
import 'package:note_app/shared/db/app_database.dart';
import 'package:note_app/shared/db/dao/user_dao.dart';
import 'package:note_app/shared/providers/user_provider.dart';
import 'package:note_app/shared/services/preferences_service.dart';
import 'package:provider/provider.dart';

class SplashViewModel {
  late final BuildContext context;
  late final User? _user;
  late final UserDao _db;

  SplashViewModel(this.context) {
    _db = Provider.of<AppDatabase>(context).userDao;
  }

  Future<void> getUser(int? userId) async {
    if (userId != null) {
      _user = await _db.getUser(userId);
      if (_user != null) {
        final _userProvider = Provider.of<UserProvider>(context, listen: false);
        _userProvider.setUser = _user!;

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  void navigator() {
    Future.wait(
      [
        Future.delayed(const Duration(seconds: 2)),
        PrefsService.getUser(),
      ],
    ).then((value) {
      var userId = value[1];
      getUser(userId);
    });
  }
}
