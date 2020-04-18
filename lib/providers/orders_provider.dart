import 'package:flutter/foundation.dart';
import 'package:shopify/providers/cart_provider.dart';

class Order {
  Order({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
}

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrders(List<CartItem> cartItem, double totalAmount) {
    _orders.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        amount: totalAmount,
        products: cartItem,
        dateTime: DateTime.now(),
      ),
    );
  }
}
