import 'package:amaze/auth_screens/register.dart';
import 'package:amaze/components/social_auth_widget.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/pages/Home/HomepageNavigation.dart';
import 'package:amaze/components/icon_container.dart';
import 'package:amaze/components/my_button.dart';
import 'package:amaze/components/my_text_field.dart';
import 'package:amaze/components/no_account.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconly/iconly.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '', password = '';
  bool stayLoggedIn = false;
  String error = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  bool emailValid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: MyTextField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required'),
                      EmailValidator(errorText: "Enter a Valid Email")
                    ]),
                    hintText: 'Enter email',
                    suffixIconButton: Icon(
                      emailValid
                          ? FeatherIcons.check
                          : FeatherIcons.alertCircle,
                      color: emailValid
                          ? Color.fromARGB(255, 83, 231, 88)
                          : Colors.grey,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidate: false,
                    onChanged: (val) {
                      setState(() => {
                            email = val,
                            emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: MyTextField(
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    autovalidate: false,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Password Required'),
                    ]),
                    onChanged: (val) {
                      if (mounted) {
                        setState(() => {
                              password = val,
                            });
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () => {},
                        child: SizedBox(
                          // width: 300,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => setState(
                                    () => {stayLoggedIn = !stayLoggedIn}),
                                child: Icon(
                                  stayLoggedIn
                                      ? Icons.toggle_on_sharp
                                      : Icons.toggle_off_sharp,
                                  size: 34,
                                  color: stayLoggedIn ? myDarkBlue : null,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Stay logged in')
                            ],
                          ),
                        )),
                    TextButton(
                        onPressed: () {}, child: Text('Forget Password?')),
                  ],
                ),
                MyButton(
                  placeHolder: 'Login',
                  color: Color(0xff1A8DE0),
                  loadingState: loading,
                  textColor: Colors.white,
                  pressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      var response = await AuthService().login(email, password);
                      // print(response['success']);
                      if (response['success'] == true) {
                        setState(() => {});
                        snackBar(HomepageNavigation(), context,
                            'Logged in successfully');
                      } else {
                        setState(() => loading = false);
                        setState(() => error = response['message']);
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                NoAccount(
                  title: "Don't have an account?",
                  subtitle: 'Sign up',
                  pressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                ),
                // this is for social icons
                SocialAuthWidget()
              ],
            ),
          ),
        ),
      )),
    );
  }
}
