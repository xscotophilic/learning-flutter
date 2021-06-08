// importing libs
import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';

// main function
void main() {
  // ******* Allowing only Potrait mode starts *******

  // -x- Put the import in the beginning of code. -x-
  // import 'package:flutter/services.dart';

  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  // ******* Allowing only Potrait mode ends *******

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
        errorColor: Colors.red,
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
  final List<Transaction> _userTransactions = [];
  // *** List of transactions ends ***

  bool _showChart = false;

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

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
          ),
        ),
      };

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Expenses'),
    );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        _userTransactions.reversed.toList(),
        _deleteTransaction,
      ),
    );

    // scaffold app
    return Scaffold(
      appBar: appBar,
      // outer container for styling
      body: SingleChildScrollView(
        child: Container(
          // column to hold chart and expenses list
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // ********** main screen starts **********
              // If landscape then show swich
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Show Chart!'),
                    Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      },
                    ),
                  ],
                ),
              // If landscape then show chart and tx based on switch
              if (isLandscape)
                _showChart
                    ?
                    // ----- Chart starts -----
                    Container(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.7,
                        child: Chart(_recentTransactions),
                      )
                    // ----- Chart ends -----
                    // ----- TransactionList starts -----
                    : txListWidget, // ----- TransactionList ends -----

              // If potrait then show chart and tx without switch
              if (!isLandscape)
                // ----- Chart starts -----
                Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentTransactions),
                ), // ----- Chart ends -----
              if (!isLandscape) txListWidget,

              // ********** main screen ends **********
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
