import 'package:amaze/components/custom_listtile.dart';
import 'package:amaze/components/searchfield.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/user.dart';
import 'package:amaze/pages/Cart/cart.dart';
import 'package:amaze/pages/Collections/collection_drawer.dart';
import 'package:amaze/pages/Downloads/downloads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class Collections extends StatefulWidget {
  const Collections({super.key});

  @override
  State<Collections> createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  int currentIndex = 0;
  bool _isOpen = false;
  double _sliderWidth = 0;

  void _toggleSlider() {
    setState(() {
      _isOpen = !_isOpen;
      _sliderWidth = _isOpen ? 200 : 0;
    });
  }

  List tabItems = [
    {
      'title': 'DOWNLOADED',
      'tab': Downloads()
      //  ListView.builder(
      //   itemCount: 3,
      //   shrinkWrap: true,
      //   padding: EdgeInsets.only(top: 10),
      //   physics: ScrollPhysics(),
      //   itemBuilder: (context, index) {
      //     // User user = snapshot.data![index];
      //     return CustomListTile(
      //         // name: 'This book',
      //         // subtitle: 'user.email',
      //         // anotherName: 'user.email',
      //         // showRightIcon: false,
      //         // rating: 3,
      //         );
      //   },
      // ),
    },
    {
      'title': 'RECENTLY OPENED',
      'tab': Text('data')
      // ListView.builder(
      //   itemCount: 3,
      //   shrinkWrap: true,
      //   padding: EdgeInsets.only(top: 10),
      //   physics: ScrollPhysics(),
      //   itemBuilder: (context, index) {
      //     // User user = snapshot.data![index];
      //     return CustomListTile(
      //         // name: 'This book',
      //         // subtitle: 'user.email',
      //         // anotherName: 'user.email',
      //         // showRightIcon: false,
      //         // rating: 3,
      //         );
      //   },
      // ),
    },
    {'title': 'WISH LIST', 'tab': MyCartWidget()},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 80),
                  height: size(context).height * 0.23,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(0)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [myBlue, myPurple])),
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SearchField(
                            onChanged: (val) {},
                            searchHint: 'Store',
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications_active,
                              color: Colors.white,
                              size: 35,
                            ),
                          )
                        ],
                      ),
                      Container(
                        color: Colors.white,
                        height: 65,
                        margin: EdgeInsets.only(top: 5),
                        // decoration: BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: _toggleSlider,
                              child: SvgPicture.asset(
                                'assets/svg/menuicon.svg',
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                                height: 50,
                                width: size(context).width * 0.85,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return TextButton(
                                          onPressed: (() => {
                                                setState(
                                                    () => currentIndex = index)
                                              }),
                                          child: Text(
                                            tabItems[index]['title'] ??
                                                'WISH LIST',
                                            style: TextStyle(
                                                color: currentIndex != index
                                                    ? Colors.black
                                                    : null),
                                          ));
                                    })),
                            // Text('DOWNLOADED'),
                            // Text('RECENTLY OPENED'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                tabItems[currentIndex]['tab']
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size(context).height * 0.24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CollectionDrawer(
                sliderWidth: _sliderWidth,
                isOpen: _isOpen,
              ),
            ),
          )
        ],
      ),
    );
  }
}
