import 'dart:async';
import 'package:amaze/pages/Home/HomepageNavigation.dart';
import 'package:amaze/auth_screens/Login.dart';
import 'package:amaze/models/user.dart';
import 'package:amaze/pages/Home/creators_navigation.dart';
import 'package:amaze/providers/cart_provider.dart';
import 'package:amaze/providers/discover_provider.dart';
import 'package:amaze/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return Login();
    } else {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserService(),
          ),
          ChangeNotifierProvider(
            create: (_) => DiscoverProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => CartProvider(),
          )
        ],
        child: Consumer<UserService>(
            builder: (context, UserService usertype, child) {
          return usertype.isCreator
              ? CreatorsNavigation()
              : HomepageNavigation();
        }),
      );
    }
  }
}
