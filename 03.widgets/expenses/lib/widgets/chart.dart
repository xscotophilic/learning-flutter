import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransactions});

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get _groupedTransactionValues {
    return List.generate(7, (index) {
      double totalSum = 0.0;

      final weekDay = DateTime.now().subtract(Duration(days: index));
      for (var i = 0; i < recentTransactions.length; i++) {
        final txDate = recentTransactions[i].date;

        if (txDate.day == weekDay.day &&
            txDate.month == weekDay.month &&
            txDate.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get _totalWeekSpeding {
    return _groupedTransactionValues.fold(
      0.0,
      (sum, item) => sum + (item['amount'] as double),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(12),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactionValues.map((data) {
            final day = data['day'] as String;
            final amount = data['amount'] as double;

            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: day,
                spendingAmount: amount,
                spendingPctOfTotal: _totalWeekSpeding == 0.0
                    ? 0.0
                    : amount / _totalWeekSpeding,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
