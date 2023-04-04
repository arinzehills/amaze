import 'package:amaze/auth_screens/Login.dart';
import 'package:amaze/auth_screens/register.dart';
import 'package:amaze/auth_screens/social_login.dart';
import 'package:amaze/components/my_button.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [myBlue, myPurple],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.all(10.0),
                  height: 200,
                  child: SvgPicture.asset('assets/svg/loginbook.svg')),
              SizedBox(
                height: 80,
              ),
              Column(
                children: [
                  MyButton(
                    placeHolder: 'Login',
                    color: Color(0xff568AE2),
                    textColor: Colors.white,
                    withBorder: true,
                    pressed: () async {
                      MyNavigate.navigatejustpush(Login(), context);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyButton(
                    placeHolder: 'Sign up',
                    pressed: () async {
                      MyNavigate.navigatejustpush(Register(), context);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    child: Text(
                      'Sign up with email / Social media',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: (() =>
                        {MyNavigate.navigatejustpush(SocialLogin(), context)}),
                  )
                ],
              ),
            ]),
      ),
    );
  }
}
