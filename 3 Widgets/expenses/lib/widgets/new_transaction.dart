import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  // adding transaction title input controller
  final titleController = TextEditingController();
  // adding transaction title amount controller
  final amountController = TextEditingController();

  final Function newTransactionHandler;

  NewTransaction(this.newTransactionHandler);

  @override
  Widget build(BuildContext context) {
    // *** Input field/ new transaction starts ***
    return Card(
      elevation: 5,
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
              ),
            ),
            // *** Amount field ends ***

            // *** Submit button starts ***
            ElevatedButton(
              onPressed: () => {
                newTransactionHandler(
                  titleController.text,
                  double.parse(amountController.text),
                ),
              },
              child: Text(
                'Add transaction',
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple),
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
