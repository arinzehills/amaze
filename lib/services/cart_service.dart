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
    // _prefs.remove('cart');
    // setCartItems();
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

  getCart() {
    // var cartStringList = _prefs.getStringList('cart') ?? [];
    // List<BookModel> cartBookList = cartStringList
    //     .map((bookString) => BookModel.fromStringJson(bookString))
    //     .toList();

    // return cartBookList;
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
}
