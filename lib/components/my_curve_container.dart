import 'package:amaze/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class MyCurveContainer extends StatefulWidget {
  String? pagetitle;
  Widget? curvecontainerwidget1;
  Widget? curvecontainerwidget2;
  Widget? title_widget;
  String? searchHint;
  String? searchString;
  Function(String)? onChanged;
  bool? showSearchButton;
  bool showPageTitle;
  bool isCircular;
  final double height;
  MyCurveContainer({
    Key? key,
    required this.size,
    this.pagetitle,
    this.curvecontainerwidget1,
    this.title_widget,
    this.searchHint,
    this.searchString,
    this.onChanged,
    required this.height,
    this.curvecontainerwidget2,
    this.showSearchButton,
    this.isCircular = true,
    this.showPageTitle = true,
  }) : super(key: key);

  final Size size;

  @override
  State<MyCurveContainer> createState() => _MyCurveContainerState();
}

class _MyCurveContainerState extends State<MyCurveContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(widget.isCircular ? 50 : 0)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: Get.isDarkMode
                  ? [mydarkModeBlue, mydarkModePurple]
                  : [myBlue, myPurple])),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: widget.showPageTitle!
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => {Scaffold.of(context).openDrawer()},
                          icon: Icon(
                            Icons.no_accounts,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.pagetitle ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Spacer(),
                        widget.title_widget ?? SizedBox(),
                        //
                      ],
                    )
                  : SizedBox(),
            ),
            SizedBox(
              height: 0,
            ),

            widget.curvecontainerwidget1 ?? SizedBox(),
            //  showSearchButton==true  ?
            Container(
                width: 30,
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 10, bottom: 10),
                child: widget.showSearchButton == true
                    ? Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          // SvgPicture.asset(
                          //   'assets/svg/menuicon.svg',
                          //   height: 29,
                          // ),
                          Container(
                            width: size(context).width * 0.97,
                            margin: EdgeInsets.only(left: 6),
                            child: TextFormField(
                              onChanged: widget.onChanged,
                              // keyboardType: TextInputType,
                              decoration: InputDecoration(
                                hintText: 'Search ${widget.searchHint}',
                                hintStyle:
                                    TextStyle(color: const Color(0xff626262)),
                                filled: true,
                                fillColor: const Color(0xfff7f7f7),
                                suffixIcon: Container(
                                  color: Color(0xff0BA7F2).withOpacity(0.25),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container()),
            Container(
                padding: EdgeInsets.only(left: 15),
                child: widget.curvecontainerwidget2 ?? SizedBox()),
          ]),
    );
  }
}
