import 'package:flutter/material.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/main.dart';
import 'package:mybooks/ui/screens/search_page.dart';
import 'package:mybooks/ui/widgets/app_title.dart';
import 'package:mybooks/ui/widgets/process_button_widget.dart';
import 'package:mybooks/ui/widgets/profit_widget.dart';

class Header extends StatelessWidget {
  final VoidCallback? onMenueIconPressed;
  const Header({
    Key? key,
    this.onMenueIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(30))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///TODO: drawer
              // IconButton(
              //     onPressed: onMenueIconPressed!,
              //     icon: Icon(
              //       Icons.tune,
              //       color: Colors.white,
              //     )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SearchPage(
                        user: sharedPrefs.getUser(),
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    )
                        // MaterialPageRoute(

                        //   builder: (_) => SearchPage(
                        //         user: sharedPrefs.getUser(),
                        //       ))

                        );
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
              Text(
                sharedPrefs.getUser().placeName!,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          AppTitle(),
          SizedBox(
            height: 20,
          ),
          ProfitWidget(
            amount: "7804 ج.س",
            isProfit: true,
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProcessButtonWidget(
                  text: "داخل",
                  icon: Icons.south,
                  isIN: false,
                ),
                ProcessButtonWidget(
                    text: " خارج", icon: Icons.north, isIN: true)
              ],
            ),
          ))
        ],
      ),
    );
  }
}
