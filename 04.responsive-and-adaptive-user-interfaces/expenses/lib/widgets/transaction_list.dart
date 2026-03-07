import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    required this.transactions,
    required this.deleteTxHandler,
  });

  final List<Transaction> transactions;
  final Function deleteTxHandler;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return LayoutBuilder(
        builder: (ctx, constraints) {
          return Center(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                const SizedBox(height: 16),
                Image.asset(
                  'assets/images/waiting.png',
                  height: constraints.maxHeight * 0.2,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(height: 16),
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      );
    } else {
      return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final transaction = transactions[index];
          return Card(
            key: ValueKey(transaction.id),
            elevation: 1,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
            child: ListTile(
              leading: CircleAvatar(
                radius: 32,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: FittedBox(
                    child: Text('\$ ${transaction.amount.toStringAsFixed(2)}'),
                  ),
                ),
              ),
              title: Text(
                transaction.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(DateFormat.yMMMMd().format(transaction.date)),
              trailing: IconButton(
                onPressed: () => deleteTxHandler(transaction.id),
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          );
        },
      );
    }
  }
}
