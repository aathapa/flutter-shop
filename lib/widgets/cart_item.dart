import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    @required this.id,
    @required this.price,
    @required this.quantity,
    @required this.title,
    @required this.productId,
  });

  final double price;
  final int quantity;
  final String title;
  final String id;
  final String productId;

  @override
  Widget build(BuildContext context) {
    double cartItemPrice = price * quantity;
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('Are you want to $title product from cart ? '),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () => Navigator.of(context).pop(true),
                  )
                ],
              );
            },
          );
        }
      },
      onDismissed: (_) => Provider.of<CartProvider>(context, listen: false)
          .removeCartItem(productId),
      background: Container(
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        padding: EdgeInsets.all(10),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 24.0,
        ),
        color: Theme.of(context).primaryColor,
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: FittedBox(
                child: Text('\$ ${price.toString()}'),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total  \$${cartItemPrice.toString()}'),
          trailing: Text('${quantity.toString()} x'),
        ),
      ),
    );
  }
}
