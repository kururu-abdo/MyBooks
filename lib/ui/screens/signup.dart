import 'package:flutter/material.dart';
import 'package:mybooks/core/model/new_user.dart';
import 'package:mybooks/core/utils/colors.dart';
import 'package:mybooks/core/utils/sizes.dart';
import 'package:mybooks/core/viewmodels/signup_viewmodel.dart';
import 'package:mybooks/ui/screens/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stacked/stacked.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController placeNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ViewModelBuilder<SignUpViewModel>.reactive(
          viewModelBuilder: () => SignUpViewModel(),
          builder: (context, model, child) {
            return Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  title: Text('تسجيل مستخدم'),
                  centerTitle: true,
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                ),
                body: Padding(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: _formKey,
                      //      autovalidateMode: AutovalidateMode.,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'حساباتي',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 30),
                                )),
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'مستخدم جديد',
                                  style: TextStyle(fontSize: 20),
                                )),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'اسم المستخدم',
                                  labelStyle: TextStyle(color: Colors.green),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.green, width: 2.0),
                                  ),
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
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.green, width: 2.0),
                                  ),
                                  labelText: ' رقم الهاتف',
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
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: placeNameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.green, width: 2.0),
                                  ),
                                  labelStyle: TextStyle(color: Colors.green),
                                  labelText: 'اسم المحل',
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
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              margin: EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                obscureText: model.visibility ? true : false,
                                controller: passwordController,
                                validator: (str) {
                                  if (str == null || str.length < 1) {
                                    return "هذا الحقل مطلوب";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'كلمة المرور',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 2.0),
                                    ),
                                    labelStyle: TextStyle(color: Colors.green),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          print("Pressed");
                                          model
                                              .setVisibility(!model.visibility);
                                        },
                                        icon: Icon(
                                          model.visibility
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.black,
                                        ))),
                              ),
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
                                    width: double.infinity,
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            defaultRadius)),
                                    child: RaisedButton(
                                      textColor: Colors.white,
                                      color: Colors.green,
                                      child: Text('تسجيل الحساب'),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          var user = NewUser(
                                              nameController.text,
                                              phoneController.text,
                                              passwordController.text,
                                              placeNameController.text);

                                          await model.register(user);
                                        }
                                      },
                                    )),
                            Container(
                                child: Row(
                              children: <Widget>[
                                Text('هل لديك حساب بالفعل?'),
                                FlatButton(
                                  textColor: Colors.green,
                                  child: Text(
                                    'قم بستجيل الدخول',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(PageTransition(
                                        child: LoginForm(),
                                        type: PageTransitionType.leftToRight));
                                  },
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ))
                          ],
                        ),
                      ),
                    )));
          }),
    );
  }
}
