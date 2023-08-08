import 'package:expense_app/widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PERSONAL EXPENSES',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: GoogleFonts.barlow().fontFamily,
        textTheme: TextTheme(
          titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usertransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  final List<Transaction> _usertransaction = [];

  List<Transaction> get _recentTransactions {
    return _usertransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txamount, DateTime chosendate) {
    final newtx = Transaction(
        title: txTitle,
        amount: txamount,
        date: chosendate,
        id: DateTime.now().toString());

    setState(() {
      _usertransaction.add(newtx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text('Personal Expenses'), actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Chart(_recentTransactions),
                TransactionList(_usertransaction, _deleteTransaction)
              ]),
        ));
  }
}
