import 'package:expense_calc/logic/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class CardExpense extends StatelessWidget {
  final List<Transaction> recentTransactions;

  CardExpense({this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSumDebit = 0.0;
      double totalSumCredit = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].transactionType == true &&
            recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSumDebit += recentTransactions[i].amount;
        }
      }
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].transactionType == false &&
            recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSumCredit += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.EEEE().format(weekDay).substring(0, 3),
        'amountDebit': totalSumDebit,
        'amountCredit': totalSumCredit
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + item['amountDebit'] + item['amountCredit'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 85.0),
      padding:
          EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0, bottom: 20.0),
      decoration: BoxDecoration(
        color: Color(0xFF0E164C),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            spreadRadius: 6,
            blurRadius: 6,
            offset: Offset(1, -1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'],
                spendingAmountDebit: data['amountDebit'],
                spendingAmountCredit: data['amountCredit'],
                spendingPercentOfTotalDebit: totalSpending == 0.0
                    ? 0.0
                    : (data['amountDebit'] as double) / totalSpending,
                spendingPercentOfTotalCredit: totalSpending == 0.0
                    ? 0.0
                    : (data['amountCredit'] as double) / totalSpending,
              ),
//              child: Text(
//                data['amountCredit'].toString(),
//                style: TextStyle(
//                  color: Colors.white,
//                ),
//              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
