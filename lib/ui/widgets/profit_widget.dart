import 'package:flutter/material.dart';

class ProfitWidget extends StatefulWidget {
  final bool? isProfit;
  final String? amount;
  const ProfitWidget({Key? key, this.isProfit, this.amount}) : super(key: key);

  @override
  _ProfitWidgetState createState() => _ProfitWidgetState();
}

class _ProfitWidgetState extends State<ProfitWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        widget.amount!,
        style: TextStyle(
            color: widget.isProfit! ? Colors.white : Colors.red,
            fontFamily: "Cairo",
            // fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
