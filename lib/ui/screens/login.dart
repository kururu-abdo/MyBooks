import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mybooks/core/utils/colors.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/core/viewmodels/login_viewmodel.dart';
import 'package:mybooks/core/viewmodels/signup_viewmodel.dart';
import 'package:mybooks/ui/screens/new_account.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';

class LoginForm extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LoginForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: onBackground)),
        ),
        body: ViewModelBuilder<LoginViewModel>.reactive(
          viewModelBuilder: () => LoginViewModel(),
          builder: (context, model, child) => Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'حساباتي',
                        style: TextStyle(
                            color: inColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                  Container(
                    height: 220,
                    child: Form(
                        child: Column(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(fontSize: 20),
                            )),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.green, width: 2.0),
                              ),
                              labelText: 'رقم الهاتف',
                              labelStyle: TextStyle(color: Colors.green),
                            ),
                            validator: (str) {
                              var rg = RegExp(r"^[0]{1}[1-9]{9}$");
                              if (!rg.hasMatch(str!)) {
                                return "رقم الهانف غير صالح";
                              }

                              if (str == null || str.length < 1) {
                                return "هذا الحقل مطلوب";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                                focusColor: Colors.green,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2.0),
                                ),
                                labelText: 'كلمة المرور',
                                labelStyle: TextStyle(color: Colors.green)),
                          ),
                        ),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FlatButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    textColor: Colors.green,
                    child: Text('هل نسيت كلمة المرور'),
                  ),
                  model.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: inColor,
                          ),
                        )
                      : Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.green,
                            child: Text('دخول'),
                            onPressed: () async {
                              await model.login(
                                  nameController.text, passwordController.text);
                            },
                          )),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Text('ليس لديك حساب?'),
                      FlatButton(
                        textColor: Colors.green,
                        child: Text(
                          'تسجيل حساب',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          //signup screen
                          AutoRouter.of(context).push(SignUpRouter());

                          // Navigator.of(context).push(PageTransition(
                          //     child: SignUp(), type: PageTransitionType.fade));
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ))
                ],
              )),
        ));
  }
}
