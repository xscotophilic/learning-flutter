import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz app!'),
        ),
        body: Column(
          children: <Widget>[
            ElevatedButton(onPressed: null, child: Text('Her face a river.'))
          ],
        ),
      ),
    );
  }
}
