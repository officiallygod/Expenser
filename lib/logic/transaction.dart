import 'package:flutter/cupertino.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date; // The Date on which transaction is made
  final bool transactionType; // 0 is Debit and 1 is Credit

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
    @required this.transactionType,
  });
}
