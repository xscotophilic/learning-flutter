import 'package:flutter/material.dart';

import './const.dart';
import 'screens/home/home_screen.dart';

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
    return MaterialApp(
      title: 'Appetite Assorted',

      // ------- Theme data starts -------
      theme: Constants.lightTheme(context),
      // ------- Theme data ends -------

      home: HomeScreen(), // Home page
    );
  }
}
