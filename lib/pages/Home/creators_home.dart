import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/pages/Books/upload_book.dart';
import 'package:amaze/pages/Books/upload_book_info.dart';
import 'package:amaze/pages/Home/homepage.dart';
import 'package:amaze/components/amaze_more.dart';
import 'package:amaze/components/my_curve_container.dart';
import 'package:amaze/components/mydrawer.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/pages/Profile/authors_profile.dart';
import 'package:amaze/pages/Settings/creators_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreatorsHome extends StatelessWidget {
  const CreatorsHome({super.key});

  @override
  Widget build(BuildContext context) {
    List<Choice> choices = <Choice>[
      Choice(
        title: 'UPLOAD BOOK',
        icon: Icons.home,
        onTap: (() => MyNavigate.navigatejustpush(UploadBook(), context)),
      ),
      Choice(
          title: 'AUTHOR PROFILE',
          icon: Icons.contacts,
          onTap: (() =>
              MyNavigate.navigatejustpush(AuthorsProfileEdit(), context)),
          image: 'assets/svg/coverbook.svg'),
      Choice(
          title: 'SETTINGS',
          onTap: (() =>
              MyNavigate.navigatejustpush(Creatorssettings(), context)),
          image: 'assets/svg/hmpg-settings.svg'),
      Choice(title: 'PROMOTION', icon: Icons.map),
    ];

    return Scaffold(
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Wrap(
          children: [
            Column(
              children: [
                MyCurveContainer(
                  size: size(context),
                  height: size(context).height * 0.46,
                  pagetitle: 'Brain world',
                  // searchHint: 'here...',
                  showSearchButton: true,
                  showPageTitle: false,
                  isCircular: false,
                  curvecontainerwidget1: Padding(
                    padding: EdgeInsets.all(25).copyWith(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            welcomeText(context),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.account_circle_sharp,
                            color: Colors.white,
                            size: 50,
                          ),
                        )
                      ],
                    ),
                  ),
                  curvecontainerwidget2: Padding(
                    padding: EdgeInsets.all(8.0).copyWith(right: 15),
                    child: AmazeMore(
                      amazeMinHeight: 200,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size(context).height * 0.99,
              child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(choices.length, (index) {
                    return Center(
                      child: SelectCard(
                        choice: choices[index],
                        onTap: choices[index].onTap,
                      ),
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}

Widget welcomeText(BuildContext context, {textColor}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Welcome,',
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        '${user(context)!.first_name},${user(context)!.last_name}',
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
