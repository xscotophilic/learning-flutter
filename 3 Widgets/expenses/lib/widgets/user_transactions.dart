import 'package:flutter/material.dart';

import '../models/transaction.dart';

import './new_transaction.dart';
import './transaction_list.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  // *** List of transactions starts ***
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't0',
      title: 'Biryani',
      amount: 7.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'One Dozen Eggs',
      amount: 2.75,
      date: DateTime.now(),
    ),
  ];
  // *** List of transactions ends ***

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
