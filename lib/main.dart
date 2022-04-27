import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'Package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/user_transaction.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/transaction.dart';

void main() {
  runApp(
    MaterialApp(
      home: TrackerApp(),
    ),
  );
}

class TrackerApp extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Expense Tracker'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 45,
            child: Card(
              color: Colors.blue,
              child: Text('CHART!'),
              elevation: 5,
            ),
          ),
          UserTransaction(),
        ],
      ),
    );
  }
}
