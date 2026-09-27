import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key, required this.newTransactionHandler});

  final Function newTransactionHandler;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;
  DateTime? _selectedDateController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _amountController = TextEditingController();
  }

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
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text.trim()) ?? 0.0;

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
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            const SizedBox(height: 12),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
              onSubmitted: (_) => _submitData(),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
              onSubmitted: (_) => _submitData(),
            ),
            const SizedBox(height: 8),

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
                const Expanded(child: SizedBox(width: 12)),
                Text(
                  _selectedDateController == null
                      ? ''
                      : 'Picked date: ${DateFormat().add_yMMMMd().format(_selectedDateController!)}',
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: _submitData,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.secondary,
                ),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              child: const Text('Add transaction'),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
