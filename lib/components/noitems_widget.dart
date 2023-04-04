import 'package:amaze/components/my_button.dart';
import 'package:amaze/constants/constants.dart';
import 'package:flutter/material.dart';

class NoItemsWidget extends StatelessWidget {
  NoItemsWidget({Key? key, this.text, this.clicked}) : super(key: key);
  String? text;
  final VoidCallback? clicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      //no items
      padding: const EdgeInsets.only(top: 88.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text ?? 'No Items in Wishlist',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/dullbaby.png',
                height: 250,
                width: 290,
              ),
              clicked != null
                  ? MyButton(
                      placeHolder: 'Start Reading',
                      pressed: clicked!,
                      isGradientButton: true,
                      gradientColors: myGradient,
                      widthRatio: 0.7,
                      textColor: Colors.white,
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
