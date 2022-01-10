import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybooks/main.dart';
import 'package:intl/intl.dart' as intl;

Widget getLeadingWidget(BuildContext context) {
  return IconButton(
      onPressed: () {
        nav.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios, color: Colors.green));
}

String getFormattedDate(String date) {
  var newDate = DateTime.parse(date);
  return intl.DateFormat('yyyy-MM-dd', 'ar').add_jms().format(newDate);
}
