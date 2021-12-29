import 'package:flutter/material.dart';
import 'package:mybooks/core/model/transaction.dart';

class FirstLayer extends StatelessWidget {
  const FirstLayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFF4c41a3), Color(0xFF1f186f)])),
    );
  }
}
