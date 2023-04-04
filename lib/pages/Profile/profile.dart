import 'dart:io';

import 'package:amaze/components/loading.dart';
import 'package:amaze/components/my_button.dart';
import 'package:amaze/components/my_networkimage.dart';
import 'package:amaze/components/my_text_field.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/user.dart';
import 'package:amaze/pages/Home/HomepageNavigation.dart';
import 'package:amaze/services/auth_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextStyle labelStyle = TextStyle(color: Color(0xff636DEA));
  bool isEdit = true, loading = false;
  File? avatarImageFile;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String firstName = '';
  String email = '',
      // firstName = user.first_name ?? '',
      lastName = '',
      middleName = '',
      phone = '',
      dateOB = '';
  String city = '', country = '';
  String error = '';

  Widget textField(
          {initialValue, lableText, widthRatio, Function(String)? onChanged}) =>
      GestureDetector(
        onDoubleTap: () => setState(() => {isEdit = !isEdit}),
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          width: widthRatio != null ? size(context).width * 0.47 : null,
          child: TextFormField(
            initialValue: initialValue ?? '',
            readOnly: isEdit,
            decoration: InputDecoration(
              labelText: lableText ?? 'First Name',
              labelStyle: labelStyle,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
            onChanged: onChanged,
            // onSaved: (value) => _lastName = value,
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: FutureBuilder<User>(
                future: AuthService().getuserFromStorage(),
                builder: (ctx, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Loading();
                  }
                  User user = snapshot.data!;

                  return SingleChildScrollView(
                      child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15).copyWith(top: 80),
                        height: size(context).height * 0.32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(0)),
                            color: myDarkBlue),
                        child: Wrap(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_outlined,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                                InkWell(
                                  onTap: () =>
                                      setState(() => {isEdit = !isEdit}),
                                  child: !isEdit
                                      ? Icon(
                                          Icons.cancel_rounded,
                                          color: Colors.white,
                                          size: 31,
                                        )
                                      : Text(
                                          'Edit',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 23),
                                        ),
                                )
                              ],
                            ),
                            Center(
                              child: Column(
                                children: [
                                  avatarImageFile == null
                                      ? MyNetworkImage(
                                          // imgUrl: userData['profilePicture'],
                                          imgUrl: user.profilePicture,
                                        )
                                      : ClipRRect(
                                          //if user pick a file show this
                                          borderRadius:
                                              BorderRadius.circular(45),
                                          child: Image.file(
                                            avatarImageFile!,
                                            width: 90,
                                            height: 90,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                  TextButton(
                                      onPressed: selectImage,
                                      child: Text(
                                        'Change Photo',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            height: 1.2),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin:
                              EdgeInsets.only(top: size(context).height * 0.3),
                          padding: EdgeInsets.all(10.3),
                          child: Column(
                            children: [
                              Container(
                                // width: size(context).width * 0.4,
                                child: Row(
                                  children: [
                                    textField(
                                      lableText: 'First Name',
                                      initialValue:
                                          user.first_name ?? 'No first name',
                                      widthRatio: true,
                                      onChanged: (val) {
                                        if (mounted) {
                                          setState(() => firstName = val);
                                        }
                                        print('val');
                                        // print(val);
                                        print('firstName');
                                        print(firstName);
                                      },
                                    ),
                                    textField(
                                      lableText: 'Last Name',
                                      initialValue:
                                          user.last_name ?? 'No last name',
                                      widthRatio: true,
                                      onChanged: (val) {
                                        setState(() => lastName = val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              textField(
                                lableText: 'Middle Name',
                                initialValue:
                                    user.middle_name ?? 'No middle name',
                                onChanged: (val) {
                                  setState(() => middleName = val);
                                },
                              ),
                              textField(
                                lableText: 'Phone',
                                initialValue: user.phone ?? '+23-xxx-xxx-xx',
                                onChanged: (val) {
                                  setState(() => phone = val);
                                },
                              ),
                              textField(
                                lableText: 'Email',
                                initialValue: user.email,
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                              ),
                              textField(
                                lableText: 'Date of Birth',
                                initialValue:
                                    user.dateOB ?? '08 | August| 1900',
                                onChanged: (val) {
                                  setState(() => dateOB = val);
                                },
                              ),
                              Container(
                                // width: size(context).width * 0.4,
                                child: Row(
                                  children: [
                                    textField(
                                      lableText: 'Country',
                                      initialValue:
                                          user.country ?? 'No Country Added',
                                      widthRatio: true,
                                      onChanged: (val) {
                                        setState(() => country = val);
                                      },
                                    ),
                                    textField(
                                      lableText: 'City',
                                      initialValue:
                                          user.city ?? 'No City Added',
                                      widthRatio: true,
                                      onChanged: (val) {
                                        setState(() => city = val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              MyButton(
                                  placeHolder: 'Save',
                                  textColor: Colors.white,
                                  isDisable: isEdit,
                                  color: myDarkBlue,
                                  pressed: () async {
                                    setState(() => {loading = true});
                                    var dataToUpdate = {
                                      'first_name': firstName,
                                      'last_name': lastName,
                                      'middle_name': middleName,
                                      'phone': phone,
                                      'email': email,
                                      'dateOB': dateOB,
                                      'city': city,
                                      'country': country,
                                    };
                                    var response = await AuthService()
                                        .updateUser(dataToupdate: dataToUpdate);
                                    if (response['success'] == true) {
                                      setState(() {});
                                      setState(() => {loading = false});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: myDarkBlue,
                                              content: Text(
                                                  response['message'] ??
                                                      ' Successfully')));
                                    } else {
                                      setState(() => loading = false);
                                      setState(
                                          () => error = response['message']);
                                    }
                                    setState(() => {});
                                  })
                            ],
                          ),
                        ),
                      )
                    ],
                  ));
                }));
  }

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => avatarImageFile = new File(path));
    uploadImage(avatarImageFile);
  }

  Future uploadImage(profilePic) async {
    AuthService().updateProfilePicture(profilePic).then((response) => {
          print('response'),
          print(response),
          if (response['success'] == true)
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: myDarkBlue,
                  content: Text(response['message'] ?? ' Successfully')))
            }
          else
            {print('failure')}
        });

    setState(() {});
  }
}
