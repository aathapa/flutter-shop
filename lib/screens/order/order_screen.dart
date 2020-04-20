import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopify/widgets/app_drawer.dart';
import 'package:shopify/providers/orders_provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future:
            Provider.of<OrderProvider>(context, listen: false).fetchOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.error != null) {
            return Center(
              child: Text('Error !!'),
            );
          }
          return Consumer<OrderProvider>(
            builder: (ctx, orderData, ch) {
              return ListView.builder(
                itemBuilder: (context, i) {
                  return OrderItem(order: orderData.orders[i]);
                },
                itemCount: orderData.orders.length,
              );
            },
          );
        },
      ),
    );
  }
}

class OrderItem extends StatefulWidget {
  const OrderItem({
    @required this.order,
  });

  final Order order;

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              widget.order.amount.toString(),
              style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
            ),
          ),
          if (_isExpanded)
            Container(
              height: math.min(widget.order.products.length * 20.0 + 10, 180),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: ListView(
                children: widget.order.products.map((product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text('${product.quantity} * ${product.price}')
                    ],
                  );
                }).toList(),
              ),
            )
        ],
      ),
    );
  }
}
