import './widget/new_transaction.dart';
import './model/transaction.dart';
import './widget/transaction_list.dart';
import 'package:flutter/material.dart';
import './widget/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Personal Expense',
        home: MyHomePage(),
        theme: ThemeData(
            accentColor: Colors.blueGrey,
            primarySwatch: Colors.purple,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'QuickSand',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                  button: TextStyle(
                    color: Colors.white,
                  ),
                ),
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)))));
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
    //   title: 'New shirts',
    //   amount: 19.88,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Good shirts',
    //   amount: 29.88,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
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

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bctx) {
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      return _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
    title: Text('Personal Expense'),
    backgroundColor: Theme.of(context).primaryColorDark,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    ],
  );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.4,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.6,
              child: TransactionList(_userTransactions, _deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
