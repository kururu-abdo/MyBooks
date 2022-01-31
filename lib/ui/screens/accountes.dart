import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/core/viewmodels/account_viewModel.dart';
import 'package:mybooks/locstor.dart';
import 'package:mybooks/ui/screens/accounts_details.dart';
import 'package:mybooks/ui/screens/add_account.dart';
import 'package:mybooks/ui/widgets/header.dart';
import 'package:stacked/stacked.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  bool _showButtomSheet = false;
  void updateBottomSheetState() {
    setState(() {
      _showButtomSheet = !_showButtomSheet;
    });
  }

  void doNothing(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    var nav = locator.get<AppRouter>();
    return Container(
        child: ListView(children: [
      Container(
        height: 80,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1.0,
                  blurRadius: 15.0,
                  offset: Offset(0, 4),
                  color: Colors.greenAccent.withOpacity(0.35))
            ],
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(30))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => AddAccount()));
                },
                icon: Icon(
                  Icons.person_add,
                  color: Colors.black,
                )),
            Text(
              sharedPrefs.getUser().placeName!,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Container(
          height: MediaQuery.of(context).size.height - 250,
          padding: EdgeInsets.all(10),
          child: ViewModelBuilder<AccountViewModel>.reactive(
            viewModelBuilder: () => AccountViewModel(),
            onModelReady: (model) async {
              await model.fetcaAccounts(sharedPrefs.getUser().sId!);
              model.initSocket();
            },
            builder: (context, model, child) {
              if (model.isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: Colors.green,
                  ),
                );
              } else {
                return ListView(
                  children: model.accounts
                      .map((e) => InkWell(
                            onTap: () {
                              ///TODO:change to auto_route
                              ///
                              ///
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => AcccountDetails(
                                        account: e,
                                      )));
                            },
                            child: Container(
                              height: 80,
                              child: Card(
                                elevation: 2.0,
                                child: ListTile(
                                  title: Text(
                                    e.name!,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                );
              }
            },
          ))
    ]));
  }
}
