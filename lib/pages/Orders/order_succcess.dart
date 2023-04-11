import 'package:amaze/components/icon_container.dart';
import 'package:amaze/components/my_button.dart';
import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/pages/Discover/discover_detail.dart';
import 'package:amaze/pages/Home/HomepageNavigation.dart';
import 'package:amaze/providers/discover_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          padding:
              EdgeInsets.all(30).copyWith(top: size(context).height * 0.45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          color: myDarkBlue,
                          borderRadius: BorderRadius.circular(150)),
                      child: Icon(
                        Icons.check_sharp,
                        size: 90,
                        color: white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Order Successfully Added' + ' to Your Collections',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: myDarkBlue),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 140),
                child: Column(
                  children: [
                    // Spacer(),
                    MyButton(
                        placeHolder: 'Go to Home',
                        textColor: Colors.white,
                        color: myDarkBlue,
                        pressed: () {
                          // MyNavigate.navigatepushuntil(
                          //     HomepageNavigation(), context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (context) => DiscoverProvider(),
                                child: HomepageNavigation(),
                              ),
                            ),
                          );
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
