// importing libs
import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/user_transactions.dart';

// main function
void main() {
  runApp(MyApp());
}

// MyApp class
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // material app
    return MaterialApp(
      // scaffold app
      home: Scaffold(
        appBar: AppBar(
          title: Text('Expenses'),
        ),
        // outer container for styling
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            // column to hold chart and expenses list
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // ***** main screen starts *****
                Chart(),
                UserTransactions(),
                // ***** main screen ends *****
              ],
            ),
          ),
        ),
      ),
    );
  }
}
