import 'package:flutter/material.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/core/viewmodels/account_viewModel.dart';
import 'package:mybooks/locstor.dart';
import 'package:stacked/stacked.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({Key? key}) : super(key: key);

  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  var _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var nav = locator.get<AppRouter>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              nav.pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.green,
            )),
      ),
      body: ViewModelBuilder<AccountViewModel>.reactive(
        viewModelBuilder: () => AccountViewModel(),
        onModelReady: (model) {
          model.initSocket();
        },
        builder: (context, model, child) => Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'حساب جديد',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        labelText: 'اسم صاحب الحساب',
                        labelStyle: TextStyle(color: Colors.green),
                      ),
                      validator: (str) {
                        if (str == null || str.length < 1) {
                          return "هذا الحقل مطلوب";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Visibility(
                      visible: model.isLoading,
                      child: LinearProgressIndicator(
                        color: Colors.green,
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.green,
                        child: Text('إضافة'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await model.addACcount(_nameController.text,
                                sharedPrefs.getUser().sId!);
                          }
                        },
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
