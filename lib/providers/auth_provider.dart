import 'package:amaze/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  notifyListeners();

  inputData() async {
    var user = await AuthService().getuserFromStorage();

    notifyListeners();

    return user;
  }
}
