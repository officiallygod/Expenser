import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmountDebit;
  final double spendingAmountCredit;
  final double spendingPercentOfTotalDebit;
  final double spendingPercentOfTotalCredit;

  ChartBar({
    this.label,
    this.spendingAmountDebit,
    this.spendingAmountCredit,
    this.spendingPercentOfTotalDebit,
    this.spendingPercentOfTotalCredit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /* Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 14.0,
              child: FittedBox(
                child: Text(
                  '\$${spendingAmountDebit.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 4.0,
            ),
            Container(
              height: 14.0,
              child: FittedBox(
                child: Text(
                  '\$${spendingAmountCredit.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),*/
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200.0,
              width: 3.0,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1A225D),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercentOfTotalDebit,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFF2E63),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
              height: 200.0,
              width: 3.0,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1A225D),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercentOfTotalCredit,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF01CC88),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF454D89),
          ),
        ),
      ],
    );
  }
}
