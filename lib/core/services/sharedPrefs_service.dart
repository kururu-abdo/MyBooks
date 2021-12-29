import 'dart:convert';

import 'package:mybooks/core/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  static SharedPreferences get instance => _sharedPrefs!;

  static init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  void saveLoginState(bool state) {
    _sharedPrefs!.setBool("ISLOGGEDIN", state);
  }

  bool getLoginState() {
    var state = _sharedPrefs!.getBool("ISLOGGEDIN") ?? false;
    return state;
  }

  void saveUser(User user) {
    _sharedPrefs!.setString("USER", json.encode(user.toJson()));
  }

  User getUser() {
    var userStr = _sharedPrefs!.getString("USER");

    return User.fromJson(json.decode(userStr!));
  }
}

var sharedPrefs = SharedPrefs();
