import 'package:expenses/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// list of transactions
  final List<Transaction> _userTransactions = [];

  /// recent transactions getter
  /// returns transactions from the last 7 days
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final transaction = Transaction(
      id: DateTime.now().toIso8601String(),
      title: title,
      amount: amount,
      date: chosenDate,
    );
    setState(() {
      _userTransactions.add(transaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _showAddNewTransaction() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(newTransactionHandler: _addNewTransaction),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expenses')),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Chart(recentTransactions: _recentTransactions),
              SizedBox(height: 16),
              Expanded(
                child: TransactionList(
                  transactions: _userTransactions.reversed.toList(),
                  deleteTxHandler: _deleteTransaction,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNewTransaction,
        child: Icon(Icons.add),
      ),
    );
  }
}
