import 'package:amaze/pages/Books/book_shelf.dart';
import 'package:amaze/pages/Home/creators_home.dart';
import 'package:amaze/pages/Home/homepage.dart';
import 'package:amaze/components/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CreatorsNavigation extends StatefulWidget {
  const CreatorsNavigation({super.key, this.index});
  final int? index;

  @override
  State<CreatorsNavigation> createState() => _CreatorsNavigationState();
}

class _CreatorsNavigationState extends State<CreatorsNavigation> {
  late int _selectedIndex = widget.index ?? 0;
  late Color _selectedColor = Get.isDarkMode ? Colors.white : Color(0xff143ED2);
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    CreatorsHome(),
    Bookshelf(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  _onItemTapped(int index) {
    if (index == 2) {
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
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/bookshelf.svg',
              color: _selectedIndex == 1 ? _selectedColor : Colors.grey,
              height: 17,
            ),
            label: 'Bookshelf',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/settingsicon.svg',
              color: _selectedIndex == 2 ? _selectedColor : Colors.grey,
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
