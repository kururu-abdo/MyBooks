import 'package:flutter/material.dart';
import 'package:mybooks/core/model/account.dart';
import 'package:mybooks/core/utils/helper.dart';

class TransactionPage extends StatefulWidget {
  final Account? account;
  const TransactionPage({Key? key, this.account}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(widget.account!.name!),
        leading: getLeadingWidget(context),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          )),
    );
  }
}
