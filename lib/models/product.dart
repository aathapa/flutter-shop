import 'package:flutter/foundation.dart';

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
    this.isFavourites = !this.isFavourites;
    notifyListeners();
  }
}
