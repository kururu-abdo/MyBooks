import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybooks/main.dart';

Widget getLeadingWidget(BuildContext context) {
  return IconButton(
      onPressed: () {
        nav.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios, color: Colors.green));
}
