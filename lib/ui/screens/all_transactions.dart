import 'package:flutter/material.dart';
import 'package:mybooks/ui/widgets/first_layer.dart';
import 'package:mybooks/ui/widgets/second_layer.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({Key? key}) : super(key: key);

  @override
  _AllTransactionsState createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FirstLayer(),
SecondLayer(),
        ],
      ),
    );
  }
}
