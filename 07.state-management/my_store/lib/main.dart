import 'package:flutter/material.dart';
import 'package:my_store/const.dart';
import 'package:my_store/providers/cart.dart';
import 'package:my_store/providers/orders.dart';
import 'package:my_store/providers/products.dart';
import 'package:my_store/screens/cart/cart_screen.dart';
import 'package:my_store/screens/home/home_screen.dart';
import 'package:my_store/screens/orders/orders_screen.dart';
import 'package:my_store/screens/product_details/product_details.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
      ],
      child: MaterialApp(
        title: 'Appetite Assorted',

        // ------- Theme data starts -------
        theme: Constants.lightTheme(context),

        // ------- Theme data ends -------
        home: const HomeScreen(), // Home page
        routes: {
          ProductDetailsScreen.routeName: (ctx) => const ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrdersScreen.routeName: (ctx) => const OrdersScreen(),
        },
      ),
    );
  }
}
