import 'package:amaze/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  bool inCart = false;

  final _cartBox = Hive.box('cart');
  void addToCart(BookModel item) async {
    final cartBox = await Hive.openBox('cart');
    final cartItem = cartBox.get(item.id);

    if (cartItem != null) {
      cartBox.delete(item.id);
      isInCart(item);
      return;
      // item = BookModel(id: item.id, name: item.name, price: item.price,);
    }
    item.createdAt = DateTime.now().toString();
    await cartBox.put(item.id, item.toJson());
    isInCart(item);
  }

  isInCart(BookModel book) {
    print(book.id);
    if (_cartBox.containsKey(book.id)) {
      return true;
      // setIsInCart(true);
    } else {
      // setIsInCart(false);

      return false;
    }
  }

  setIsInCart(boolValue) {
    inCart = boolValue;
    notifyListeners();
  }
}
