import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_blue_store/screens/home/home_screen.dart';

import './const.dart';
import './providers/auth.dart';
import './providers/products.dart';
import './providers/orders.dart';
import './providers/cart.dart';
import './screens/product_details/product_details.dart';
import './screens/cart/cart_screen.dart';
import './screens/orders/orders_screen.dart';
import './screens/user_products/user_products.dart';
import './screens/user_products/edit_product_screen.dart';
import './screens/auth_screen/auth_screen.dart';

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
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (context, auth, previousProducts) => Products()
            ..update(
              auth.token,
              auth.userID,
              previousProducts == null ? [] : previousProducts.items,
            ),
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (context, auth, previousOrders) => Orders()
            ..update(auth.token,
                previousOrders == null ? [] : previousOrders.orders),
          create: (_) => Orders(),
        ),
        // Orders
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Appetite Assorted',

          // ------- Theme data starts -------
          theme: Constants.lightTheme(context),
          // ------- Theme data ends -------

          home: auth.isAuth ? HomeScreen() : AuthScreen(), // Home page
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
