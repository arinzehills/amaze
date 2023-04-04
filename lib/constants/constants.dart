import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

final white = Color.fromARGB(255, 255, 255, 255);
final transparentBlue = Color.fromARGB(43, 108, 193, 254);
final iconsColor = const Color(0xffC9C4C4);
final mydarkModeBlue = Color.fromARGB(133, 19, 33, 40);
final mydarkModePurple = Color.fromARGB(143, 44, 20, 49);
var myBlue = Color(0xff00BBFF);
var myDarkBlue = const Color(0xff1A8DE0);
var myPurple = Color(0xff660080);
final myGradient = [myBlue, myPurple];

// final generalUrl = "http://10.0.2.2:3000";
final generalUrl = "http://localhost:3002";
// final generalUrl = "https://brainworld-api.onrender.com";
snackBar(page, context, text) {
  MyNavigate.navigatejustpush(page, context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: myDarkBlue,
      content: Text(text ?? 'Logged In Successfully')));
}

Size size(context) => MediaQuery.of(context).size;
User? user(context) => Provider.of<User?>(context, listen: false);

var textFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: const Color(0xff626262)),
  filled: true,
  // fillColor: Color(0xfff7f7f7),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.circular(5.0),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.circular(5.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.circular(5.0),
  ),
);
