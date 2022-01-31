import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mybooks/core/model/transaction.dart';
import 'package:mybooks/core/utils/helper.dart';
import 'package:mybooks/core/utils/styles.dart';
import 'package:mybooks/core/viewmodels/payment_viewmodel.dart';
import 'package:mybooks/ui/widgets/app_title.dart';
import 'package:stacked/stacked.dart';

class PaymentPage extends StatefulWidget {
  final Transaction? trans;
  final double? amount;
  const PaymentPage({Key? key, this.trans, this.amount}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  var _formKey = GlobalKey<FormState>();
  var _priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'عملية سداد',
            style: titleStyle,
          ),
          leading: getLeadingWidget(context),
          backgroundColor: Colors.transparent,
          elevation: 0.0),
      body: Center(
        child: ViewModelBuilder<PaymentViewModel>.reactive(
          viewModelBuilder: () => PaymentViewModel(),
          onModelReady: (model) {
            model.initSocket();
          },
          builder: (context, model, child) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none)),
                              hintText: "0 ج.س",
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              suffixIcon: Icon(
                                Icons.attach_money_outlined,
                                color: Colors.green,
                              )),
                          validator: (str) {
                            if (str == "" || str!.length < 1) {
                              return "هذا الحقل مطلوب";
                            } else if (double.parse(str) > widget.amount!) {
                              return "المبلغ المدخل أكبر من مبلغ العملية";
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: () async {
                          log("AMOUNT:" + widget.amount!.toString());
                          if (_formKey.currentState!.validate()) {
                            print(widget.trans!.sId!);
                            await model.addPayment(widget.trans!.sId!,
                                double.parse(_priceController.text));
                          }
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
                                    borderRadius: BorderRadius.circular(25)),

                                // padding:

                                //     EdgeInsets.fromLTRB(10, 0, 10, 0),

                                child: Center(
                                  child: Text(
                                    ' إضافة عملية',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                      ),
                    ])),
          ),
        ),
      ),
    );
  }
}
