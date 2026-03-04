import 'dart:io';

import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/new_transaction.dart';
import 'package:expenses/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  /// list of transactions
  final List<Transaction> _userTransactions = [];

  /// recent transactions getter
  /// returns transactions from the last 7 days
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
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
    showModalBottomSheet<void>(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(newTransactionHandler: _addNewTransaction),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
    );
  }

  ObstructingPreferredSizeWidget _buildIosNavBar() {
    return CupertinoNavigationBar(
      middle: const Text('Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: const Icon(CupertinoIcons.add),
            onTap: () => _showAddNewTransaction(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAndroidAppBar() {
    return AppBar(title: const Text('Expenses'));
  }

  Widget _buildChartSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Show Chart!', style: Theme.of(context).textTheme.titleLarge),
        Switch.adaptive(
          value: _showChart,
          onChanged: (updatedValue) {
            setState(() {
              _showChart = updatedValue;
            });
          },
          trackColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            if (isLandscape) ...[
              _buildChartSwitch(),
              const SizedBox(height: 16),
              if (_showChart) ...[
                Chart(recentTransactions: _recentTransactions),
              ] else ...[
                Expanded(
                  child: TransactionList(
                    transactions: _userTransactions.reversed.toList(),
                    deleteTxHandler: _deleteTransaction,
                  ),
                ),
              ],
            ] else ...[
              Chart(recentTransactions: _recentTransactions),
              const SizedBox(height: 16),
              Expanded(
                child: TransactionList(
                  transactions: _userTransactions.reversed.toList(),
                  deleteTxHandler: _deleteTransaction,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: _buildIosNavBar(),
        child: _buildBody(),
      );
    }
    return Scaffold(
      appBar: _buildAndroidAppBar(),
      body: _buildBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNewTransaction,
        child: const Icon(Icons.add),
      ),
    );
  }
}
