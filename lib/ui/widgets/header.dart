import 'package:flutter/material.dart';
import 'package:mybooks/core/enums/view_state.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/core/utils/styles.dart';
import 'package:mybooks/core/viewmodels/net_amount_viewmodel.dart';
import 'package:mybooks/main.dart';
import 'package:mybooks/ui/screens/search_page.dart';
import 'package:mybooks/ui/widgets/app_title.dart';
import 'package:mybooks/ui/widgets/process_button_widget.dart';
import 'package:mybooks/ui/widgets/profit_widget.dart';
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
                    nav.push(SearchPageRouter(
                      user: sharedPrefs.getUser(),
                    ));
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
          ViewModelBuilder<NetAmountViewmodel>.reactive(
              onModelReady: (model) async {
                model.initSocket();
                await model.fetchNetAmount(sharedPrefs.getUser().sId!);
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
                    );
                  } else {
                    return ProfitWidget(
                      amount: "${model.amount * -1} ج.س",
                      isProfit: false,
                    );
                  }
                }
              }),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProcessButtonWidget(
                  text: "مدين",
                  icon: Icons.south,
                  isIN: false,
                ),
                ProcessButtonWidget(text: "دائن", icon: Icons.north, isIN: true)
              ],
            ),
          ))
        ],
      ),
    );
  }
}
