import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final Function deleteTxHandler;

  TransactionList(this.transactions, this.deleteTxHandler);

  @override
  Widget build(BuildContext context) {
    // *** Expenses starts ***
    return Container(
      margin: EdgeInsets.all(15),
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionItem(
                    transaction: transactions[index],
                    deleteTxHandler: deleteTxHandler);
              },
              itemCount: transactions.length,
            ),
    );
    // *** Expenses ends ***
  }
}
