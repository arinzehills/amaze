import 'package:amaze/auth_screens/Login.dart';
import 'package:amaze/auth_screens/social_login.dart';
import 'package:amaze/components/social_auth_widget.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/user.dart';
import 'package:amaze/pages/Home/HomepageNavigation.dart';
import 'package:amaze/components/icon_container.dart';
import 'package:amaze/components/my_button.dart';
import 'package:amaze/components/my_text_field.dart';
import 'package:amaze/components/no_account.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:iconly/iconly.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  String first_name = '',
      last_name = '',
      email = '',
      password = '',
      cpassword = '';
  bool emailValid = false;
  bool stayLoggedIn = false;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_circle_left,
                        color: Colors.black45,
                        size: 33,
                      ),
                    ),
                    Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: MyTextField(
                      validator: (val) =>
                          val!.isEmpty ? 'Please Enter an email address' : null,
                      hintText: 'First name',
                      suffixIconButton: Icon(
                        first_name != ''
                            ? FeatherIcons.check
                            : FeatherIcons.alertCircle,
                        color: first_name != ''
                            ? Color.fromARGB(255, 83, 231, 88)
                            : Colors.grey,
                      ),
                      keyboardType: TextInputType.name,
                      autovalidate: true,
                      onChanged: (val) {
                        setState(
                          () => first_name = val,
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: MyTextField(
                      validator: (val) =>
                          val!.isEmpty ? 'Please Enter an email address' : null,
                      hintText: 'Last name',
                      suffixIconButton: Icon(
                        last_name != ''
                            ? FeatherIcons.check
                            : FeatherIcons.alertCircle,
                        color: last_name != ''
                            ? Color.fromARGB(255, 83, 231, 88)
                            : Colors.grey,
                      ),
                      keyboardType: TextInputType.name,
                      autovalidate: false,
                      onChanged: (val) {
                        setState(() => {
                              last_name = val,
                            });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: MyTextField(
                      validator: (val) =>
                          val!.isEmpty ? 'Please Enter an email address' : null,
                      hintText: 'Enter email',
                      suffixIconButton: Icon(
                        emailValid
                            ? FeatherIcons.check
                            : FeatherIcons.alertCircle,
                        color: emailValid
                            ? Color.fromARGB(255, 83, 231, 88)
                            : Colors.grey,
                      ),
                      keyboardType: TextInputType.name,
                      autovalidate: false,
                      onChanged: (val) {
                        setState(() => {
                              email = val,
                              emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val)
                            });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: MyTextField(
                    hintText: 'Create Password',
                    keyboardType: TextInputType.visiblePassword,
                    autovalidate: false,
                    validator: (val) =>
                        val!.isEmpty ? 'Please Enter email' : null,
                    onChanged: (val) {
                      if (mounted) {
                        setState(() => password = val);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: MyTextField(
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                    autovalidate: true,
                    validator: (val) =>
                        val != password ? 'Password must match' : null,
                    onChanged: (val) {
                      if (mounted) {
                        setState(() => cpassword = val);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red),
                ),
                MyButton(
                  placeHolder: 'Register',
                  color: Color(0xff1A8DE0),
                  textColor: Colors.white,
                  loadingState: loading,
                  pressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      var user = User(
                          first_name: first_name,
                          last_name: last_name,
                          email: email,
                          password: password);
                      var response = await AuthService().register(user);
                      // var body = json.decode(response.body);
                      print(response['success']);
                      if (response['success'] == true) {
                        snackBar(HomepageNavigation(), context,
                            'Registered in successfully');
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
                  subtitle: 'Sign in',
                  pressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                ),
                // this is for social icons
                SocialAuthWidget(),
                LoginPolicyDesc()
              ],
            ),
          ),
        ),
      )),
    );
  }
}
