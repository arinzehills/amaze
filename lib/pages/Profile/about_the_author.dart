import 'dart:convert';

import 'package:amaze/components/loading.dart';
import 'package:amaze/components/my_button.dart';
import 'package:amaze/components/skeleton.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/user.dart';
import 'package:amaze/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AboutTheAuthor extends StatefulWidget {
  AboutTheAuthor({super.key, required this.user_id});
  String user_id;

  @override
  State<AboutTheAuthor> createState() => _AboutTheAuthorState();
}

class _AboutTheAuthorState extends State<AboutTheAuthor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppbar(),
      body: Container(
        padding: EdgeInsets.all(10).copyWith(bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_sharp,
                    color: myDarkBlue,
                    size: 33,
                  ),
                ),
                FutureBuilder<User>(
                    future: AuthService().getAUser(widget.user_id),
                    builder: (ctx, snapshot) {
                      if (snapshot.data == null) {
                        return loadingWidget();
                      }
                      User user = snapshot.data!;

                      return Column(
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              'assets/svg/usericon.svg',
                              color: myDarkBlue,
                            ),
                          ),
                          Text(
                            '${user.first_name} ${user.last_name}',
                            style: TextStyle(
                                color: myDarkBlue, fontSize: 22, height: 2),
                          ),
                          Text(
                            ' ${user.followers!.length} followers',
                            style: TextStyle(fontSize: 15, height: 2),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            user.about_author ??
                                'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.',
                            style: TextStyle(height: 1.8),
                          ),
                        ],
                      );
                    })
              ],
            ),
            MyButton(
              placeHolder: 'Follow',
              pressed: () async {
                var res = await AuthService().followUser(widget.user_id);
                if (res['success']) {
                  setState(() => {});
                }
              },
              height: 40,
              widthRatio: 0.4,
              color: myDarkBlue,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Column loadingWidget() {
    return Column(
      children: [
        Skeleton(
          height: 80,
          width: 80,
        ),
        Skeleton(
          height: 30,
          width: 90,
        ),
        Skeleton(
          height: 60,
          width: double.infinity,
        ),
        Skeleton(
          height: 60,
          width: double.infinity,
        ),
      ],
    );
  }
}

class BlueAppbar extends StatelessWidget with PreferredSizeWidget {
  BlueAppbar({
    Key? key,
    this.title,
  }) : super(key: key);
  String? title;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(title ?? ''),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: Get.isDarkMode
                      ? [mydarkModeBlue, mydarkModePurple]
                      : <Color>[myPurple, myBlue])),
        ));
  }
}
