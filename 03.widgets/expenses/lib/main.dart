// importing libs
import 'package:flutter/material.dart';

import 'home_page.dart';

// main function
void main() {
  runApp(MyApp());
}

// main widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          primary: Colors.indigo,
          secondary: Colors.pinkAccent,
          error: Colors.red,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      home: MyHomePage(),
    );
  }
}
