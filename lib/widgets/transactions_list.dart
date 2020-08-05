import 'package:expense_calc/logic/expensesList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final Function deleteTx;

  TransactionsList(this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        Container(
          width: 80,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.white,
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
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 26.0),
          child: Text(
            'Transactions',
            textAlign: TextAlign.left,
            style: GoogleFonts.raleway(
              fontSize: 26,
              color: Color(0xFFCFD1DB),
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: transactionsList.isEmpty
                ? Center(
                    child: Text(
                      'Life is Beautiful\nMake some \nTransactions',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 30,
                        color: Colors.white,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 4.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 22.0),
                              child: Text(
                                '₹ ${transactionsList[index].amount.toStringAsFixed(2)}',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  color: transactionsList[index].transactionType
                                      ? Color(0xFFFF2E63)
                                      : Color(0xFF01CC88),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transactionsList[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nunito(
                                      fontSize: 25,
                                      color: Color(0xFFCFD1DB),
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.0,
                                  ),
                                  Text(
                                    DateFormat.MMMMEEEEd()
                                        .format(transactionsList[index].date),
                                    style: GoogleFonts.nunito(
                                      fontSize: 13,
                                      color: Color(0xFF8288B5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: IconButton(
                                  onPressed: () {
                                    deleteTx(transactionsList[index].id);
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: transactionsList.length,
                  ),
          ),
        ),
      ],
    );
  }
}
