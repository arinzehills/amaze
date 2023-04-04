import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconContainer extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final double? height;
  String? svgUrl;
  IconContainer({super.key, this.icon, this.color, this.height, this.svgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(svgUrl != null ? 12 : 0),
      height: height,
      width: height,
      constraints: BoxConstraints(
          minHeight: 50, minWidth: 50, maxHeight: 50, maxWidth: 50),
      decoration: BoxDecoration(
          color: color ?? Color(0xff4267B2),
          borderRadius: BorderRadius.circular(50)),
      child: svgUrl != null
          ? SvgPicture.asset(
              svgUrl ?? 'assets/svg/google.svg',
              height: 45,
              // color: Colors.white,
            )
          : IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: Icon(
                icon ?? Icons.arrow_back,
                color: Colors.white,
              )),
    );
  }
}
