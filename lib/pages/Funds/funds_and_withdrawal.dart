import 'package:amaze/components/my_button.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/pages/Books/upload_widgets.dart';
import 'package:amaze/pages/Settings/creators_settings.dart';
import 'package:flutter/material.dart';

class FundsAndWithdrawal extends StatefulWidget {
  const FundsAndWithdrawal({super.key});

  @override
  State<FundsAndWithdrawal> createState() => _FundsAndWithdrawalState();
}

class _FundsAndWithdrawalState extends State<FundsAndWithdrawal> {
  @override
  Widget build(BuildContext context) {
    var widgetWidth = size(context).width * 0.3;

    return Scaffold(
      appBar: BlueAppbar(),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(18.0).copyWith(top: 10, bottom: 40),
            child: Text(
              '${user(context)!.first_name} ${user(context)!.last_name} | Funds & Withdrawal ',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textContainer(text: 'EARNING', centerText: true, width: 110),
              _textContainer(text: "200", centerText: true, width: 150),
              _textContainer(
                text: '\$',
                centerText: true,
              ),
            ],
          ),
          MyButton(
              placeHolder: 'Withdraw',
              textColor: white,
              color: myDarkBlue,
              pressed: () {}),
          MyButton(
              placeHolder: 'Setup Withdrawal Account',
              textColor: white,
              color: Colors.blueGrey[100],
              pressed: () {}),
          Spacer(
            flex: 1,
          ),
          MyButton(
            placeHolder: 'Back',
            pressed: () => {Navigator.pop(context)},
            height: 40,
            widthRatio: 0.4,
            color: Colors.blueGrey[100],
            textColor: Colors.white,
          )
        ]),
      ),
    );
  }

  Widget _textContainer({text, onTap, bool centerText = false, double? width}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(5).copyWith(top: 10, bottom: 10),
        color: Color.fromARGB(43, 108, 193, 254),
        width: width,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            text ?? 'Upload e-book',
            style: TextStyle(color: myDarkBlue),
          ),
        ),
      ),
    );
  }
}
