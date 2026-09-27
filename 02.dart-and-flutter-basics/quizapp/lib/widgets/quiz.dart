import 'package:flutter/material.dart';
import 'package:quizapp/widgets/answer.dart';
import 'package:quizapp/widgets/question.dart';

class Quiz extends StatelessWidget {
  const Quiz({
    super.key,
    required this.questions,
    required this.questionAnswerd,
    required this.questionIndex,
  });

  final List<Map<String, Object>> questions;
  final ValueChanged<int> questionAnswerd;
  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    final String questionText =
        questions[questionIndex]['questionText'] as String;
    final List<Map<String, Object>> answers =
        questions[questionIndex]['answers'] as List<Map<String, Object>>;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Question(questionText: questionText),
        for (final Map<String, Object> answer in answers)
          Answer(
            questionAnswerd: () => questionAnswerd(answer['score'] as int),
            answerText: answer['text'] as String,
          ),
      ],
    );
  }
}
