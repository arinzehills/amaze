import 'package:amaze/constants/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String placeHolder;
  double? widthRatio;
  double? height;
  bool isOval;
  bool isDisable;
  bool withBorder;
  bool isGradientButton;
  bool reverseChildren;

  bool loadingState;
  List<Color>? gradientColors;
  Color? color;
  Color? textColor;
  final VoidCallback pressed;
  Widget? child;

  double? fontSize;

  MyButton({
    required this.placeHolder,
    this.child,
    this.isOval = false,
    this.withBorder = false,
    this.height,
    this.fontSize,
    this.widthRatio,
    this.isGradientButton = false,
    this.reverseChildren = false,
    this.loadingState = false,
    this.isDisable = false,
    this.gradientColors,
    this.color,
    this.textColor,
    required this.pressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: ElevatedButton(
        onPressed: loadingState
            ? null
            : isDisable
                ? null
                : pressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(isDisable || loadingState
              ? color?.withOpacity(0.4)
              : color ?? Colors.white),
          shape: isOval ? MaterialStateProperty.all(StadiumBorder()) : null,
          padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
        ),
        // disabledColor: Colors.orange,
        // disabledTextColor: Colors.white,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(isOval ? 80.0 : 0.0)),
        child: Ink(
          width: MediaQuery.of(context).size.width * (widthRatio ?? 0.9),
          height: height ?? 55,
          decoration: BoxDecoration(
            color: isDisable || loadingState ? color!.withOpacity(0.4) : color,
            border: withBorder ? Border.all(color: Colors.white) : null,
            gradient: isGradientButton
                ? LinearGradient(
                    colors: isDisable
                        ? [
                            gradientColors![0].withOpacity(0.1),
                            gradientColors![0].withOpacity(0.2)
                          ]
                        : gradientColors!,
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: BorderRadius.all(Radius.circular(isOval ? 30 : 4)),
          ),
          child: loadingState
              ? Center(
                  child: SpinKitFadingCube(
                    color: Colors.white,
                    size: 20.0,
                  ),
                )
              : Container(
                  constraints: const BoxConstraints(
                      minWidth: 88.0,
                      minHeight: 36.0), // min sizes for Material buttons
                  // alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      child ?? SizedBox(),
                      SizedBox(
                          // width: 10,
                          ),
                      Text(
                        placeHolder,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: textColor ?? Colors.blue,
                            fontSize: fontSize ?? 16),
                      ),
                    ].reversed.toList(),
                  ),
                ),
        ),
      ),
    );
  }
}
