import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

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
      _questionIndex = (_questionIndex + 1) % 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    const questions = [
      {
        'questionText': 'What\'s your favorite color?',
        'answers': [
          {'text': 'Black', 'score': 9},
          {'text': 'Red', 'score': 8},
          {'text': 'Green', 'score': 10},
          {'text': 'White', 'score': 7},
        ],
      },
      {
        'questionText': 'What\'s your favorite animal?',
        'answers': [
          {'text': 'Rabbit', 'score': 9},
          {'text': 'Snake', 'score': 8},
          {'text': 'Elephant', 'score': 10},
          {'text': 'Lion', 'score': 8},
        ],
      },
      {
        'questionText': 'What\'s your favourite song?',
        'answers': [
          {'text': 'Flightless Bird, American Mouth - Iron & Wine', 'score': 9},
          {'text': 'RIHA by Anuv Jain', 'score': 9},
          {'text': 'Jonathan - would you', 'score': 9},
          {'text': 'Anchor - Novo Amor', 'score': 10},
        ],
      },
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz app!'),
        ),
        body: Column(
          children: <Widget>[
            Question(
              questions[_questionIndex]['questionText'] as String,
            ),
            ...(questions[_questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map((answer) =>
                    Answer(answer['text'] as String, _questionAnswerd))
                .toList()
          ],
        ),
      ),
    );
  }
}
