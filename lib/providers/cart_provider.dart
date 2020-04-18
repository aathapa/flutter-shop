import 'package:flutter/material.dart';

class CartItem {
  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });

  final String id;
  final double price;
  final String title;
  int quantity;
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _cartItemData = {};

  Map<String, CartItem> get cartItem => {..._cartItemData};

  int get totalCartLength => _cartItemData.length;

  double get totalAmount {
    double totalAmount = 0.0;
    _cartItemData.values.forEach(
      (cart) => totalAmount += cart.price * cart.quantity,
    );

    return totalAmount;
  }

  void addItemTocart({String productId, String title, double price}) {
    if (_cartItemData.containsKey(productId)) {
      _cartItemData.update(
        productId,
        (existingCartValue) => CartItem(
          id: existingCartValue.id,
          quantity: existingCartValue.quantity + 1,
          title: title,
          price: price,
        ),
      );
    } else {
      _cartItemData.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          title: title,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeCartItem(String productId) {
    _cartItemData.remove(productId);
    notifyListeners();
  }

  void removeAddedCartItem(String productId) {
    if (_cartItemData.containsKey(productId)) {
      if (_cartItemData[productId].quantity == 1) {
        _cartItemData.remove(productId);
      } else {
        _cartItemData.update(
          productId,
          (existingCartValue) => CartItem(
            id: existingCartValue.id,
            price: existingCartValue.price,
            quantity: existingCartValue.quantity - 1,
            title: existingCartValue.title,
          ),
        );
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItemData = {};
    notifyListeners();
  }
}
