import 'package:amaze/components/icon_container.dart';
import 'package:flutter/material.dart';

class SocialAuthWidget extends StatelessWidget {
  const SocialAuthWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconContainer(
            svgUrl: 'assets/svg/facebookicon.svg',
            color: Color(0xff4267B2),
          ),
          IconContainer(
            svgUrl: 'assets/svg/google.svg',
            color: Color.fromARGB(255, 88, 135, 229),
          ),
          IconContainer(
            svgUrl: 'assets/svg/twittericon.svg',
            color: Color.fromARGB(255, 85, 169, 253),
          )
        ],
      ),
    );
  }
}
