import 'package:flutter/material.dart';

import 'package:quizapp/home_content.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Quiz app!')),
        body: const SafeArea(
          child: HomeContent(assessmentData: _assessmentData),
        ),
      ),
    );
  }
}

const List<Map<String, Object>> _assessmentData = [
  {
    'questionText': 'What\'s your favorite color?',
    'answers': [
      {'text': 'Black', 'score': 9},
      {'text': 'Red', 'score': 7},
      {'text': 'Green', 'score': 8},
      {'text': 'White', 'score': 3},
    ],
  },
  {
    'questionText': 'Choose your fighter',
    'answers': [
      {'text': 'Overthinking brain', 'score': 4},
      {'text': 'Pure luck', 'score': 10},
      {'text': 'Coffee addiction', 'score': 8},
      {'text': 'Doing nothing and hoping it works', 'score': 6},
    ],
  },
  {
    'questionText': 'Choose a completely useless skill',
    'answers': [
      {'text': 'Remembering random lyrics', 'score': 5},
      {'text': 'Overthinking fake scenarios', 'score': 7},
      {'text': 'Opening apps and forgetting why', 'score': 8},
      {'text': 'Walking into rooms and blanking', 'score': 9},
    ],
  },
];
