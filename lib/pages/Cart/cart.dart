import 'package:amaze/components/custom_listtile.dart';
import 'package:amaze/components/my_button.dart';
import 'package:amaze/components/noitems_widget.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/book_model.dart';
import 'package:amaze/services/cart_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:iconly/iconly.dart';

class MyCartWidget extends StatefulWidget {
  const MyCartWidget({
    Key? key,
    // required this.imgUrl,
  }) : super(key: key);

  // final List<String> imgUrl;

  @override
  State<MyCartWidget> createState() => _MyCartWidgetState();
}

class _MyCartWidgetState extends State<MyCartWidget> {
  @override
  Widget build(BuildContext context) {
    final CartService cartController = Get.find();

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 35.0, bottom: 80),
          child: ValueListenableBuilder(
              valueListenable: Hive.box('cart').listenable(),
              builder: (context, box, child) {
                return box.length != 0 //if cart is not empty
                    ? ListView.builder(
                        itemCount: box.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(8),
                        //  padding: EdgeInsets.only(top: 10,bottom: 10),
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          final bookJson = box.getAt(index);

                          Map<String, dynamic> myNewMap =
                              Map<String, dynamic>.from(bookJson);
                          BookModel book = BookModel.fromJson(myNewMap);

                          return cartListWidget(book);
                        })
                    : NoItemsWidget();
              }),
        ),
        //the header of the cart
        if (cartController.cartItems.length != 0)
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5).copyWith(),
                    child: MyButton(
                      placeHolder: 'Checkout N${cartController.total}',
                      widthRatio: 0.45,
                      height: 45,
                      textColor: white,
                      isOval: true,
                      pressed: () {
                        // MyNavigate.navigatejustpush(Checkout(), context);
                      },
                      isGradientButton: true,
                      gradientColors: myGradient,
                    ),
                  ),
                  OutlinedButton(
                    // color: myhomepageBlue,
                    // disabledBorderColor: myhomepageLightOrange,
                    // borderSide: BorderSide(color: myhomepageBlue),
                    onPressed: () {
                      cartController.removeAllCourses();
                    },
                    child: Text(
                      'Empty Wishlist',
                      style: TextStyle(color: myDarkBlue),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Padding cartListWidget(BookModel cartItems) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
          // height: 92,
          padding: EdgeInsets.only(left: 4, right: 4, top: 3, bottom: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 50.0,
                  spreadRadius: 2.0,
                ),
              ]),
          child: CustomListTile(
            book: cartItems,
          )),
    );
  }
}
