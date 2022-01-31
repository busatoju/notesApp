import 'package:note_app/shared/db/app_database.dart';

class UserProvider {
   User? _user;

  set setUser(User user) {
    _user = user;
  }

  User? get user => _user;
}
