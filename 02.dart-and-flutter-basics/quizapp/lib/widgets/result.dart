import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({
    super.key,
    required this.totalScore,
    required this.resetHandler,
  });

  final int totalScore;
  final VoidCallback resetHandler;

  String get _resultPhrase {
    if (totalScore < 21) {
      return 'Not bad at all!';
    } else if (totalScore < 26) {
      return 'Pretty impressive!';
    } else {
      return 'Crushed it!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text("Score: $totalScore/30", style: const TextStyle(fontSize: 16)),
            Text(_resultPhrase, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Colors.blueAccent[400],
                  ),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                onPressed: resetHandler,
                child: const Text("Restart Quiz!"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
