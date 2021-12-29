import 'package:flutter/material.dart';
import 'package:mybooks/core/enums/view_state.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/viewmodels/last_transactions_viewmodel.dart';
import 'package:mybooks/core/viewmodels/transaction_type_viewmodel.dart';
import 'package:mybooks/core/viewmodels/trasnsaction_view_model.dart';
import 'package:mybooks/core/viewmodels/user_transactions_viewmodel.dart';
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
              } else {
                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: model.lastTransactions
                      .map(
                        (trans) => TransactionWidget(
                          account: "${trans.account!.name}",
                          amount: "${trans.amount} ج.س",
                          isIn: model.isIn(trans),
                          date: trans.date,
                        ),
                      )
                      .toList(),
                );
              }
            }));
  }
}
