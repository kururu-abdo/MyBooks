import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/helper.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/core/utils/styles.dart';
import 'package:mybooks/core/viewmodels/user_viewmodel.dart';
import 'package:mybooks/main.dart';
import 'package:mybooks/ui/widgets/circular_image_view.dart';
import 'package:mybooks/ui/widgets/confimtaion_dialoge.dart';
import 'package:stacked/stacked.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onTap: () {},
                      title: Text('تغيير كلمة المرور'),
                      subtitle: Text("*********"),
                    ),
                  ),
                ],
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nav.push(EditProfileRouter());
        },
        child: Icon(Icons.edit, color: Colors.white),
        backgroundColor: Colors.green,
      ),
    );
  }
}
