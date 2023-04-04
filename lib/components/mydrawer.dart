import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/pages/Home/HomepageNavigation.dart';
import 'package:amaze/pages/Home/creators_home.dart';
import 'package:amaze/pages/Home/creators_navigation.dart';
import 'package:amaze/auth_screens/Login.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/user.dart';
import 'package:amaze/pages/Profile/profile.dart';
import 'package:amaze/pages/Settings/change_password.dart';
import 'package:amaze/pages/Settings/settings.dart';
import 'package:amaze/services/auth_service.dart';
import 'package:amaze/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({this.isCreator = false});
  bool isCreator;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late bool isCreator = false;

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);

    return Consumer<UserService>(
        builder: (context, UserService usertype, child) {
      print(usertype.isCreator);
      return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          SizedBox(
            height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? Color.fromARGB(255, 68, 62, 62)
                      : Colors.white),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 190,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.menu),
                                  color: Get.isDarkMode
                                      ? Colors.grey
                                      : Color(0xff4267B2),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                              Text(
                                'Menu',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.grey
                                      : Color(0xff4267B2),
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.account_circle_rounded),
                          color: Get.isDarkMode ? Colors.grey : myBlue,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // end of header
          ListTile(
            leading: Icon(
              Icons.account_circle_outlined,
              color: Get.isDarkMode ? Colors.grey : Color(0xff4267B2),
            ),
            title: Text('Profile'),
            onTap: () => {MyNavigate.navigatejustpush(Profile(), context)},
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle_outlined,
              color: Get.isDarkMode ? Colors.grey : Color(0xff4267B2),
            ),
            title: Text(usertype.isCreator
                ? 'Back to Main Profile'
                : 'Switch to Creator'),
            onTap: () async {
              usertype.isCreator
                  ? usertype.switchUserType = false
                  : usertype.switchUserType = true;
              // if (response['success'] == true) {
              //   snackBar(
              //       usertype.isCreator
              //           ? HomepageNavigation()
              //           : CreatorsNavigation(),
              //       context,
              //       'Switch profiled');
              // }
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //       builder: (context) =>
              //           isCreator ? HomepageNavigation() : CreatorsNavigation()),
              // );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.lock_outlined,
              color: Get.isDarkMode ? Colors.grey : Color(0xff4267B2),
            ),
            title: Text('Change Password'),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ChangePassword()),
              )
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings_outlined,
              color: Get.isDarkMode ? Colors.grey : Color(0xff4267B2),
            ),
            title: Text('Settings'),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Settings()),
              )
            },
          ),
          ListTile(
            leading: Icon(
              IconlyBold.paper,
              color: Get.isDarkMode ? Colors.grey : Color(0xff4267B2),
            ),
            title: Text('Help & Feedback'),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Login()),
              )
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shield_outlined,
              color: Get.isDarkMode ? Colors.grey : Color(0xff4267B2),
            ),
            title: Text('Privacy Policy'),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Login()),
              )
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              IconlyBold.paper,
              color: Get.isDarkMode ? Colors.grey : Color(0xff4267B2),
            ),
            title: Text('Info'),
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Get.isDarkMode ? Colors.grey : Color(0xff4267B2),
            ),
            title: Text('Logout'),
            onTap: () async {
              var response = await AuthService().logout();
              if (response['success'] == true) {
                snackBar(Login(), context, 'Logged out successfully');
              }
            },
          ),
          SizedBox(
            height: 50,
          ),
          // Spacer(
          //   flex: 4,
          // ),
          IconButton(
            onPressed: () => {Navigator.of(context).pop()},
            icon: Icon(
              Icons.cancel,
              size: 40,
              color: Get.isDarkMode
                  ? Colors.grey
                  : Color(0xff4267B2).withOpacity(0.4),
            ),
          ),
        ]),
      );
    });
  }
}
