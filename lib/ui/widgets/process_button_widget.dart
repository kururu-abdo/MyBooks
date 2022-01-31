import 'package:flutter/material.dart';
import 'package:mybooks/core/utils/colors.dart';
import 'package:mybooks/core/utils/sizes.dart';

class ProcessButtonWidget extends StatefulWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final String? text;
  final bool? isIN;
  const ProcessButtonWidget(
      {Key? key, this.onPressed, this.icon, this.text, this.isIN})
      : super(key: key);

  @override
  _ProcessButtonWidgetState createState() => _ProcessButtonWidgetState();
}

class _ProcessButtonWidgetState extends State<ProcessButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(defaultRadius)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Icon(widget.icon, color: widget.isIN! ? inColor : outColor),
        Text(
          widget.text!,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}
