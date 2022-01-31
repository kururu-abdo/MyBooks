import 'package:flutter/material.dart';
import 'package:mybooks/core/model/user.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/colors.dart';
import 'package:mybooks/core/utils/helper.dart';
import 'package:mybooks/core/utils/sizes.dart';
import 'package:mybooks/core/utils/styles.dart';
import 'package:mybooks/core/viewmodels/user_viewmodel.dart';
import 'package:stacked/stacked.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController placeNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserViewModel>.reactive(
        onModelReady: (model) async {
          model.initSocket();

          await model.fetchUser(sharedPrefs.getUser().sId!);
          nameController.text = model.user.name!;
          placeNameController.text = model.user.placeName!;
          phoneController.text = model.user.phone!;
        },
        viewModelBuilder: () => UserViewModel(),
        builder: (context, model, child) {
          if (model.isLoading) {
            return Material(
              child: Center(
                child: loadingWidget,
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
                leading: getLeadingWidget(context),
                backgroundColor: Colors.transparent,
                elevation: 0.0),
            body: Center(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Form(
                      key: _formKey,
                      //      autovalidateMode: AutovalidateMode.,
                      child: SingleChildScrollView(
                          child: Column(children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'حساباتي',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 30),
                            )),
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'تعديل الحساب',
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
                              var rg = RegExp(r"^[0]{1}[0-9]{9}$");
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
                        // Container(
                        //   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        //   margin: EdgeInsets.only(bottom: 10),
                        //   child: TextFormField(
                        //     obscureText: model.visibility ? true : false,
                        //     controller: passwordController,
                        //     validator: (str) {
                        //       if (str == null || str.length < 1) {
                        //         return "هذا الحقل مطلوب";
                        //       } else {
                        //         return null;
                        //       }
                        //     },
                        //     decoration: InputDecoration(
                        //         border: OutlineInputBorder(),
                        //         labelText: 'كلمة المرور',
                        //         focusedBorder: OutlineInputBorder(
                        //           borderSide: const BorderSide(
                        //               color: Colors.green, width: 2.0),
                        //         ),
                        //         labelStyle: TextStyle(color: Colors.green),
                        //         suffixIcon: IconButton(
                        //             onPressed: () {
                        //               print("Pressed");
                        //               model
                        //                   .setVisibility(!model.visibility);
                        //             },
                        //             icon: Icon(
                        //               model.visibility
                        //                   ? Icons.visibility_off
                        //                   : Icons.visibility,
                        //               color: Colors.black,
                        //             ))),
                        //   ),
                        // ),
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
                                    borderRadius:
                                        BorderRadius.circular(defaultRadius)),
                                child: RaisedButton(
                                  textColor: Colors.white,
                                  color: Colors.green,
                                  child: Text('تحديث البيانات '),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      var user = model.user;
                                      user.name = nameController.text;
                                      user.placeName = placeNameController.text;
                                      user.phone = phoneController.text;

                                      await model.editUser(user);
                                    }
                                  },
                                ))
                      ])))),
            ),
          );
        });
  }
}
