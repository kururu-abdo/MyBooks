import 'package:flutter/material.dart';
import 'package:mybooks/core/enums/view_state.dart';
import 'package:mybooks/core/model/user.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/helper.dart';
import 'package:mybooks/core/utils/styles.dart';
import 'package:mybooks/core/viewmodels/account_viewModel.dart';
import 'package:mybooks/ui/screens/user_transaction.dart';
import 'package:stacked/stacked.dart';

class SearchPage extends StatefulWidget {
  final User? user;
  const SearchPage({Key? key, this.user}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _focuseNode = FocusNode();
  var _controller = TextEditingController();
  @override
  void initState() {
    // _focuseNode.requestFocus();

    super.initState();
  }

  @override
  void dispose() {
    //  _focuseNode.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ViewModelBuilder<AccountViewModel>.reactive(
        viewModelBuilder: () => AccountViewModel(),
        builder: (context, model, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: getLeadingWidget(context),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: SizedBox(
              height: 50,
              child: TextFormField(
                focusNode: _focuseNode,
                onChanged: (str) async {
                  await model.searchAccount(
                      str.trim(), sharedPrefs.getUser().sId!);
                },
                onFieldSubmitted: (str) async {
                  await model.searchAccount(
                      str.trim(), sharedPrefs.getUser().sId!);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'اسم  الحساب',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.green, width: 2.0),
                  ),
                ),
              ),
            ),
          ),
          body: Builder(builder: (context) {
            if (model.isLoading) {
              return Center(
                child: loadingWidget,
              );
            } else {
              if (model.foundedAcccounts.length >= 1) {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: model.foundedAcccounts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(10.0),
                        elevation: 0.5,
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserTransaction(
                                      account: model.foundedAcccounts[index],
                                    )));
                          },
                          title: Text(model.foundedAcccounts[index].name!),
                        ),
                      );
                    });
              } else {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/empty_list.gif'),
                      Text('لا توجد نتائج')
                    ]);
              }
            }
          }),
        ),
      ),
    );
  }
}
