import 'package:flutter/material.dart';
import 'package:mybooks/core/enums/view_state.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/styles.dart';
import 'package:mybooks/core/viewmodels/net_amount_viewmodel.dart';
import 'package:mybooks/core/viewmodels/stats_viewmodel.dart';
import 'package:mybooks/ui/widgets/profit_widget.dart';
import 'package:stacked/stacked.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            height: 80,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(30))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(''),
                Text(
                  sharedPrefs.getUser().placeName!,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            height: 180,
            margin: EdgeInsets.all(8),
            padding: padding8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'إجمالي اليوم',
                      style: TextStyle(color: onPrimaryColor),
                    ),
                    ViewModelBuilder<StatsViewmodel>.reactive(
                        onModelReady: (model) async {
                          model.initSocket();
                          await model
                              .fetchTodayAmount(sharedPrefs.getUser().sId!);
                        },
                        viewModelBuilder: () => StatsViewmodel(),
                        builder: (context, model, child) {
                          if (model.state == ViewState.Busy) {
                            return Center(
                              child: loadingWidgetOnPrimaryColor,
                            );
                          } else if (model.state == ViewState.Error) {
                            return Center(
                              child: IconButton(
                                  onPressed: () async {
                                    await model.fetchTodayAmount(
                                        sharedPrefs.getUser().sId!);
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  )),
                            );
                          } else {
                            if (model.dailayAmount > 0) {
                              return ProfitWidget(
                                amount: "${model.dailayAmount} ج.س",
                                isProfit: true,
                              );
                            } else {
                              return ProfitWidget(
                                amount: "${model.dailayAmount * -1} ج.س",
                                isProfit: false,
                              );
                            }
                          }
                        }),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('إجمالي الاسبوع',
                        style: TextStyle(color: onPrimaryColor)),
                    ViewModelBuilder<StatsViewmodel>.reactive(
                        onModelReady: (model) async {
                          await model
                              .fetchWeekAmount(sharedPrefs.getUser().sId!);
                        },
                        viewModelBuilder: () => StatsViewmodel(),
                        builder: (context, model, child) {
                          if (model.state == ViewState.Busy) {
                            return Center(
                              child: loadingWidgetOnPrimaryColor,
                            );
                          } else if (model.state == ViewState.Error) {
                            return Center(
                              child: IconButton(
                                  onPressed: () async {
                                    await model.fetchWeekAmount(
                                        sharedPrefs.getUser().sId!);
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  )),
                            );
                          } else {
                            if (model.weeklyAmount > 0) {
                              return ProfitWidget(
                                amount: "${model.weeklyAmount} ج.س",
                                isProfit: true,
                              );
                            } else {
                              return ProfitWidget(
                                amount: "${model.weeklyAmount * -1} ج.س",
                                isProfit: false,
                              );
                            }
                          }
                        }),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('إجمالي الشهر',
                        style: TextStyle(color: onPrimaryColor)),
                    ViewModelBuilder<StatsViewmodel>.reactive(
                        onModelReady: (model) async {
                          await model
                              .fetchMonthAmount(sharedPrefs.getUser().sId!);
                        },
                        viewModelBuilder: () => StatsViewmodel(),
                        builder: (context, model, child) {
                          if (model.state == ViewState.Busy) {
                            return Center(
                              child: loadingWidgetOnPrimaryColor,
                            );
                          } else if (model.state == ViewState.Error) {
                            return Center(
                              child: IconButton(
                                  onPressed: () async {
                                    await model.fetchMonthAmount(
                                        sharedPrefs.getUser().sId!);
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  )),
                            );
                          } else {
                            if (model.monthlAmount > 0) {
                              return ProfitWidget(
                                amount: "${model.monthlAmount} ج.س",
                                isProfit: true,
                              );
                            } else {
                              return ProfitWidget(
                                amount: "${model.monthlAmount * -1} ج.س",
                                isProfit: false,
                              );
                            }
                          }
                        }),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            child: Wrap(
                // direction: Axis.vertical,
                alignment: WrapAlignment.center,
                spacing: 8.0,
                runAlignment: WrapAlignment.center,
                runSpacing: 8.0,
                // crossAxisAlignment: WrapCrossAlignment.center,
                // textDirection: TextDirection.rtl,
                // verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      width: 150,
                      height: 120,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("صافي الحساب",
                              style: TextStyle(color: onPrimaryColor)),
                          ViewModelBuilder<NetAmountViewmodel>.reactive(
                              onModelReady: (model) async {
                                await model
                                    .fetchNetAmount(sharedPrefs.getUser().sId!);
                              },
                              viewModelBuilder: () => NetAmountViewmodel(),
                              builder: (context, model, child) {
                                if (model.state == ViewState.Busy) {
                                  return Center(
                                    child: loadingWidgetOnPrimaryColor,
                                  );
                                } else if (model.state == ViewState.Error) {
                                  return Center(
                                    child: IconButton(
                                        onPressed: () async {
                                          await model.fetchNetAmount(
                                              sharedPrefs.getUser().sId!);
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
                                    );
                                  } else {
                                    return ProfitWidget(
                                      amount: "${model.amount * -1} ج.س",
                                      isProfit: false,
                                    );
                                  }
                                }
                              }),
                        ],
                      ))),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      width: 150,
                      height: 120,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("اجمالي المبالغ الداخلة",
                              style: TextStyle(color: onPrimaryColor)),
                          ViewModelBuilder<StatsViewmodel>.reactive(
                              onModelReady: (model) async {
                                await model
                                    .fetchInAmount(sharedPrefs.getUser().sId!);
                              },
                              viewModelBuilder: () => StatsViewmodel(),
                              builder: (context, model, child) {
                                if (model.state == ViewState.Busy) {
                                  return Center(
                                    child: loadingWidgetOnPrimaryColor,
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
                                  if (model.inAmount > 0) {
                                    return ProfitWidget(
                                      amount: "${model.inAmount} ج.س",
                                      isProfit: false,
                                    );
                                  } else {
                                    return ProfitWidget(
                                      amount: "${model.inAmount * -1} ج.س",
                                      isProfit: false,
                                    );
                                  }
                                }
                              }),
                        ],
                      ))),
                  Container(
                      width: 150,
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("اجمالي المبالغ الخارجة",
                              style: TextStyle(color: onPrimaryColor)),
                          ViewModelBuilder<StatsViewmodel>.reactive(
                              onModelReady: (model) async {
                                await model
                                    .fetchOutAmount(sharedPrefs.getUser().sId!);
                              },
                              viewModelBuilder: () => StatsViewmodel(),
                              builder: (context, model, child) {
                                if (model.state == ViewState.Busy) {
                                  return Center(
                                    child: loadingWidgetOnPrimaryColor,
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
                                  if (model.outAmount > 0) {
                                    return ProfitWidget(
                                      amount: "${model.outAmount} ج.س",
                                      isProfit: true,
                                    );
                                  } else {
                                    return ProfitWidget(
                                      amount: "${model.outAmount * -1} ج.س",
                                      isProfit: false,
                                    );
                                  }
                                }
                              }),
                        ],
                      ))),
                ]),
          )
        ],
      ),
    );
  }
}