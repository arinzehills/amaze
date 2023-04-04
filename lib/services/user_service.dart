import 'package:amaze/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService extends ChangeNotifier {
  bool _isCreator = false;

  bool get isCreator => _isCreator;
  UserService() {
    _isCreator = false;
    getUserType();
  }
  setCreator(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isCreator', isCreator);
  }

  set switchUserType(bool value) {
    _isCreator = value;
    setCreator(value);
    // var response = {"success": true, "message": "success achived"};
    notifyListeners();
    // return response;
  }

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isCreator = prefs.getBool('isCreator') ?? false;
    notifyListeners();
    // return userType;
  }
}
