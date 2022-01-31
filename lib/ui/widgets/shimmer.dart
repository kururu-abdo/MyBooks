import 'package:flutter/material.dart';

class ShimmerBuilder extends StatelessWidget {
  final double? width;
  final double? height;

  const ShimmerBuilder({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.greenAccent.withOpacity(0.5)),
    );
  }
}
