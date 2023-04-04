import 'package:amaze/components/my_button.dart';
import 'package:amaze/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AmazeMore extends StatelessWidget {
  const AmazeMore(
      {super.key,
      this.amazeText,
      this.amazeMinHeight,
      this.withBorder = false});
  final String? amazeText;
  final double? amazeMinHeight;
  final bool withBorder;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      // margin: EdgeInsets.all(5).copyWith(top: 10),

      margin: EdgeInsets.only(top: 10),
      constraints: BoxConstraints(minHeight: amazeMinHeight ?? 250),
      decoration: BoxDecoration(
          color: Get.isDarkMode ? mydarkModePurple : Colors.white,
          borderRadius: BorderRadius.circular(withBorder ? 0 : 10),
          border:
              Border.all(color: withBorder ? Colors.blueAccent : Colors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ]),
      child: SizedBox(
        child: Row(
          children: [
            SizedBox(
              width: 185,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'amaze',
                    style: TextStyle(
                        fontSize: 39,
                        color: Color(0xff2081D8),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    amazeText ??
                        'Popular Categories and' +
                            ' Featured books will ' +
                            'appear below',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  MyButton(
                      placeHolder: 'More Tips',
                      textColor: Color(0xff4267B2),
                      color: Color(0xffD7E9FF),
                      widthRatio: 0.25,
                      height: 26,
                      isOval: true,
                      pressed: () {})
                ],
              ),
            ),
            SvgPicture.asset(
              'assets/svg/homepagebook.svg',
              height: amazeMinHeight != null ? 123 : 157,
            ),
          ],
        ),
      ),
    );
  }
}
