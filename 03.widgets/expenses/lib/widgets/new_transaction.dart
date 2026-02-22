import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key, required this.newTransactionHandler});

  final Function newTransactionHandler;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDateController;

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
      firstDate: DateTime(2000),
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
        _selectedDateController == null) {
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
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            // *** Title field starts ***
            Container(
              padding: EdgeInsets.only(bottom: 12),
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
              padding: EdgeInsets.only(bottom: 4),
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
                    _selectedDateController == null
                        ? 'Choose date'
                        : 'Change date',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(child: SizedBox(width: 12)),
                Text(
                  _selectedDateController == null
                      ? ''
                      : 'Picked date: ${DateFormat().add_yMMMMd().format(_selectedDateController!)}',
                  textAlign: TextAlign.right,
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
