import 'package:flutter/material.dart';
import 'package:shopify/screens/order/order_screen.dart';
import 'package:shopify/screens/product/manage/product_manage_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Shop'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed("/"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrderScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Manage Product'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ProductManageScreen.routeName),
          ),
        ],
      ),
    );
  }
}
