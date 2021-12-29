import 'package:flutter/material.dart';
import 'package:mybooks/core/enums/view_state.dart';
import 'package:mybooks/core/model/account.dart';
import 'package:mybooks/core/model/transaction_type.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/helper.dart';
import 'package:mybooks/core/viewmodels/login_viewmodel.dart';
import 'package:mybooks/core/viewmodels/transaction_type_viewmodel.dart';
import 'package:mybooks/core/viewmodels/trasnsaction_view_model.dart';
import 'package:mybooks/core/viewmodels/user_transactions_viewmodel.dart';
import 'package:mybooks/ui/widgets/transaction.dart';
import 'package:stacked/stacked.dart';

class AcccountDetails extends StatefulWidget {
  final Account? account;
  const AcccountDetails({Key? key, this.account}) : super(key: key);

  @override
  _AcccountDetailsState createState() => _AcccountDetailsState();
}

class _AcccountDetailsState extends State<AcccountDetails>
    with TickerProviderStateMixin {
  var _formKey = GlobalKey<FormState>();
  var _priceController = TextEditingController();
  AnimationController? _animationController;
  Animation<Offset>? _animation;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    _animation = Tween<Offset>(begin: Offset(0, -2), end: Offset(0, 0))
        .animate(_animationController!);

    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: Text(
                "تفاصيل الحساب",
                style: TextStyle(color: Colors.black),
              ),
              leading: getLeadingWidget(context)),
          body: ViewModelBuilder<TransactionViewModel>.reactive(
            viewModelBuilder: () => TransactionViewModel(),
            builder: (context, model, child) => Padding(
                padding: const EdgeInsets.all(8.0),
                // child: ViewModelBuilder<TransactionViewModel>.reactive(
                //   viewModelBuilder: () => TransactionViewModel(),
                //   builder: (context, model, child) {
                //     return ListView(
                //       children: [],
                //     );
                //   },
                // ),

                child: ListView(
                  children: [
                    Container(
                      height: 112,
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [Text("صافي الحساب"), Text("133 ج.س")],
                          ),
                          InkWell(
                            onTap: () {
                              _animationController!.forward();
                              model.setVisibility();
                            },
                            child: Container(
                              height: 40,
                              width: 92,
                              decoration: BoxDecoration(
                                  color: model.visibility
                                      ? Colors.red
                                      : Colors.green,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                  child: Text(
                                model.visibility ? "إخفاء" : "إضافة عملية",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Visibility(
                      visible: model.visibility,
                      child: SlideTransition(
                        position: _animation!,
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 20.0),
                                    ViewModelBuilder<
                                            TransactionTypeViewModel>.reactive(
                                        viewModelBuilder: () =>
                                            TransactionTypeViewModel(),
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
                                            return DropdownButtonFormField<
                                                    TransactionType>(
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
                                                            child: Text(
                                                                e.typeName!)))
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
                                            double.parse(
                                                _priceController.text));
                                      },
                                      child: Container(
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
                                              'إضافة',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ),
                                  ],
                                ))),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text("العمليات مع ${widget.account!.name!}")),
                    Container(
                      height: 400,
                      child:
                          ViewModelBuilder<UserTransactionsViewModel>.reactive(
                              viewModelBuilder: () =>
                                  UserTransactionsViewModel(),
                              onModelReady: (model3) async {
                                await model3.fetchTransactions(
                                    widget.account!.sId!,
                                    sharedPrefs.getUser().sId!);

                                model.initSocket();
                              },
                              builder: (context, model3, child) {
                                if (model3.state == ViewState.Busy) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.2,
                                      color: Colors.green,
                                    ),
                                  );
                                } else {
                                  print(model3.transactions.length);
                                  return ListView(
                                    physics: BouncingScrollPhysics(),
                                    children: model3.transactions
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
                              }),
                    )
                  ],
                )),
          ),
        ));
  }
}