import 'package:flutter/material.dart';

import 'widgets/quiz.dart';
import 'widgets/result.dart';

/// This widget provides the main content of the application.
/// It is a stateful widget that keeps track of the current question index and the total score.
/// We need to use stateful widget because we need to update the UI when the user answers a question.
class HomeContent extends StatefulWidget {
  const HomeContent({super.key, required this.assessmentData});

  final List<Map<String, Object>> assessmentData;

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  // State<Home> pointer tells Home that this state is for Home widget
  // SetState is a function that tells Flutter to rebuild the widget

  int _questionIndex = 0;
  int _totalScore = 0;

  void _questionAnswerd(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _totalScore = 0;
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_questionIndex < widget.assessmentData.length) {
      return Quiz(
        questions: widget.assessmentData,
        questionAnswerd: _questionAnswerd,
        questionIndex: _questionIndex,
      );
    } else {
      return Result(totalScore: _totalScore, resetHandler: _resetQuiz);
    }
  }
}
