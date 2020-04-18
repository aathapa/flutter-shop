import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/models/product.dart';
import 'package:shopify/screens/product/detail/product_detail_screen.dart';
import 'package:shopify/providers/cart_provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    final cart = Provider.of<CartProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: product.id,
          );
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(product.title),
            leading: IconButton(
              icon: Icon(
                product.isFavourites ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => product.toggleFav(),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                Scaffold.of(context).hideCurrentSnackBar();
                cart.addItemTocart(
                  productId: product.id,
                  price: product.price,
                  title: product.title,
                );
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product added to cart'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      textColor: Colors.yellow,
                      onPressed: () => cart.removeAddedCartItem(product.id),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
