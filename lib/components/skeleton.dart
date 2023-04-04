import 'package:amaze/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Skeleton extends StatelessWidget {
  final double? height;
  final double? width;
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 0),
        child: Material(
          // elevation: Get.isDarkMode ? 10 : 0,
          child: Container(
            padding: EdgeInsets.all(8),
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? Colors.grey[800]
                  : Colors.black.withOpacity(0.04),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
      );
}
