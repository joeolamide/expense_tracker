import 'package:flutter/material.dart';

//creating the lib for transactions.
//create the class.

class Transaction {
  final String? id;
  final String? title;
  final double? amount;
  final DateTime? date;

  //creating a constructor.

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}
