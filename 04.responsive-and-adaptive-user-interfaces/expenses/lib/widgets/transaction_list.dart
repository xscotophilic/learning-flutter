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
      return ListView(
        children: <Widget>[
          const SizedBox(height: 16),
          Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.scaleDown,
            height: 100,
          ),
          const SizedBox(height: 16),
          Text(
            'No transactions added yet!',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return Card(
            key: ValueKey(transactions[index].id),
            elevation: 1,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
            child: ListTile(
              leading: CircleAvatar(
                radius: 32,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: FittedBox(
                    child: Text(
                      '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                    ),
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                DateFormat.yMMMMd().format(transactions[index].date),
              ),
              trailing: IconButton(
                onPressed: () => deleteTxHandler(transactions[index].id),
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
