import 'package:amaze/components/my_button.dart';
import 'package:amaze/components/my_text_field.dart';
import 'package:amaze/components/mydrawer.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/pages/Profile/about_the_author.dart';
import 'package:amaze/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String oldpassword = '', newpassword = '', cnewpassword = '', error = '';

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: BlueAppbar(
        title: 'Change Password',
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: MyTextField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Enter your old password")
                    ]),
                    hintText: 'Old Password',
                    suffixIconButton: Icon(
                      oldpassword != ''
                          ? FeatherIcons.check
                          : FeatherIcons.alertCircle,
                      color: oldpassword != ''
                          ? Color.fromARGB(255, 83, 231, 88)
                          : Colors.grey,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    autovalidate: false,
                    onChanged: (val) {
                      setState(() => {
                            oldpassword = val,
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: MyTextField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Enter your old password'),
                    ]),
                    hintText: 'New Password',
                    suffixIconButton: Icon(
                      newpassword != ''
                          ? FeatherIcons.check
                          : FeatherIcons.alertCircle,
                      color: newpassword != ''
                          ? Color.fromARGB(255, 83, 231, 88)
                          : Colors.grey,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    autovalidate: false,
                    onChanged: (val) {
                      setState(() => {
                            newpassword = val,
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: MyTextField(
                    hintText: 'Confirm New Password',
                    keyboardType: TextInputType.visiblePassword,
                    autovalidate: false,
                    validator: (val) =>
                        val != newpassword ? 'Password must match' : null,
                    suffixIconButton: Icon(
                      cnewpassword != ''
                          ? FeatherIcons.check
                          : FeatherIcons.alertCircle,
                      color: newpassword != ''
                          ? Color.fromARGB(255, 83, 231, 88)
                          : Colors.grey,
                    ),
                    onChanged: (val) {
                      if (mounted) {
                        setState(() => {
                              cnewpassword = val,
                            });
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
                  placeHolder: 'Save',
                  color: Color(0xff1A8DE0),
                  loadingState: loading,
                  textColor: Colors.white,
                  pressed: () async {
                    print('oldpassword');
                    print(oldpassword);
                    print(newpassword);
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      var response = await AuthService()
                          .changePassword(oldpassword, newpassword);
                      // print(response['success']);
                      if (response['success'] == true) {
                        setState(() => {});
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: myDarkBlue,
                            content: Text('Password Changed Successfully')));
                        setState(() =>
                            {loading = false, _formKey.currentState!.reset()});
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
              ],
            ),
          ),
        ),
      )),
    );
  }
}
