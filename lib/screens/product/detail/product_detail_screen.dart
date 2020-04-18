import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static final String routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productIds = ModalRoute.of(context).settings.arguments as String;
    final productItem = Provider.of<ProductProvider>(
      context,
      listen: false,
    ).findbyId(productIds);

    return Scaffold(
      appBar: AppBar(
        title: Text(productItem.title),
      ),
      body: Center(
        child: Text('Detail'),
      ),
    );
  }
}
