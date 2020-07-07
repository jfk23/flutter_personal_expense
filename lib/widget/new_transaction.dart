import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function func;
  NewTransaction(this.func);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0) {
      return;
    }

    widget.func(enteredTitle, enteredAmount);
    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: 'title'),
          controller: titleController,
          onSubmitted: (_) => submitData(),
        ),
        TextField(
          decoration: InputDecoration(labelText: 'amount'),
          controller: amountController,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => submitData(),
        ),
        FlatButton(
          child: Text('Submit Transaction'),
          textColor: Colors.blueAccent,
          onPressed: submitData,
        ),
      ],
    );
  }
}
