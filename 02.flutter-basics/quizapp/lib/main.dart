import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

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
  var _totalScore = 0;

  final _questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 9},
        {'text': 'Red', 'score': 9},
        {'text': 'Green', 'score': 7},
        {'text': 'White', 'score': 7},
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 9},
        {'text': 'Snake', 'score': 7},
        {'text': 'Elephant', 'score': 7},
        {'text': 'Lion', 'score': 9},
      ],
    },
    {
      'questionText': 'What\'s your favourite song?',
      'answers': [
        {'text': 'Flightless Bird, American Mouth - Iron & Wine', 'score': 7},
        {'text': 'RIHA by Anuv Jain', 'score': 7},
        {'text': 'Jonathan - would you', 'score': 9},
        {'text': 'Anchor - Novo Amor', 'score': 10},
      ],
    },
  ];

  void _questionAnswerd(int score) {
    this._totalScore += score;
    setState(() {
      this._questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      this._totalScore = 0;
      this._questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz app!'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(_questionAnswerd, _questions, _questionIndex)
            : Result(this._resetQuiz, this._totalScore),
      ),
    );
  }
}
