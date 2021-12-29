import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mybooks/core/enums/toast_type.dart';
import 'package:mybooks/core/enums/toast_type.dart';
import 'package:mybooks/core/enums/toast_type.dart';

class ToastServices {
  static void displayToast(String message,
      {ToastType? type, ToastGravity? gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: getColor(type!),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Color getColor(ToastType type) {
    if (type == ToastType.Error) {
      return Colors.red;
    } else if (type == ToastType.Success) {
      return Colors.green;
    } else if (type == ToastType.Warning) {
      return Colors.deepOrange;
    } else {
      return Colors.black;
    }
  }
}
