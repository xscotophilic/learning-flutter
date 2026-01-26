import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTxHandler,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTxHandler;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$ ${transaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(
            transaction.date,
          ),
        ),
        trailing: IconButton(
          onPressed: () => deleteTxHandler(transaction.id),
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }
}
