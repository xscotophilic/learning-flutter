import 'package:flutter/material.dart';

import './question.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  // Or use below code to create a state
  // State<StatefulWidget> createState() {
  //   return _MyAppState();
  // }
}

class _MyAppState extends State<MyApp> {
  // State<MyApp> pointer tells MyApp that this state is for MyApp widget
  var _questionIndex = 0;

  void _questionAnswerd() {
    setState(() {
      _questionIndex = (_questionIndex + 1)%3;      
    });
  }

  @override
  Widget build(BuildContext context) {
    const questions = [
      'What\'s your favorite color?',
      'What\'s your favorite animal?',
      'What\'s your favorite food?'
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz app!'),
        ),
        body: Column(
          children: <Widget>[
            Question(questions[_questionIndex]),
            ElevatedButton(
              onPressed: _questionAnswerd,
              child: Text('Her face a river.'),
            ),
            ElevatedButton(
              onPressed: _questionAnswerd,
              child: Text('This is a curse,'),
            ),
            ElevatedButton(
              onPressed: _questionAnswerd,
              child: Text('A blessing too.'),
            ),
          ],
        ),
      ),
    );
  }
}
