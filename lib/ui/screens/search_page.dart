import 'package:flutter/material.dart';
import 'package:mybooks/core/model/user.dart';
import 'package:mybooks/core/utils/helper.dart';

class SearchPage extends StatefulWidget {
  final User? user;
  const SearchPage({Key? key, this.user}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _focuseNode = FocusNode();
  @override
  void initState() {
    _focuseNode.requestFocus();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: getLeadingWidget(context),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: SizedBox(
          height: 50,
          child: TextFormField(
            focusNode: _focuseNode,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'اسم صاحب الحساب',
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 2.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
