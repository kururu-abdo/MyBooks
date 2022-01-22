import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mybooks/core/enums/view_state.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/helper.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/core/utils/strings.dart';
import 'package:mybooks/core/utils/styles.dart';
import 'package:mybooks/core/viewmodels/trasnsaction_view_model.dart';
import 'package:mybooks/main.dart';
import 'package:mybooks/ui/screens/edit_transaction.dart';
import 'package:mybooks/ui/widgets/confimtaion_dialoge.dart';
import 'package:mybooks/ui/widgets/first_layer.dart';
import 'package:mybooks/ui/widgets/second_layer.dart';
import 'package:mybooks/ui/widgets/transaction.dart';
import 'package:stacked/stacked.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({Key? key}) : super(key: key);

  @override
  _AllTransactionsState createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: getLeadingWidget(context),
          title: Text(
            'كل العلميات',
            style: titleStyle,
          ),
        ),
        body: Container(
            height: double.infinity,
            padding: padding8,
            child: ViewModelBuilder<TransactionViewModel>.reactive(
                onModelReady: (model) async {
                  await model.fetchTransactions(sharedPrefs.getUser().sId!);
                },
                viewModelBuilder: () => TransactionViewModel(),
                builder: (context, model, child) {
                  if (model.state == ViewState.Busy) {
                    return Center(
                      child: loadingWidget,
                    );
                  } else {
                    return ListView.builder(
                        itemCount: model.transactions.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            key: UniqueKey(),
                            startActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              // dismissible: DismissiblePane(
                              //     closeOnCancel: true, onDismissed: () {}),

                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: (context) async {
                                    confirmationDialog(
                                        context, 'هل تريد حذف العملية؟',
                                        onOkBtnPressed: () async {
                                      await model.deleteTransaction(
                                          model.transactions[index].sId!);
                                    }, onCancelBtnPressed: () {
                                      nav.pop();
                                    });
                                  },
                                  backgroundColor: Color(0xFFFE4A49),
                                  //     foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: deleteText,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    nav.push(EditTransRouter(
                                        transaction:
                                            model.transactions[index]));
                                  },
                                  backgroundColor: Colors.green,
                                  //    foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: EditText,
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              // dismissible: DismissiblePane(
                              //     closeOnCancel: true, onDismissed: () {}),

                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: (context) async {
                                    confirmationDialog(
                                        context, 'هل تريد حذف العملية؟',
                                        onOkBtnPressed: () {
                                      model.deleteTransaction(
                                          model.transactions[index].sId!);
                                    }, onCancelBtnPressed: () {
                                      nav.pop();
                                    });
                                  },
                                  backgroundColor: Color(0xFFFE4A49),
                                  //     foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: deleteText,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    nav.push(EditTransRouter(
                                        transaction:
                                            model.transactions[index]));
                                  },
                                  backgroundColor: Colors.green,
                                  //    foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: EditText,
                                ),
                              ],
                            ),
                            child: TransactionWidget(
                              account:
                                  "${model.transactions[index].account!.name}",
                              amount: "${model.transactions[index].amount} ج.س",
                              isIn: model.isIn(model.transactions[index]),
                              date: model.transactions[index].date,
                            ),
                          );
                        });
                  }
                })));
  }
}
