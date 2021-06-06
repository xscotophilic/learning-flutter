import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // *** Chart Starts ***
    return Card(
      color: Colors.purple,
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Text(
          'Chart!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      elevation: 2,
    );
    // *** Chart ends ***
  }
}
