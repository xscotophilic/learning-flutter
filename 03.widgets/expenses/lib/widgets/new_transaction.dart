import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key, required this.newTransactionHandler});

  final Function newTransactionHandler;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // adding transaction title input controller
  final _titleController = TextEditingController();
  // adding transaction amount input controller
  final _amountController = TextEditingController();
  // adding transaction date controller
  DateTime _selectedDateController = DateTime(0);

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDateController = pickedDate;
      });
    });
  }

  void _submitData() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text) ?? 0.0;

    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        _selectedDateController.isBefore(DateTime(2020))) {
      return;
    }

    widget.newTransactionHandler(
      enteredTitle,
      enteredAmount,
      _selectedDateController,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // *** Input field/ new transaction starts ***
    return Card(
      elevation: 0,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            // *** Title field starts ***
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
                onSubmitted: (_) => _submitData(),
              ),
            ),
            // *** Title field ends ***

            // *** Amount field starts ***
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                ),
                onSubmitted: (_) => _submitData(),
              ),
            ),
            // *** Amount field ends ***

            // *** date field starts ***
            Row(
              children: <Widget>[
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    'Choose date',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: _selectedDateController.isAfter(DateTime(2019, 12, 30))
                      ? Text(
                          'Picked date: ${DateFormat().add_yMMMMd().format(_selectedDateController)}',
                        )
                      : Text(''),
                ),
              ],
            ),
            // *** date field ends ***

            // *** Submit button starts ***
            ElevatedButton(
              onPressed: _submitData,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.secondary,
                ),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              child: Text('Add transaction'),
            ),
            // *** Submit button ends ***
          ],
        ),
      ),
    );
    // *** Input fields ends ***
  }
}
