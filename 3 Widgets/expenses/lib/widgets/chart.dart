import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0.0;

        for (var i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year)
            totalSum += recentTransactions[i].amount;
        }

        return {
          'day': DateFormat.E().format(weekDay),
          'amount': totalSum,
        };
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues.toString());
    // *** Chart Starts ***
    return Card(
      color: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Row(
          children: <Widget>[],
        ),
      ),
      elevation: 2,
    );
    // *** Chart ends ***
  }
}
