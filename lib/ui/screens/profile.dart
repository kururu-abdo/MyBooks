import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/colors.dart';
import 'package:mybooks/core/utils/helper.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/core/utils/sizes.dart';
import 'package:mybooks/core/utils/styles.dart';
import 'package:mybooks/core/viewmodels/signup_viewmodel.dart';
import 'package:mybooks/core/viewmodels/user_viewmodel.dart';
import 'package:mybooks/main.dart';
import 'package:mybooks/ui/widgets/circular_image_view.dart';
import 'package:mybooks/ui/widgets/confimtaion_dialoge.dart';
import 'package:stacked/stacked.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  VoidCallback? _showPersBottomSheetCallBack;
  AnimationController? controller;
  Animation<Offset>? animation;
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));

    animation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.5, 0.0),
    ).animate(controller!);
    _showPersBottomSheetCallBack = _showPersistentBottomSheet;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  void _showPersistentBottomSheet() {
    setState(() {
      _showPersBottomSheetCallBack = null;
    });
    _scaffoldKey.currentState!
        .showBottomSheet((context) {
          return new Container(
            height: 300.0,
            child: new Center(
              child: new Text("Persistent BottomSheet",
                  textScaleFactor: 2,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            //Anim
            controller!.forward();
            setState(() {
              _showPersBottomSheetCallBack = _showPersistentBottomSheet;
            });
          }
        });
  }

  var _formKey = GlobalKey<FormState>();

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          // ignore: unnecessary_new
          return new Container(
              height: 300.0,
              child: ViewModelBuilder<SignUpViewModel>.reactive(
                viewModelBuilder: () => SignUpViewModel(),
                builder: (context, model, child) => Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                                    model.setVisibility(!model.visibility);
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
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius)),
                              child: RaisedButton(
                                textColor: Colors.white,
                                color: Colors.green,
                                child: Text('تحديث كلمة المرور'),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    print(passwordController.text);
                                    await model.updatePassword(
                                        sharedPrefs.getUser().sId!,
                                        passwordController.text);
                                  }
                                },
                              )),
                    ],
                  ),
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar:
          AppBar(backgroundColor: Colors.transparent, elevation: 0.0, actions: [
        RaisedButton.icon(
          icon: Icon(Icons.logout),
          label: Text('تسجيل خروج'),
          onPressed: () async {
            confirmationDialog(context, 'هل تريد تسجيل الخروج',
                onOkBtnPressed: () async {
              sharedPrefs.saveLoginState(false);
              sharedPrefs.clear();
              nav.replaceAll([LoginFormRouter()]);
            });
          },
        )
      ]),
      body: ViewModelBuilder<UserViewModel>.reactive(
          onModelReady: (model) async {
            model.initSocket();
            await model.fetchUser(sharedPrefs.getUser().sId!);
          },
          viewModelBuilder: () => UserViewModel(),
          builder: (context, model, child) {
            if (model.isLoading) {
              return Center(
                child: loadingWidget,
              );
            } else {
              return ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CircularImage(
                    user: model.user,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    margin: EdgeInsets.all(10.0),
                    elevation: 0.5,
                    child: ListTile(
                      title: Text('اسم المستخدم'),
                      subtitle: Text(model.user.name!),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(10.0),
                    elevation: 0.5,
                    child: ListTile(
                      title: Text('اسم المحل'),
                      subtitle: Text(model.user.placeName!),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(10.0),
                    elevation: 0.5,
                    child: ListTile(
                      title: Text('رقم الهاتف'),
                      subtitle: Text(model.user.phone!),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(10.0),
                    elevation: 0.5,
                    child: ListTile(
                      onTap: _showModalSheet,
                      title: Text('تغيير كلمة المرور'),
                      subtitle: Text("*********"),
                    ),
                  ),
                ],
              );
            }
          }),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).padding.bottom == 0,
        child: SlideTransition(
          position: animation!,
          child: FloatingActionButton(
            onPressed: () {
              nav.push(EditProfileRouter());
            },
            child: Icon(Icons.edit, color: Colors.white),
            backgroundColor: Colors.green,
          ),
        ),
      ),
    );
  }
}
