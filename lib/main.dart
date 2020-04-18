import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/providers/cart_provider.dart';
import 'package:shopify/providers/orders_provider.dart';
import 'package:shopify/providers/products_provider.dart';
import 'package:shopify/screens/cart/cart_screen.dart';
import 'package:shopify/screens/order/order_screen.dart';
import 'package:shopify/screens/product/detail/product_detail_screen.dart';
import 'package:shopify/screens/product/edit_product/edit_product_screen.dart';
import 'package:shopify/screens/product/manage/product_manage_screen.dart';
import 'package:shopify/screens/product/overview/product_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        initialRoute: "/",
        routes: {
          "/": (ctx) => ProductOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          ProductManageScreen.routeName: (ctx) => ProductManageScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen()
        },
      ),
    );
  }
}
