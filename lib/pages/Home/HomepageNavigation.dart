import 'package:amaze/pages/Collections/collections.dart';
import 'package:amaze/pages/Discover/discover.dart';
import 'package:amaze/pages/Home/homepage.dart';
import 'package:amaze/components/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomepageNavigation extends StatefulWidget {
  const HomepageNavigation({
    super.key,
    this.index,
  });
  final int? index;

  @override
  State<HomepageNavigation> createState() => _HomepageNavigationState();
}

class _HomepageNavigationState extends State<HomepageNavigation> {
  late int _selectedIndex = widget.index ?? 0;
  late Color _selectedColor = Get.isDarkMode ? Colors.white : Color(0xff143ED2);
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    Collections(),
    Discover(),
    Text('data'),
  ];

  _onItemTapped(int index) {
    if (index == 3) {
      print('are u there');
      _drawerKey.currentState!.openDrawer();
      _selectedColor = Get.isDarkMode ? Colors.white : Color(0xff143ED2);
    } else {
      setState(() {
        _selectedIndex = index;
        _selectedColor = Get.isDarkMode ? Colors.white : Color(0xff143ED2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: MyDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/homeicon.svg',
              color: _selectedIndex == 0 ? _selectedColor : Colors.grey,
              height: 17,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/collectionicon.svg',
              color: _selectedIndex == 1 ? _selectedColor : Colors.grey,
              height: 17,
            ),
            label: 'Collections',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/shoppingicon.svg',
              color: _selectedIndex == 2 ? _selectedColor : Colors.grey,
              height: 17,
            ),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/settingsicon.svg',
              color: _selectedIndex == 3 ? _selectedColor : Colors.grey,
              height: 17,
            ),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: _selectedColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
