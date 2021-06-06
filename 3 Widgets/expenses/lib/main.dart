// importing libs
import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';

// main function
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.pinkAccent,
        fontFamily: 'Roboto',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Lumber',
                  fontSize: 24,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

// MyApp class
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // *** List of transactions starts ***
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't0',
    //   title: 'Biryani',
    //   amount: 7.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'One Dozen Eggs',
    //   amount: 2.75,
    //   date: DateTime.now(),
    // ),
  ];
  // *** List of transactions ends ***

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

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

  void _showAddNewTransaction(BuildContext context) => {
        showModalBottomSheet(
          context: context,
          builder: (_) {
            return GestureDetector(
              onTap: () {},
              child: NewTransaction(_addNewTransaction),
              behavior: HitTestBehavior.opaque,
            );
          },
        ),
      };

  @override
  Widget build(BuildContext context) {
// scaffold app
    return Scaffold(
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
              Chart(_recentTransactions),
              TransactionList(_userTransactions),
              // ***** main screen ends *****
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _showAddNewTransaction(context),
      ),
    );
  }
}
