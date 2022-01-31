import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const String _key = 'key';

  static void save(int userId) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(
      _key,
      jsonEncode({'userId': userId}),
    );
  }

  static void logout() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(_key);
  }

  static Future getUser() async {
    var prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(_key);

    if (result != null) {
      var map = jsonDecode(result);
      var user = map['userId'];

      return user;
    }
  }
}
