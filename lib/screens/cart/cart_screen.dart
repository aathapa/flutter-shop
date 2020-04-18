import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/providers/cart_provider.dart' show CartProvider;
import 'package:shopify/providers/orders_provider.dart';
import 'package:shopify/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final cartProviderData = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$ ${cartProviderData.totalAmount.toString()}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<OrderProvider>(context, listen: false)
                          .addOrders(
                        cartProviderData.cartItem.values.toList(),
                        cartProviderData.totalAmount,
                      );
                      cartProviderData.clearCart();
                    },
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, i) {
                final cartItemData =
                    cartProviderData.cartItem.values.toList()[i];

                return CartItem(
                  id: cartItemData.id,
                  price: cartItemData.price,
                  quantity: cartItemData.quantity,
                  title: cartItemData.title,
                  productId: cartProviderData.cartItem.keys.toList()[i],
                );
              },
              itemCount: cartProviderData.cartItem.length,
            ),
          )
        ],
      ),
    );
  }
}
