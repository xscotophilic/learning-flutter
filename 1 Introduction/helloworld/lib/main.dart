import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello_World',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Hello_World'),
        ),
        body: Center(
          child: Text('Her face a river. This is a curse, a blessing too.'),
        ),
      ),
    );
  }
}
