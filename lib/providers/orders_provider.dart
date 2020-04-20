import 'package:flutter/foundation.dart';
import 'package:shopify/config/network/network.dart';
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
  Future fetchOrders() async {
    const url = 'https://flutter-api-1f7da.firebaseio.com/orders.json';
    final List<Order> loadedOrders = [];
    var fetchResponse = await Network.getApi(url);

    if (fetchResponse['response'] == null) {
      return;
    }

    (fetchResponse['response'] as Map<String, dynamic>)
        .forEach((orderKey, orderValue) {
      loadedOrders.add(
        Order(
          id: orderKey,
          amount: orderValue['amount'],
          products: (orderValue['products'] as List<dynamic>)
              .map(
                (item) => CartItem.fromJson(item),
              )
              .toList(),
          dateTime: DateTime.parse(
            orderValue['dateTime'],
          ),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  void addOrders(List<CartItem> cartItem, double totalAmount) async {
    const url = 'https://flutter-api-1f7da.firebaseio.com/orders.json';
    final timestamp = DateTime.now();
    var response = await Network.postApi(
      url: url,
      body: {
        "amount": totalAmount,
        "dateTime": timestamp.toIso8601String(),
        "products": cartItem
            .map(
              (cart) => {
                "id": cart.id,
                "price": cart.price,
                "quantity": cart.quantity,
                "title": cart.title,
              },
            )
            .toList()
      },
    );
    print(response);
    _orders.insert(
      0,
      Order(
        id: response['name'],
        amount: totalAmount,
        products: cartItem,
        dateTime: DateTime.now(),
      ),
    );
  }
}
