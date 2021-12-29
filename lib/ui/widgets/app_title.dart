import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "حساباتي",
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
