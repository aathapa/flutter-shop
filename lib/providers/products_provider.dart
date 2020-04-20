import 'package:flutter/material.dart';
import 'package:shopify/config/network/network.dart';
import 'package:shopify/models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _productList = [];

  List<Product> get productList => [..._productList];

  List<Product> get favouriteList =>
      _productList.where((product) => product.isFavourites).toList();

  Product findbyId(String id) =>
      _productList.firstWhere((product) => product.id == id);

  Future fetchproducts() async {
    const url = 'https://flutter-api-1f7da.firebaseio.com/product.json';
    final List<Product> loadedProduct = [];
    final Map fetchResponse = await Network.getApi(url);
    if (fetchResponse['error'] == null) {
      final Map<String, dynamic> succesResponse = fetchResponse['response'];
      succesResponse.forEach((productKey, productValue) {
        loadedProduct.add(
          Product(
            id: productKey,
            description: productValue['description'],
            imageUrl: productValue['imageUrl'],
            price: productValue['price'],
            title: productValue['title'],
            isFavourites: productValue['isFavourites'],
          ),
        );
      });
      _productList = loadedProduct;
      notifyListeners();
    }
  }

  Future addProduct(Product product) async {
    const url = 'https://flutter-api-1f7da.firebaseio.com/product.json';
    final response = await Network.postApi(
      url: url,
      body: {
        "title": product.title,
        "description": product.description,
        "imageUrl": product.imageUrl,
        "price": product.price,
        "isFavourites": product.isFavourites,
      },
    );
    if (response['error'] == null) {
      _productList.add(
        Product(
          id: response['name'],
          title: product.title,
          description: product.description,
          imageUrl: product.imageUrl,
          price: product.price,
        ),
      );
      notifyListeners();
    }
    return response;
  }

  void updateProduct(Product updateproductData) async {
    final url =
        'https://flutter-api-1f7da.firebaseio.com/product/${updateproductData.id}.json';
    final index =
        _productList.indexWhere((prod) => prod.id == updateproductData.id);
    if (index >= 0) {
      final response = await Network.updateApi(
        url: url,
        body: {
          "title": updateproductData.title,
          "description": updateproductData.description,
          "imageUrl": updateproductData.imageUrl,
          "price": updateproductData.price,
          "isFavourites": updateproductData.isFavourites,
        },
      );
      _productList[index] = updateproductData;
      notifyListeners();
    }
  }

  void deleteProduct(String id) async {
    final url = 'https://flutter-api-1f7da.firebaseio.com/product/$id.json';
    final resonse = await Network.deleteApi(url);
    if (resonse) {
      _productList.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }

  void toggleFavourites(Product product) {
    product.toggleFav();
    notifyListeners();
  }
}
