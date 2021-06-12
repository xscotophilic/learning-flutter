import 'package:flutter/material.dart';

import 'package:appetite_assorted/const.dart';
import 'package:appetite_assorted/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appetite Assorted',

      // ------- Theme data starts -------
      theme: Constants.lighTheme(context),
      // ------- Theme data ends -------

      home: HomePage(), // Home page
    );
  }
}
