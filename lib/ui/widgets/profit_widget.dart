import 'package:flutter/material.dart';

class ProfitWidget extends StatefulWidget {
  final bool? isProfit;
  final String? amount;
  final Color? color;
  const ProfitWidget(
      {Key? key, this.isProfit, this.amount, this.color = Colors.white})
      : super(key: key);

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
            color: widget.color,
            fontFamily: "Cairo",
            // fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
