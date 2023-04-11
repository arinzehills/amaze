import 'dart:io';

import 'package:amaze/custom_splash.dart';
import 'package:amaze/models/book_info.dart';
import 'package:amaze/models/user.dart';
import 'package:amaze/pages/Home/HomepageNavigation.dart';
import 'package:amaze/providers/auth_provider.dart';
import 'package:amaze/providers/discover_provider.dart';
import 'package:amaze/providers/theme_provider.dart';
import 'package:amaze/services/auth_service.dart';
import 'package:amaze/services/cart_service.dart';
import 'package:amaze/welcome_screen.dart';
import 'package:amaze/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('cart');
  await Hive.openBox('downloads');
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CartService controller = Get.put(CartService());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<User?>(
      create: (_) => User(),
      child: ChangeNotifierProvider(
        create: (_) => ModelTheme(),
        child: Consumer<ModelTheme>(
            builder: (context, ModelTheme themeNotifier, child) {
          return FutureProvider<User?>.value(
            initialData: null,
            catchError: (_, __) => null,
            value: AuthService().getuserFromStorage(),
            child: GetMaterialApp(
              title: 'Amaze Books',
              initialRoute: '/',
              routes: {
                '/': (context) => CustomSplashScreen(),
                '/main': (context) => Wrapper(),
                '/discover': (context) => ChangeNotifierProvider(
                      create: (context) => DiscoverProvider(),
                      child: HomepageNavigation(
                        index: 2,
                      ),
                    ),
              },
              darkTheme: ThemeData(
                primaryColor: Colors.black,
                canvasColor: Colors.black,
                scaffoldBackgroundColor: Colors.black,
              ),
              theme: themeNotifier.isDark
                  ? ThemeData(
                      brightness: Brightness.dark,
                    )
                  : ThemeData(
                      brightness: Brightness.light,
                    ),
              // home: Wrapper(),
            ),
          );
        }),
      ),
    );
  }
}
