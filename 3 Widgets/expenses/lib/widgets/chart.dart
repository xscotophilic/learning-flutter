import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

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
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum,
        };
      },
    );
  }

  double get totalWeekSpeding {
    return groupedTransactionValues.fold(
      0.0,
      (sum, item) => sum + (item['amount'] as double),
    );
  }

  @override
  Widget build(BuildContext context) {
    // *** Chart Starts ***
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map(
                (data) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    data['day'] as String,
                    data['amount'] as double,
                    totalWeekSpeding == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalWeekSpeding,
                  ),
                ),
              )
              .toList(),
        ),
      ),
      elevation: 2,
    );
    // *** Chart ends ***
  }
}
