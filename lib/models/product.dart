import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:shopify/config/network/network.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String description;
  bool isFavourites;

  Product({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.imageUrl,
    @required this.description,
    this.isFavourites = false,
  });

  void toggleFav() {
    final url = 'https://flutter-api-1f7da.firebaseio.com/product/$id.json';
    Network.updateApi(url: url, body: {"isFavourites": !isFavourites});
    isFavourites = !isFavourites;
    notifyListeners();
  }
}
