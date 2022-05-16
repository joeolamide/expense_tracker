import 'dart:io';
import 'Package:flutter/cupertino.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'Package:expense_tracker/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:flutter/services.dart';

import 'package:expense_tracker/models/transaction.dart';

void main() {
 // WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([
    //DeviceOrientation.portraitUp,
    //DeviceOrientation.portraitDown,
  //]);

  //above code wont allow apps to be in landscape format.

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp()

    : MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Phone',
    //   amount: 125980,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Subscription',
    //   amount: 5000,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date!.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  //create a new function, that allows new transaction in add icon,
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final  dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
      middle:  Text(
          'Expense Tracker',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
            GestureDetector(
              child: Icon(CupertinoIcons.add),
              onTap:() => _startAddNewTransaction(context),
            )
      ],),
    )
        :AppBar(
      title: Center(
        child: Text('Expense Tracker'),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
   final txListWidget = Container(
     height: (MediaQuery.of(context).size.height -
         appBar.preferredSize.height -
         MediaQuery.of(context).padding.top) *
         0.7,
     child: TransactionList(_userTransactions, _deleteTransaction),
   );
   final pageBody = SafeArea(
       child: SingleChildScrollView(
     child: Column(
       //mainAxisAlignment: MainAxisAlignment.start,
       //mainAxisSize: MainAxisSize.min,
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: <Widget>[
         if (isLandscape)
           Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Text('Show Chart',style: Theme.of(context).textTheme.headline6,),
             Switch.adaptive(
               activeColor: Theme.of(context).accentColor,
               value: _showChart,
               onChanged:(val){
                 setState ((){
                   _showChart = val;
                 });
               },
             ),
           ],
         ),
         if (!isLandscape)
           Container(
             height: (MediaQuery.of(context).size.height -
                 appBar.preferredSize.height -
                 MediaQuery.of(context).padding.top) *
                 0.3,
             child: Chart(_recentTransactions),
           ),
         if (isLandscape)  txListWidget,
         _showChart ?
         Container(
           height: (MediaQuery.of(context).size.height -
               appBar.preferredSize.height -
               MediaQuery.of(context).padding.top) *
               0.7,
           child: Chart(_recentTransactions),
         )
             :txListWidget

       ],
     ),
   ),
   );

    return Platform.isIOS ?
    CupertinoPageScaffold(child: pageBody, navigationBar: appBar,)
        : Scaffold(
      appBar: appBar,
      body:pageBody,

      //adding floating button.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
       : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
