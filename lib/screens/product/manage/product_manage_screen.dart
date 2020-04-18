import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/providers/products_provider.dart';
import 'package:shopify/screens/product/edit_product/edit_product_screen.dart';
import 'package:shopify/widgets/app_drawer.dart';

class ProductManageScreen extends StatelessWidget {
  static const routeName = '/product-manage';
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: ListView.builder(
          itemCount: product.productList.length,
          itemBuilder: (_, i) {
            final productItem = product.productList[i];
            return Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(productItem.imageUrl),
                  ),
                  title: Text(productItem.title),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () => Navigator.of(context).pushNamed(
                            EditProductScreen.routeName,
                            arguments: productItem.id,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () => Provider.of<ProductProvider>(context,
                                  listen: false)
                              .deleteProduct(productItem.id),
                        )
                      ],
                    ),
                  ),
                ),
                Divider()
              ],
            );
          },
        ),
      ),
    );
  }
}
