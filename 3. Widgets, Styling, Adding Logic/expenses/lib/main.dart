import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Expenses'),
        ),
        body: Column(
          children: <Widget>[
            Card(
              child: Container(
                width: double.infinity,
                child: Text('Chart!'),
              ),
              elevation: 5,
            ),
            Card(
              child: Container(
                width: double.infinity,
                // mainAxisAlignment: MainAxisAlignment.center,
                child: Text('List!'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
