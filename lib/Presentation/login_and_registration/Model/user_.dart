import 'package:flutter/material.dart';

class UserCredentials extends ChangeNotifier {
  String? username;
  String? email;
  String? password;
  String? reEnterPassword;

  void setUsername(String username) {
    this.username = username;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setReEnterPassword(String reEnterPassword) {
    this.reEnterPassword = reEnterPassword;
    notifyListeners();
  }
}
