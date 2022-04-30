import 'package:flutter/material.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:intl/intl.dart';

class chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var j = 0; j < recentTransactions.length; j++) {
        if (recentTransactions[j].date.day == weekDay.day &&
            recentTransactions[j].date.month == weekDay.month &&
            recentTransactions[j].date.year == weekDay.year) {
          totalSum += recentTransactions[j]amount;
        }
      }

      return {'day': DateFormat.E(weekDay),
        'amount': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}
