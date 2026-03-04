import 'package:flutter/foundation.dart';

@immutable
class Transaction {
  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  final String id;
  final String title;
  final double amount;
  final DateTime date;
}
