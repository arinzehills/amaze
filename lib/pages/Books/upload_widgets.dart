import 'package:amaze/components/my_button.dart';
import 'package:amaze/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Padding creatorsSettingsPagetitle(BuildContext context, {title}) {
  return Padding(
    padding: const EdgeInsets.all(18.0).copyWith(top: 10, bottom: 30),
    child: Text(
      '${user(context)!.first_name} ${user(context)!.last_name} |${title ?? " Funds & Withdrawal "}',
      style: TextStyle(color: Colors.grey),
    ),
  );
}

Widget uploadWidget(
    {text, text2, onTap, bool centerText = false, width, color}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.all(12).copyWith(top: 15, bottom: 0),
      color: color ?? Color.fromARGB(43, 108, 193, 254),
      width: width ?? double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: centerText
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text ?? 'Upload e-book',
            style: TextStyle(color: myDarkBlue, fontSize: 16),
          ),
          text2 != null
              ? Text(
                  text2,
                  style: TextStyle(color: Colors.grey),
                )
              : SizedBox(),
        ],
      ),
    ),
  );
}

addTextField(context,
    {onChanged, maxLines, bool withBorder = false, width, hintText, ctrl}) {
  return Container(
    width: width ?? size(context).width * 0.47,
    decoration: BoxDecoration(
      color: Colors.white60,
      border: withBorder ? Border.all(color: myBlue) : null,
    ),
    height: 50,
    child: TextFormField(
      validator: (val) => val!.isEmpty ? 'Enter Choice' : null,
      maxLines: maxLines ?? 1,
      controller: ctrl,
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 0.2),
        hintText: hintText ?? 'Choice',
        hintStyle: TextStyle(
          fontSize: 14,
        ),
        border: InputBorder.none,
      ),
      onChanged: onChanged,
    ),
  );
}

Widget uploadTextField(
    {hintText,
    text2,
    onChanged,
    cntrl,
    bool withBorder = false,
    maxLines,
    bool willValidate = true}) {
  return Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: withBorder ? Colors.white60 : Color.fromARGB(43, 108, 193, 254),
      border: withBorder ? Border.all(color: myBlue) : null,
    ),
    margin: EdgeInsets.all(12).copyWith(top: 0, bottom: 10),
    child: TextFormField(
      validator: willValidate
          ? (val) => val!.isEmpty ? 'Please Enter a value' : null
          : null,
      controller: cntrl,
      maxLines: maxLines,
      style:
          TextStyle(height: 1, color: Get.isDarkMode ? Colors.grey[700] : null),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: myDarkBlue, fontSize: 15),
        suffixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (text2 is String)
                ? Text(
                    text2,
                    style: TextStyle(color: Colors.grey),
                  )
                : text2 ?? SizedBox()
          ],
        ),
        border: InputBorder.none,
      ),
      // hintStyle: TextStyle(color: myBlue)

      onChanged: onChanged,
    ),
  );
}

Widget popUpload({child}) => Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      color: Color(0xffD8EFFF),
      child: child,
    );
Widget addAbn() {
  return popUpload(
      child: Column(
    children: [
      MyButton(
        placeHolder: 'Add (Default)',
        color: myDarkBlue,
        widthRatio: 0.7,
        pressed: () {},
        textColor: white,
      ),
      SizedBox(
        height: 10,
      ),
      MyButton(
        placeHolder: 'Add your ISBN',
        widthRatio: 0.7,
        color: myDarkBlue,
        pressed: () {},
        textColor: white,
      ),
    ],
  ));
}

Widget addToSeries() {
  return popUpload(
      child: Column(
    children: [
      Text(
        'ADD BOOK TO SERIES',
        style: TextStyle(color: myDarkBlue),
      ),
      SizedBox(
        height: 10,
      ),
      MyButton(
        placeHolder: 'Create new series',
        color: myDarkBlue,
        widthRatio: 0.7,
        pressed: () {},
        textColor: white,
      ),
      SizedBox(
        height: 10,
      ),
      MyButton(
        placeHolder: 'Add to Existing series',
        widthRatio: 0.7,
        color: myDarkBlue,
        pressed: () {},
        textColor: white,
      ),
    ],
  ));
}

