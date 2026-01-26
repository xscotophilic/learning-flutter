import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final Function resetHandler;

  Result(this.resetHandler, this.totalScore);

  String get resultPhrase {
    String resultText = 'Wow!';
    if (totalScore < 26) {
      resultText = "Pretty Likeble!";
    } else {
      resultText = "Not Bad, Huh!";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              resultPhrase,
              style: TextStyle(fontSize: 30, fontFamily: 'RobotoMono'),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red[400]),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: Text("Restart Quiz!"),
              onPressed: () => resetHandler(),
            ),
          ],
        ),
      ),
    );
  }
}
