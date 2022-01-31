import 'package:flutter/material.dart';

class PasswordViewModel extends ChangeNotifier {
  bool _isObscure = true;

  bool get isObscure => _isObscure;

  void showPassword() {
    _isObscure = !_isObscure;
    notifyListeners();
  }
}
