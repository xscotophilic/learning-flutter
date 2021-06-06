import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransactionHandler;

  NewTransaction(this.newTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // adding transaction title input controller
  final titleController = TextEditingController();
  // adding transaction title amount controller
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0) return;

    widget.newTransactionHandler(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // *** Input field/ new transaction starts ***
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            // *** Title field starts ***
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
                onSubmitted: (_) => submitData(),
              ),
            ),
            // *** Title field ends ***

            // *** Amount field starts ***
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                ),
                onSubmitted: (_) => submitData(),
              ),
            ),
            // *** Amount field ends ***

            // *** Submit button starts ***
            ElevatedButton(
              onPressed: submitData,
              child: Text(
                'Add transaction',
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).primaryColor,
                ),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
            )
            // *** Submit button ends ***
          ],
        ),
      ),
    );
    // *** Input fields ends ***
  }
}
