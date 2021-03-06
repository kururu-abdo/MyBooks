import 'package:flutter/material.dart';
import 'package:mybooks/core/model/account.dart';
import 'package:mybooks/core/model/transaction.dart';
import 'package:mybooks/core/model/transaction_type.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/helper.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/core/utils/styles.dart';
import 'package:mybooks/core/viewmodels/payment_viewmodel.dart';
import 'package:mybooks/core/viewmodels/transaction_type_viewmodel.dart';
import 'package:mybooks/core/viewmodels/trasnsaction_view_model.dart';
import 'package:mybooks/main.dart';
import 'package:mybooks/ui/screens/payment_page.dart';
import 'package:stacked/stacked.dart';

class EditTransaction extends StatefulWidget {
  final Transaction? transaction;
  const EditTransaction({Key? key, this.transaction}) : super(key: key);

  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<EditTransaction> {
  var _formKey = GlobalKey<FormState>();
  var _priceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _priceController.text = widget.transaction!.amount!.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: getLeadingWidget(context),
        title: Text(
          widget.transaction!.account!.name!,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: ViewModelBuilder<TransactionViewModel>.reactive(
          viewModelBuilder: () => TransactionViewModel(),
          onModelReady: (model) async {
            await model.getReminingBalce(widget.transaction!.sId!);
            model.initSocket();
          },
          builder: (context, model, child) => Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("???????????? ??????????????"),
                        Text("${model.remainingBalance} ?? .??"),
                      ],
                    ),
                    SizedBox(
                      width: 150,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: CheckboxListTile(
                          activeColor: Colors.green,

                          title: Text("???? ????????????"), //    <-- label
                          value: widget.transaction!.status == 'done',
                          onChanged: (newValue) async {
                            if (newValue!) {
                              await model.updateTransactionStatus(
                                  widget.transaction!.sId!, "done");
                            } else {
                              await model.updateTransactionStatus(
                                  widget.transaction!.sId!, "waiting");
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                    height: 350,
                    width: double.infinity,

                    // decoration: BoxDecoration(

                    //  //   color: Colors.green,

                    //     borderRadius: BorderRadius.circular(8)),

                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Text(
                                " ?????????? ??????????????",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20.0),
                              ViewModelBuilder<
                                      TransactionTypeViewModel>.reactive(
                                  viewModelBuilder: () =>
                                      TransactionTypeViewModel(),
                                  onModelReady: (model2) async {
                                    await model2.fetchTypes();
                                    model2.initSocket();
                                    model.setTransactionType(
                                        widget.transaction!.type!);
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
                                      return DropdownButtonFormField<
                                              TransactionType>(
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.green,
                                          ),

                                          //  value: model.transaction_type,

                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              filled: true,
                                              hintText: '?????? ??????????????'),
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
                                    hintText: "0 ??.??",
                                    filled: true,
                                    border: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.attach_money_outlined,
                                      color: Colors.green,
                                    )),
                              ),
                              SizedBox(height: 20.0),
                              InkWell(
                                onTap: () async {
                                  await model.updateTransaction(
                                      widget.transaction!.sId!,
                                      model.transaction_type.sId!,
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
                                            borderRadius:
                                                BorderRadius.circular(10)),

                                        // padding:

                                        //     EdgeInsets.fromLTRB(10, 0, 10, 0),

                                        child: Center(
                                          child: Text(
                                            '?????????? ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )),
                              ),
                              SizedBox(height: 20.0),
                              InkWell(
                                onTap: () async {
                                  print(model.remainingBalance.runtimeType);

                                  nav.push(PaymentPageRouter(
                                      amount: model.remainingBalance,
                                      trans: widget.transaction));
                                },
                                child:
                                    // model.isLoading
                                    //     ? Center(
                                    //         child: loadingWidget,
                                    //       )
                                    //     :

                                    Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10)),

                                        // padding:

                                        //     EdgeInsets.fromLTRB(10, 0, 10, 0),

                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '???????? ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(width: 10.0),
                                              Image.asset(
                                                'assets/images/done.png',
                                                height: 20,
                                                width: 20,
                                              )
                                            ],
                                          ),
                                        )),
                              ),
                            ],
                          )),
                    )),
                SizedBox(height: 10.0),
                Center(
                  child: Text(
                    "???????????? ????????????",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10.0),
                Expanded(
                    //      height: 500,
                    child: ViewModelBuilder<PaymentViewModel>.reactive(
                  viewModelBuilder: () => PaymentViewModel(),
                  onModelReady: (model2) async {
                    await model2.getPayments(widget.transaction!.sId!);
                    model2.initSocket();
                  },
                  builder: (context, model2, child) {
                    if (model2.isLoading) {
                      return Center(
                        child: loadingWidget,
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: model2.trans.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                                model2.trans[index].amount.toString() + " ??.??"),
                            subtitle: Text(
                                getFormattedDate(model2.trans[index].date!)),
                          ),
                        );
                      },
                    );
                  },
                ))
              ])),
    );
  }
}
