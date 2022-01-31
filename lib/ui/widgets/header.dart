import 'package:flutter/material.dart';
import 'package:mybooks/core/enums/view_state.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/core/utils/styles.dart';
import 'package:mybooks/core/viewmodels/net_amount_viewmodel.dart';
import 'package:mybooks/core/viewmodels/stats_viewmodel.dart';
import 'package:mybooks/main.dart';
import 'package:mybooks/ui/screens/search_page.dart';
import 'package:mybooks/ui/widgets/app_title.dart';
import 'package:mybooks/ui/widgets/process_button_widget.dart';
import 'package:mybooks/ui/widgets/profit_widget.dart';
import 'package:mybooks/ui/widgets/shimmer.dart';
import 'package:stacked/stacked.dart';

class Header extends StatelessWidget {
  final VoidCallback? onMenueIconPressed;
  const Header({
    Key? key,
    this.onMenueIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      // padding: EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //     color: Theme.of(context).primaryColor,
      //     borderRadius:
      //         const BorderRadius.vertical(bottom: Radius.circular(30))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///TODO: drawer
                // IconButton(
                //     onPressed: onMenueIconPressed!,
                //     icon: Icon(
                //       Icons.tune,
                //       color: Colors.white,
                //     )),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.shade50,
                          // gradient: LinearGradient(
                          //     begin: Alignment.topLeft,
                          //     end: Alignment.bottomRight,
                          //     colors: [
                          //       Colors.grey[200]!,
                          //       Colors.grey[300]!,
                          //       Colors.grey[400]!,
                          //       Colors.grey[500]!,
                          //     ]),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1.0,
                                blurRadius: 15.0,
                                offset: Offset(4.0, 4.0),
                                color: Colors.grey.shade300),
                            BoxShadow(
                                spreadRadius: 1.0,
                                blurRadius: 15.0,
                                offset: Offset(-4.0, -4.0),
                                color: Colors.white)
                          ]),
                      child: IconButton(
                          onPressed: () {
                            nav.push(SearchPageRouter(
                              user: sharedPrefs.getUser(),
                            ));
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.green,
                          )),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.shade50,
                          // gradient: LinearGradient(
                          //     begin: Alignment.topLeft,
                          //     end: Alignment.bottomRight,
                          //     colors: [
                          //       Colors.grey[200]!,
                          //       Colors.grey[300]!,
                          //       Colors.grey[400]!,
                          //       Colors.grey[500]!,
                          //     ]),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1.0,
                                blurRadius: 15.0,
                                offset: Offset(4.0, 4.0),
                                color: Colors.grey.shade300),
                            BoxShadow(
                                spreadRadius: 1.0,
                                blurRadius: 15.0,
                                offset: Offset(-4.0, -4.0),
                                color: Colors.white)
                          ]),
                      child: IconButton(
                          onPressed: () {
                            nav.push(SearchPageRouter(
                              user: sharedPrefs.getUser(),
                            ));
                          },
                          icon: Icon(
                            Icons.notifications_none_rounded,
                            color: Colors.green,
                          )),
                    ),
                  ],
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          "مرحبا   " + sharedPrefs.getUser().name!,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "قم بحفظ كل  العمليات المالية",
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Icon(Icons.person, color: Colors.green, size: 50),
                  ],
                )
              ],
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          // AppTitle(),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 160,
            width: double.infinity,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              gradient: LinearGradient(
                  colors: [Colors.green.shade300, Colors.green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                ViewModelBuilder<NetAmountViewmodel>.reactive(
                    onModelReady: (model) async {
                      model.initSocket();
                      await model.fetchNetAmount(sharedPrefs.getUser().sId!);
                    },
                    viewModelBuilder: () => NetAmountViewmodel(),
                    builder: (context, model, child) {
                      if (model.state == ViewState.Busy) {
                        return ShimmerBuilder(
                          width: 100,
                          height: 29,
                        );
                      } else if (model.state == ViewState.Error) {
                        return Center(
                          child: IconButton(
                              onPressed: () async {
                                await model
                                    .fetchNetAmount(sharedPrefs.getUser().sId!);
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              )),
                        );
                      } else {
                        if (model.amount > 0) {
                          return ProfitWidget(
                              amount: "${model.amount} ج.س",
                              isProfit: true,
                              color: Colors.white);
                        } else {
                          return ProfitWidget(
                              amount: "${model.amount * -1} ج.س",
                              isProfit: false,
                              color: Colors.red);
                        }
                      }
                    }),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ViewModelBuilder<StatsViewmodel>.reactive(
                        onModelReady: (model) async {
                          model.initSocket();
                          await model.fetchInAmount(sharedPrefs.getUser().sId!);
                        },
                        viewModelBuilder: () => StatsViewmodel(),
                        builder: (context, model, child) {
                          if (model.state == ViewState.Busy) {
                            return ShimmerBuilder(
                              width: 100,
                              height: 60,
                            );
                          } else if (model.state == ViewState.Error) {
                            return Center(
                              child: IconButton(
                                  onPressed: () async {
                                    await model.fetchInAmount(
                                        sharedPrefs.getUser().sId!);
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  )),
                            );
                          } else {
                            return ProcessButtonWidget(
                              icon: Icons.south,
                              isIN: false,
                              text: "${model.inAmount} ج.س",
                            );
                            // if (model.inAmount > 0) {
                            //   return ProfitWidget(
                            //     amount: "${model.inAmount} ج.س",
                            //     isProfit: false,
                            //   );
                            // } else {
                            //   return ProfitWidget(
                            //     amount: "${model.inAmount * -1} ج.س",
                            //     isProfit: false,
                            //   );
                            // }
                          }
                        }),
                    ViewModelBuilder<StatsViewmodel>.reactive(
                        onModelReady: (model) async {
                          model.initSocket();
                          await model
                              .fetchOutAmount(sharedPrefs.getUser().sId!);
                        },
                        viewModelBuilder: () => StatsViewmodel(),
                        builder: (context, model, child) {
                          if (model.state == ViewState.Busy) {
                            return ShimmerBuilder(
                              width: 100,
                              height: 60,
                            );
                          } else if (model.state == ViewState.Error) {
                            return Center(
                              child: IconButton(
                                  onPressed: () async {
                                    await model.fetchOutAmount(
                                        sharedPrefs.getUser().sId!);
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  )),
                            );
                          } else {
                            return ProcessButtonWidget(
                              icon: Icons.north,
                              isIN: true,
                              text: "${model.outAmount} ج.س",
                            );
                          }
                        }),
                  ],
                ),
                // Spacer(),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: ShimmerBuilder(
                //     width: 100,
                //     height: 20,
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
