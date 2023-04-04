import 'dart:convert';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/book_model.dart';
import 'package:amaze/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService extends GetxController {
  var _cartItems = {}.obs;
  late SharedPreferences _prefs;
  @override
  void onInit() async {
    _prefs = await SharedPreferences.getInstance();
    setCartItems();
    super.onInit();
  }

  setCartItems() {
    List<BookModel> cartList = getCart();
    cartList.forEach((element) {
      _cartItems[element] = 1;
    });
    print('_cartItems');
    print(_cartItems);
  }

  List<BookModel> getCart() {
    var cartStringList = _prefs.getStringList('cart') ?? [];
    List<BookModel> cartBookList = cartStringList
        .map((bookString) => BookModel.fromStringJson(bookString))
        .toList();

    print('cartBookList');
    print(cartBookList);
    print(cartStringList);
    return cartBookList;
  }

  void addBook(BookModel cartItem) {
    if (_cartItems.containsKey(cartItem)) {
      Get.snackbar('Item  already in cart',
          'You have added the ${cartItem.title} to the cart ',
          // "You have added a product with ${cartItem.courseType}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: myBlue.withOpacity(0.5),
          colorText: Colors.white,
          duration: Duration(seconds: 1));
    } else {
      // _cartItems[cartItem] = 1;
      _prefs.remove('cart');

      List<BookModel> cartList = getCart();
      cartList.add(cartItem);
      List<String> cartStringList =
          cartList.map((book) => book.toStringJson()).toList();
      _prefs.setStringList('cart', cartStringList);
      update();
      Get.snackbar('Item added to cart',
          'You have added the ${cartItem.title} to the cart ',
          // "You have added a product with ${cartItem.courseType}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: myBlue.withOpacity(0.5),
          colorText: Colors.white,
          duration: Duration(milliseconds: 800));
    }
  }

  void removeBook(BookModel cartItem) {
    if (_cartItems.containsKey(cartItem)) {
      _cartItems.removeWhere((key, value) => key == cartItem);
      Get.snackbar(
          'Item removed', 'You have remove the ${cartItem.title} from cart ',
          // "You have added a product with ${cartItem.courseType}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: myBlue.withOpacity(0.5),
          colorText: Colors.white,
          duration: Duration(milliseconds: 900));
    }
    // update();
  }

  bool isInCart(BookModel cartItem) {
    if (_cartItems.containsKey(cartItem)) {
      return true;
    } else {
      return false;
    }
  }

  void removeAllCourses() {
    _cartItems.clear();
  }

  get cartItems => _cartItems;

  get total => _cartItems.entries
      .map((cartItem) => int.parse(cartItem.key.price))
      .toList()
      .reduce(
        (value, element) => value + element,
      )
      .toString();

  // static void purchaseCourse(cartItems, context) {
  //   for (var i = 0; i < cartItems.length; i++) {
  //     var order_id = generateRandomString(3) + DateTime.now().toIso8601String();
  //     OrderInfo order = OrderInfo(
  //         order_id: order_id,
  //         user_id: cartItems[i].user_id,
  //         current_user_id: user(context).id,
  //         post_id: cartItems[i].post_id!,
  //         orderType: cartItems[i].postType,
  //         current_user_name: user(context).full_name!,
  //         email: user(context).email,
  //         title: cartItems[i].title,
  //         price: cartItems[i].price);
  //     AuthService().postData(order.toJson(), 'payment/orderItem');
  //   }
  // }
}
