import 'package:flutter/material.dart';
import 'package:mybooks/core/model/account.dart';
import 'package:mybooks/core/model/transaction_type.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/helper.dart';
import 'package:mybooks/core/utils/styles.dart';
import 'package:mybooks/core/viewmodels/transaction_type_viewmodel.dart';
import 'package:mybooks/core/viewmodels/trasnsaction_view_model.dart';
import 'package:stacked/stacked.dart';

class UserTransaction extends StatefulWidget {
  final Account? account;
  const UserTransaction({Key? key, this.account}) : super(key: key);

  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  var _formKey = GlobalKey<FormState>();
  var _priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: getLeadingWidget(context),
        title: Text(
          widget.account!.name!,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: ViewModelBuilder<TransactionViewModel>.reactive(
        viewModelBuilder: () => TransactionViewModel(),
        onModelReady: (model) {
          model.initSocket();
        },
        builder: (context, model, child) => Center(
          child: Container(
              height: 250,
              width: double.infinity,

              // decoration: BoxDecoration(

              //  //   color: Colors.green,

              //     borderRadius: BorderRadius.circular(8)),

              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "عملية جديدة",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20.0),
                      ViewModelBuilder<TransactionTypeViewModel>.reactive(
                          viewModelBuilder: () => TransactionTypeViewModel(),
                          onModelReady: (model2) async {
                            await model2.fetchTypes();

                            model2.initSocket();
                          },
                          builder: (context, model2, child) {
                            if (model2.isLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.2,
                                  color: Colors.green,
                                ),
                              );
                            } else {
                              return DropdownButtonFormField<TransactionType>(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.green,
                                  ),

                                  //  value: model.transaction_type,

                                  decoration: InputDecoration(
                                    filled: true,
                                  ),
                                  items: model2.transaction_types
                                      .map((TransactionType e) =>
                                          DropdownMenuItem(
                                              value: e,
                                              child: Text(e.typeName!)))
                                      .toList(),
                                  onChanged: (e) {
                                    model.setTransactionType(e!);
                                  });
                            }
                          }),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "0 ج.س",
                            filled: true,
                            suffixIcon: Icon(
                              Icons.attach_money_outlined,
                              color: Colors.green,
                            )),
                      ),
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: () async {
                          await model.addTransaction(
                              sharedPrefs.getUser().sId!,
                              model.transaction_type.sId!,
                              widget.account!.sId!,
                              double.parse(_priceController.text));
                              
                        },
                        child: model.isLoading
                            ? Center(
                                child: loadingWidget,
                              )
                            : Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),

                                // padding:

                                //     EdgeInsets.fromLTRB(10, 0, 10, 0),

                                child: Center(
                                  child: Text(
                                    'إضافة',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}
