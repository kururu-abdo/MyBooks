import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mybooks/core/enums/view_state.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/core/utils/strings.dart';
import 'package:mybooks/core/viewmodels/last_transactions_viewmodel.dart';
import 'package:mybooks/core/viewmodels/transaction_type_viewmodel.dart';
import 'package:mybooks/core/viewmodels/trasnsaction_view_model.dart';
import 'package:mybooks/core/viewmodels/user_transactions_viewmodel.dart';
import 'package:mybooks/main.dart';
import 'package:mybooks/ui/screens/edit_transaction.dart';
import 'package:mybooks/ui/widgets/confimtaion_dialoge.dart';
import 'package:mybooks/ui/widgets/transaction.dart';
import 'package:stacked/stacked.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ViewModelBuilder<LastTransactionViewModel>.reactive(
            viewModelBuilder: () => LastTransactionViewModel(),
            onModelReady: (model) async {
              await model.fetchLastTransactions(sharedPrefs.getUser().sId!);
              model.initSocket();
            },
            builder: (context, model, child) {
              if (model.state == ViewState.Busy) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.2,
                    color: Colors.green,
                  ),
                );
              } else if (model.state == ViewState.Error) {
                return Center(
                  child: IconButton(
                      onPressed: () async {
                        await model
                            .fetchLastTransactions(sharedPrefs.getUser().sId!);
                        model.initSocket();
                      },
                      icon: Icon(Icons.refresh)),
                );
              } else {
                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: model.lastTransactions
                      .map(
                        (trans) => Slidable(
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
                                        onOkBtnPressed: () {
                                      model.deleteTransaction(
                                         trans.sId!);
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
                                  nav.push(EditTransRouter(transaction: trans));
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
                                onPressed: (context) async {},
                                backgroundColor: Color(0xFFFE4A49),
                                //     foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: deleteText,
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  nav.push(EditTransRouter(transaction: trans));
                                },
                                backgroundColor: Colors.green,
                                //    foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: EditText,
                              ),
                            ],
                          ),
                          child: TransactionWidget(
                            account: "${trans.account!.name}",
                            amount: "${trans.amount} ج.س",
                            isIn: model.isIn(trans),
                            date: trans.date,
                          ),
                        ),
                      )
                      .toList(),
                );
              }
            }));
  }
}
