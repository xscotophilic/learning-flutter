import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Function questionAnswerd;

  Answer(this.questionAnswerd, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red[400]),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: () => questionAnswerd(),
        child: Text(answerText),
      ),
    );
  }
}
