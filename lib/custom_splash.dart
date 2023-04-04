import 'package:amaze/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CustomSplashScreen extends StatefulWidget {
  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 5 seconds before navigating to the main screen
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: myGradient)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add the AnimatedTextKit widget here
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'Horizon',
                  decoration: TextDecoration.underline,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    // Add the animated text here
                    RotateAnimatedText(
                      'AMAZE',
                    ),
                  ],
                  totalRepeatCount: 999,
                  pause: Duration(milliseconds: 1000),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
