import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/main.dart';

class LastProcessLable extends StatefulWidget {
  const LastProcessLable({Key? key}) : super(key: key);

  @override
  _LastProcessLableState createState() => _LastProcessLableState();
}

class _LastProcessLableState extends State<LastProcessLable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("اخر  العمليات"),
          InkWell(
            onTap: () {
              //   AutoRouter.of(context).push(MaterialPageRoute(builder: (context)=>))
              nav.push(const AllTransactionsRouter());
              print("To TRNSACTIONS ");
            },
            child: Text(
              "عرض الكل",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