// for second page info uploads
Future languageList(
  context, {
  onTap,
  required List list,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              // constraints: BoxConstraints(maxHeight: 200),
              height: size(context).height * 0.64,
              child: popUpload(
                  child: Padding(
                padding:
                    const EdgeInsets.all(8.0).copyWith(right: 30, left: 30),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return UnconstrainedBox(
                        child: GestureDetector(
                          onTap: () => onTap(list[index]),
                          child: Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(10),
                            width: 150,
                            color: myDarkBlue,
                            child: Text(
                              list[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(color: white, fontSize: 14),
                            ),
                          ),
                        ),
                      );
                    }),
              )),
            ),
          ),
        );
      });
}

Widget adultContent({onTap, bool adult_content = false}) {
  print(adult_content);
  return popUpload(
    child: GestureDetector(
      onDoubleTap: () {
        onTap(!adult_content);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Adult Content',
                style: TextStyle(color: myDarkBlue, fontSize: 16)),
            Wrap(
              spacing: 18,
              children: [
                GestureDetector(
                  onTap: () {
                    onTap(true);
                  },
                  child: Row(
                    children: [
                      Text('Yes',
                          style: TextStyle(color: myDarkBlue, fontSize: 16)),
                      Icon(
                        adult_content == true
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off_rounded,
                        color: white,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onTap(false);
                  },
                  child: Row(
                    children: [
                      Text('No',
                          style: TextStyle(color: myDarkBlue, fontSize: 16)),
                      Icon(
                        adult_content != true
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off_rounded,
                        color: white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget priceWidget(context) {
  Widget selectRegion() => Row(
        children: [
          Text('Convert for all region'),
          Checkbox(
            checkColor: Colors.blue,
            activeColor: Colors.white,
            value: true,
            onChanged: (val) {},
          ),
        ],
      );
  return Container(
    height: 150,
    child: popUpload(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(TextSpan(
                text: 'Default Currency:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                children: <InlineSpan>[
                  TextSpan(
                    text: ' Naira(#)',
                    style: TextStyle(color: myDarkBlue),
                  )
                ])),
            Icon(
              Icons.cancel_presentation_rounded,
              color: Colors.grey,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              // crossAxisAlignment: Cross,
              children: [
                addTextField(
                  context,
                  onChanged: (val) {},
                  width: 50.0,
                ),
                Text(
                  '  #',
                  style: TextStyle(color: myDarkBlue),
                )
              ],
            ),
            selectRegion(),
          ],
        )
      ],
    )),
  );
}

Widget addRange(context, {onClick}) {
  final cntl = TextEditingController();
  String min = '', max = '';
  return Container(
    height: 155,
    child: popUpload(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Only Applies in children books',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Icon(
              Icons.cancel_presentation_rounded,
              color: Colors.grey,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              // crossAxisAlignment: Cross,
              children: [
                Text(
                  'Minimum',
                  style: TextStyle(color: myDarkBlue),
                ),
                SizedBox(
                  width: 10,
                ),
                addTextField(
                  context,
                  hintText: '6',
                  onChanged: (val) {
                    min = val;
                  },
                  width: 50.0,
                ),
              ],
            ),
            Row(
              // crossAxisAlignment: Cross,
              children: [
                Text(
                  'Maximum ',
                  style: TextStyle(color: myDarkBlue),
                ),
                SizedBox(
                  width: 10,
                ),
                addTextField(
                  context,
                  hintText: '12+',
                  onChanged: (val) {
                    max = val;
                  },
                  width: 50.0,
                ),
              ],
            ),
          ],
        ),
        MyButton(
            placeHolder: 'Ok',
            height: 30,
            color: white,
            // isDisable: min == '' && max == '' ? true : false,
            widthRatio: 0.23,
            pressed: () {
              onClick('${min}-${max}');
            })
      ],
    )),
  );
}
