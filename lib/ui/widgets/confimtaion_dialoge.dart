import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<Future<bool?>> confirmationDialog(BuildContext context, String? message,
    {VoidCallback? onOkBtnPressed, VoidCallback? onCancelBtnPressed}) async {
  var alertStyle = AlertStyle(
    animationType: AnimationType.fromBottom,
    isCloseButton: false,
    isOverlayTapDismiss: true,
    descStyle: TextStyle(fontWeight: FontWeight.bold),
    descTextAlign: TextAlign.start,
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
    alertAlignment: Alignment.center,
  );

  return Alert(
    context: context,
    style: alertStyle,
    type: AlertType.info,
    title: "تأكيد",
    desc: message,
    buttons: [
      DialogButton(
        child: Text(
          "حسنا",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: onOkBtnPressed,
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        child: Text(
          "إالغاء",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      )
    ],
  ).show();
}
