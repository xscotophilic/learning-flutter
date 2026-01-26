import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './const.dart';
import './providers/products.dart';
import './providers/orders.dart';
import './providers/cart.dart';
import './screens/home/home_screen.dart';
import './screens/product_details/product_details.dart';
import './screens/cart/cart_screen.dart';
import './screens/orders/orders_screen.dart';
import './screens/user_products/user_products.dart';
import './screens/user_products/edit_product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Appetite Assorted',

        // ------- Theme data starts -------
        theme: Constants.lightTheme(context),
        // ------- Theme data ends -------

        home: HomeScreen(), // Home page
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
