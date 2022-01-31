import 'package:flutter/material.dart';
import 'package:mybooks/core/utils/helper.dart';
import 'package:mybooks/core/utils/sizes.dart';

class TransactionWidget extends StatelessWidget {
  final String? account;
  final String? date;
  final String? amount;
  final bool? isIn;
  final bool? isDone;
  const TransactionWidget(
      {Key? key,
      this.account,
      this.date,
      this.amount,
      this.isIn,
      this.isDone = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      height: 60,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        // boxShadow: [
        //   BoxShadow(
        //       // color: Colors!.green!.withOpacity(0.7)!, //New
        //       blurRadius: 25.0,
        //       offset: Offset(0, -10))
        // ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(account!,
                  style: TextStyle(
                      decoration: isDone!
                          ? TextDecoration.lineThrough
                          : TextDecoration.none)),
              Text(
                amount!,
                style: TextStyle(
                    color: isIn! ? Colors.green : Colors.red,
                    decoration: isDone!
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              )
            ],
          ),
          Text(
            getFormattedDate(
              date!,
            ),
            style: TextStyle(
                decoration:
                    isDone! ? TextDecoration.lineThrough : TextDecoration.none),
          )
        ],
      ),
    );
  }
}
