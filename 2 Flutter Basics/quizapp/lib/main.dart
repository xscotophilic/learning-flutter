import 'package:flutter/material.dart';

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
  var questionIndex = 0;

  void questionAnswerd() {
    setState(() {
      questionIndex = (questionIndex + 1)%3;      
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
            Text(questions[questionIndex]),
            ElevatedButton(
              onPressed: questionAnswerd,
              child: Text('Her face a river.'),
            ),
            ElevatedButton(
              onPressed: questionAnswerd,
              child: Text('This is a curse,'),
            ),
            ElevatedButton(
              onPressed: questionAnswerd,
              child: Text('A blessing too.'),
            ),
          ],
        ),
      ),
    );
  }
}
