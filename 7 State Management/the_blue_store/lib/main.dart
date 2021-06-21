import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products.dart';
import './const.dart';
import './screens/product_details/product_details.dart';
import './screens/home/home_screen.dart';

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
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        title: 'Appetite Assorted',

        // ------- Theme data starts -------
        theme: Constants.lightTheme(context),
        // ------- Theme data ends -------

        home: HomeScreen(), // Home page
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
        },
      ),
    );
  }
}
