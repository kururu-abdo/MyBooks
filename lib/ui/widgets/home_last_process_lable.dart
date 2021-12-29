import 'package:flutter/material.dart';

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
          Text(
            "عرض الكل",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
