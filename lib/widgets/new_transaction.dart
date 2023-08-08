import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titlecontroller = TextEditingController();

  final _amountcontroller = TextEditingController();
  late DateTime _selectedDate;
  bool _isDateSelected = false;

  void _submit() {
    if (_amountcontroller.text.isEmpty) {
      return;
    }
    final enteredTitle = _titlecontroller.text;
    final enteredAmount = double.parse(_amountcontroller.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addtx(
      _titlecontroller.text,
      double.parse(_amountcontroller.text),
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      _isDateSelected = true;
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titlecontroller,
                onSubmitted: (_) => _submit(),
                //onChanged: (val) {
                //titleInput = val;
                //},
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountcontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submit(),
                //onChanged: (val) {
                //amountInput = val;
                //},
              ),
              Container(
                height: 70,
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text(!_isDateSelected
                        ? 'No Date Chosen'
                        : DateFormat.yMd().format(_selectedDate)),
                  ),
                  TextButton(
                    child: Text(
                      'Choose date',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ]),
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Add Transaction',
                    style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.teal),
                ),
              )
            ]),
      ),
    );
  }
}
