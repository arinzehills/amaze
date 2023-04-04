import 'dart:convert';

import 'package:amaze/components/loading.dart';
import 'package:amaze/components/my_button.dart';
import 'package:amaze/components/skeleton.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/user.dart';
import 'package:amaze/pages/Books/upload_widgets.dart';
import 'package:amaze/pages/Funds/funds_and_withdrawal.dart';
import 'package:amaze/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Creatorssettings extends StatefulWidget {
  Creatorssettings({super.key, this.user_id});
  String? user_id;

  @override
  State<Creatorssettings> createState() => _CreatorssettingsState();
}

class _CreatorssettingsState extends State<Creatorssettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppbar(),
      body: Container(
        padding: EdgeInsets.all(10).copyWith(bottom: 30),
        child: Column(
          children: [
            creatorsSettingsPagetitle(context),
            Container(
              margin: EdgeInsets.only(top: size(context).height * 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  uploadWidget(
                      centerText: true,
                      text: 'Funds and Withdrawal',
                      onTap: () => MyNavigate.navigatejustpush(
                          FundsAndWithdrawal(), context)),
                  uploadWidget(
                      centerText: true,
                      text: 'REGION SETTINGS',
                      onTap: () => MyNavigate.navigatejustpush(
                          FundsAndWithdrawal(), context)),
                ],
              ),
            ),
            Spacer(
              flex: 1,
            ),
            MyButton(
              placeHolder: 'Back',
              pressed: () => {Navigator.pop(context)},
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
