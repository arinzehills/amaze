import 'package:amaze/components/icon_container.dart';
import 'package:amaze/components/my_button.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class SocialLogin extends StatefulWidget {
  const SocialLogin({super.key});

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          color: Color(0xff1791E2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 78.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //     padding: EdgeInsets.all(0.0),
                    //     height: 100,
                    //     child: Image.asset('assets/picture.png')),
                    Text(
                      'AMAZE',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                    Text(
                      'Continue with social media',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                // height: MediaQuery.of(context).size.height * 0.3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 145.0),
                  child: Column(
                    children: [
                      MyButton(
                        placeHolder: 'CONTINUE WITH FACEBOOK',
                        color: Color(0xff4267B2),
                        textColor: Colors.white,
                        child: SvgPicture.asset(
                          'assets/svg/facebookicon.svg',
                          color: Colors.white,
                        ),
                        pressed: () {
                          // MyNavigate.navigatejustpush(Login(), context);
                        },
                      ),
                      MyButton(
                        placeHolder: 'CONTINUE WITH GOOGLE',
                        textColor: Colors.white,
                        color: Color(0xff679EF5),
                        child: SvgPicture.asset(
                          'assets/svg/google.svg',
                          height: 30,
                          // color: Colors.white,
                        ),
                        pressed: () {},
                      ),
                      MyButton(
                        placeHolder: 'CONTINUE WITH TWITTER',
                        textColor: Colors.white,
                        color: Color(0xff4267B2),
                        child: SvgPicture.asset(
                          'assets/svg/twittericon.svg',
                          color: Colors.white,
                        ),
                        pressed: () {},
                      ),
                      LoginPolicyDesc(),
                      IconContainer()
                    ],
                    // 'By signing in, creating an account, or checking out as a Guest, you are agreeing to our Terms of Use and our Privacy Policy'),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class LoginPolicyDesc extends StatelessWidget {
  const LoginPolicyDesc({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0).copyWith(top: 50),
      child: RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  fontSize: 14), //apply style to all
              children: [
            TextSpan(
                text:
                    'By signing in, creating an account, or checking out as a Guest, you are agreeing to our ',
                style: TextStyle()),
            TextSpan(
                text: 'Terms of Use ',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            TextSpan(text: ' and our', style: TextStyle()),
            TextSpan(
                text: ' Privacy Policy',
                style: TextStyle(fontSize: 18, color: Colors.black))
          ])),
    );
  }
}
