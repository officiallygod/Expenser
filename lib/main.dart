import 'package:expense_calc/logic/expensesList.dart';
import 'package:expense_calc/logic/transaction.dart';
import 'package:expense_calc/widgets/card_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import './pages/create_transaction.dart';
import './widgets/transactions_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenser',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFFFF2E63),
        accentColor: Color(0xFF010A43),
        colorScheme: ColorScheme.light().copyWith(
          primary: Color(0xFFFF2E63),
          onSurface: Colors.white,
        ),
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
  void showBottomSheetTransactions(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      elevation: 6,
      backgroundColor: Colors.transparent,
      builder: (bCtx) {
        return Container(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF10194E),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: TransactionsList(deleteTransaction),
          ),
        );
      },
    );
  }

  double totalMoney() {
    double totalSum = 0.0;
    for (var i = 0; i < transactionsList.length; i++) {
      print('${transactionsList[i].title} : ${transactionsList[i].amount}');
      totalSum += transactionsList[i].amount;
    }
    return totalSum;
  }

  List<Transaction> get _recentTransactions {
    return transactionsList.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void deleteTransaction(String id) {
    setState(() {
      transactionsList.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF010A43),
        title: Text(
          'Expenser',
          style: GoogleFonts.raleway(
            //color: Color(0xFFFF2E63),
            letterSpacing: 2.5,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTransaction(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                Icons.add,
                size: 32.0,
                color: Color(0xFFFF2E63),
              ),
            ),
          ),
//          IconButton(
//            onPressed: () => showBottomSheetTransactions(context),
//            icon: Icon(Icons.refresh),
//          ),
        ],
      ),
      backgroundColor: Color(0xFF010A43),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(80.0),
            child: Column(
              children: [
                Text(
                  'Money Wasted',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    color: Color(0xFF454D89),
                    letterSpacing: 3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                  '₹ ${totalMoney()}',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.nunito(
                    fontSize: 50,
                    color: Color(0xFFCFD1DB),
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CardExpense(
                  recentTransactions: _recentTransactions,
                ),
                GestureDetector(
                  onTap: () => showBottomSheetTransactions(context),
                  child: Container(
                    height: 130.0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFEAC5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.3),
                          spreadRadius: 6,
                          blurRadius: 6,
                          offset: Offset(1, -1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 13.0,
                        ),
                        Container(
                          width: 80,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.1),
                                spreadRadius: 6,
                                blurRadius: 6,
                                offset:
                                    Offset(1, -1), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'View Transactions',
                              style: GoogleFonts.raleway(
                                fontSize: 28,
                                color: Colors.black,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
