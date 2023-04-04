import 'package:amaze/components/amaze_more.dart';
import 'package:amaze/components/my_curve_container.dart';
import 'package:amaze/components/myappbar.dart';
import 'package:amaze/components/mydrawer.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/user.dart';
import 'package:amaze/pages/Books/upload_book.dart';
import 'package:amaze/pages/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(
      context,
    );
    return Scaffold(
      drawer: MyDrawer(),
      // appBar: MyAppMenuBar(title: 'title'),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Wrap(
          children: [
            Column(
              children: [
                MyCurveContainer(
                  size: size(context),
                  height: size(context).height * 0.22,
                  pagetitle: 'Brain world',
                  searchHint: 'Title, Genre or Author...',
                  showSearchButton: true,
                  showPageTitle: false,
                  isCircular: false,
                  curvecontainerwidget1: Padding(
                    padding: const EdgeInsets.all(10).copyWith(top: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => MyNavigate.navigatejustpush(
                                  Profile(), context),
                              child: Icon(
                                Icons.account_circle_sharp,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome,',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  user == null
                                      ? "__, __"
                                      : '${user.first_name},${user.last_name}',
                                  // ??'Aima, Zukwanya',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications_active_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0).copyWith(top: 5),
              child: Column(
                children: [
                  AmazeMore(
                    withBorder: true,
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
                            child: SelectCard(choice: choices[index]),
                          );
                        })),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Choice {
  Choice({this.title, this.icon, this.image, this.onTap});
  final String? title;
  final String? image;
  final IconData? icon;
  final VoidCallback? onTap;
}

List<Choice> choices = <Choice>[
  Choice(title: 'FEATURED BOOK', icon: Icons.home),
  Choice(title: 'RECOMMENDED', icon: Icons.contacts),
  Choice(title: 'EDITORS PICKS', icon: Icons.map),
  Choice(title: 'NEWS', icon: Icons.map),
  // Choice(title: 'Phone', icon: Icons.phone),
  // Choice(title: 'Camera', icon: Icons.camera_alt),
  // Choice(title: 'Setting', icon: Icons.settings),
  // Choice(title: 'Album', icon: Icons.photo_album),
  // Choice(title: 'WiFi', icon: Icons.wifi),
];

class SelectCard extends StatelessWidget {
  const SelectCard({this.choice, this.onTap});
  final Choice? choice;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      fontSize: 12,
    );

    return InkWell(
      onTap: onTap,
      child: Card(
          color: Get.isDarkMode ? Colors.grey[700] : Color(0xffD8EFFF),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(choice!.image ?? 'assets/svg/openbook.svg'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(choice!.title!, style: textStyle),
                ]),
          )),
    );
  }
}
