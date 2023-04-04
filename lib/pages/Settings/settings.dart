import 'package:amaze/components/custom_switch_tile.dart';
import 'package:amaze/pages/Profile/about_the_author.dart';
import 'package:amaze/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isDarkModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        appBar: BlueAppbar(
          title: 'Settings',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomSwitchListTile(
                  title: 'Dark Mode',
                  value: themeNotifier.isDark,
                  onChanged: (value) {
                    // _isDarkModeEnabled
                    //     ? Get.changeTheme(ThemeData.light())
                    //     : Get.changeTheme(ThemeData.dark());
                    themeNotifier.isDark
                        ? themeNotifier.isDark = false
                        : themeNotifier.isDark = true;
                  },
                ),
                Divider(),
                CustomSwitchListTile(
                  title: 'Night Shift',
                  value: _isDarkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isDarkModeEnabled = value;
                      if (_isDarkModeEnabled) {
                        // Enable dark mode
                        // You can add your own code here to implement dark mode
                      } else {
                        // Disable dark mode
                        // You can add your own code here to implement default mode
                      }
                    });
                  },
                ),
                Divider(),
                CustomSwitchListTile(
                  title: 'Dark Mode',
                  value: _isDarkModeEnabled,
                  onChanged: (value) {},
                ),
                Divider(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
