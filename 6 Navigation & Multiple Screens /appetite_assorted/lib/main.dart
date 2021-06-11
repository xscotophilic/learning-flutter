import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appetite Assorted',
      theme: ThemeData(
        fontFamily: 'ArtifexCF',
        primaryColor: Color(0xFFe99131),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                fontSize: 22.0,
              ),
              headline6: TextStyle(
                fontSize: 18.0,
              ),
              bodyText1: TextStyle(
                fontSize: 14.0,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'VisiaPro',
                  fontSize: 24,
                ),
              ),
        ),
      ),
      home: MyHomePage(title: 'Appetite Assorted'), // Home page
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appetite Assorted'),
      ),
      body: Center(
        child: Text(
          'Navigation Time!',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
