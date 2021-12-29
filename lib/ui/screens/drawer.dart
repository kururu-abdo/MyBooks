import 'package:flutter/material.dart';

class DrawerIcomns extends StatelessWidget {
  const DrawerIcomns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      elevation: 10,
      onClosing: () {
        // Do something
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (BuildContext ctx) => Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        child: Center(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Icon(
                  Icons.person_outline,
                  color: Colors.orange,
                  size: 35,
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Text(
                  "البروفايل",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ]),
              SizedBox(
                height: 15.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Colors.green,
                  size: 35,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  "إضافة حساب",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ]),
              SizedBox(
                height: 15.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(
                  Icons.receipt_long_outlined,
                  color: Colors.purple,
                  size: 35,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  "تقارير ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ]),
              SizedBox(
                height: 15.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(
                  Icons.logout_outlined,
                  color: Colors.red,
                  size: 35,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  "خروج ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
