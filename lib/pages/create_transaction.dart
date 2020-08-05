import 'dart:async';

import 'package:expense_calc/logic/expensesList.dart';
import 'package:expense_calc/logic/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../main.dart';

enum TransactionType { credit, debit }

class CreateTransaction extends StatefulWidget {
  @override
  _CreateTransactionState createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TransactionType _transactionType = TransactionType.debit;
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final transactionName = TextEditingController();
  final transactionAmount = TextEditingController();

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      transactionsList.add(
        Transaction(
          id: DateTime.now().toString(),
          title: transactionName.text,
          amount: double.parse(transactionAmount.text),
          date: selectedDate,
          transactionType:
              _transactionType == TransactionType.debit ? true : false,
        ),
      );
      SnackBar snackBar = SnackBar(
        content: Text('Transaction Added'),
      );
      setState(() {});
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(
        Duration(seconds: 1),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ),
          );
        },
      );
    }
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            actionsPadding: EdgeInsets.all(16.0),
            backgroundColor: Color(0xFF10194E),
            title: new Text(
              'Are we on a Break?',
              style: TextStyle(color: Colors.white),
            ),
            content: new Text(
              'But I Love You',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(
                  "NO",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text(
                  "YES",
                  style: TextStyle(color: Colors.greenAccent),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
      helpText: 'Transaction Date',
      confirmText: 'AYE!',
      cancelText: 'NAH!',
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(
        Duration(days: 7),
      ),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext parentContext) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              },
              icon: Icon(
                Icons.arrow_back_ios,
              )),
          title: Text(
            'New Transaction',
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF010A43),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF010A43),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 40.0,
                              left: 16.0,
                            ),
                            child: Text(
                              'Already',
                              style: GoogleFonts.caveat(
                                color: Colors.white,
                                fontSize: 22.0,
                                letterSpacing: 3,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 16.0,
                            ),
                            child: Text(
                              'Spending ?',
                              style: GoogleFonts.nunito(
                                fontSize: 55.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF2E63),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF10194E),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: ListView(
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 16,
                                  top: 40.0,
                                  right: 16.0,
                                  bottom: 26.0,
                                ),
                                child: Container(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          onSaved: (val) => {},
                                          validator: (val) {
                                            if (val.trim().length < 3 ||
                                                val.isEmpty) {
                                              return 'Name too Short!';
                                            } else if (val.trim().length > 18) {
                                              return 'Name too Long!';
                                            } else {
                                              return null;
                                            }
                                          },
                                          style: GoogleFonts.caveat(
                                            fontSize: 22.0,
                                            color: Colors.white,
                                          ),
                                          maxLength: 12,
                                          controller: transactionName,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Transaction",
                                            hintText:
                                                "Spending on that Girl again!?",
                                            hintStyle: TextStyle(
                                              color: Colors.white54,
                                            ),
                                            labelStyle: TextStyle(
                                              fontSize: 22.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        TextFormField(
                                          onSaved: (val) => {},
                                          keyboardType: TextInputType.number,
                                          controller: transactionAmount,
                                          validator: (val) {
                                            if (val.trim().length < 1 ||
                                                val.isEmpty) {
                                              return 'Amount too Less!';
                                            } else {
                                              return null;
                                            }
                                          },
                                          style: GoogleFonts.caveat(
                                            fontSize: 22.0,
                                            color: Colors.white,
                                          ),
                                          maxLength: 18,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Amount",
                                            hintText:
                                                "How much did u spend on her!?",
                                            hintStyle: TextStyle(
                                              color: Colors.white54,
                                            ),
                                            labelStyle: TextStyle(
                                              fontSize: 22.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(children: [
                                              Radio(
                                                value: TransactionType.debit,
                                                groupValue: _transactionType,
                                                activeColor: Color(0xFFFF2E63),
                                                onChanged:
                                                    (TransactionType value) {
                                                  setState(() {
                                                    _transactionType = value;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Debit',
                                                style: GoogleFonts.nunito(
                                                  color: Colors.white70,
                                                  fontSize: 22.0,
                                                ),
                                              ),
                                            ]),
                                            Row(children: [
                                              Radio(
                                                value: TransactionType.credit,
                                                groupValue: _transactionType,
                                                activeColor: Color(0xFFFF2E63),
                                                onChanged:
                                                    (TransactionType value) {
                                                  setState(() {
                                                    _transactionType = value;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Credit',
                                                style: GoogleFonts.nunito(
                                                  color: Colors.white70,
                                                  fontSize: 22.0,
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 35.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      selectedDate == null
                                          ? 'No Date chosen'
                                          : DateFormat.yMMMEd()
                                              .format(selectedDate),
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.0,
                                        letterSpacing: 1,
                                        color: Colors.white,
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        _presentDatePicker(context);
                                      },
                                      child: Text(
                                        'Change Date',
                                        style: GoogleFonts.poppins(
                                          fontSize: 18.0,
                                          letterSpacing: 1,
                                          color: Color(0xFFFF2E63),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(24.0),
                                child: GestureDetector(
                                  onTap: _submit,
                                  child: Container(
                                    height: 55.0,
                                    width: 160.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF2E63),
                                      borderRadius: BorderRadius.circular(3.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Submit',
                                        style: GoogleFonts.poppins(
                                          fontSize: 22.0,
                                          letterSpacing: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
