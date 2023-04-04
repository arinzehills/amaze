import 'package:flutter/material.dart';

class NoAccount extends StatelessWidget {
  String title;
  String? subtitle;
  Function()? pressed;
  NoAccount({required this.title, this.pressed, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,
            style: TextStyle(
              color: Colors.grey,
            )),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
            onTap: pressed,
            child: Text(
              subtitle ?? '',
              style: const TextStyle(fontSize: 18),
            ))
      ],
    );
  }
}
