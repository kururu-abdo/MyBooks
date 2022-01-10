import 'dart:convert';
import 'dart:math';

import 'package:mybooks/core/enums/toast_type.dart';
import 'package:mybooks/core/model/user.dart';
import 'package:mybooks/core/services/api.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/services/toast_services.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:stacked/stacked.dart';

class UserViewModel extends BaseViewModel {
  Socket? socket;
  void initSocket() {
    try {
      // Configure socket transports must be sepecified
      socket = io(Api.endpoint, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      // Connect to websocket
      socket!.connect();

      // Handle socket events
      socket!.on('connect', (_) => print('connect: ${socket!.id}'));
      // socket!.on('location', handleLocationListen);
      // socket!.on('typing', handleTyping);
      // socket!.on('message', handleMessage);
      socket!.on('user-new-data', updateUser);
      // socket!.on('delete-account', deleteAccount2);
      // socket!.on('accounts', updateAccount);
      // socket!.on('onAcccounts', onAcccounts);
      // socket!.on('accounts-trans', accountTrans);
      // socket!.on('add-account', addAccount);
      // socket!.on('delete-account', deleteAccount);
      // socket!.on('delete-trans', deleteTrans);
      // socket!.on('update-account', updateAccount);
      // socket!.on('last-trans', lastTrans);
      socket!.on('disconnect', (_) => print('disconnect'));
      socket!.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }
  }

  void updateUser(data) {
    User user = User.fromJson(data);
    _setUser(user);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _user;
  User get user => _user!;
  _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  _setUser(User u) {
    _user = u;
    notifyListeners();
  }

  void emit(String event, data) {
    socket!.emit(event, data);
  }

  fetchUser(String uid) async {
    _setLoading(true);
    var result = await Api.getUser(uid);

    result.fold((l) {
      _setLoading(false);
      _setUser(l);
    }, (error) {
      ToastServices.displayToast(error.message, type: ToastType.Error);
      _setLoading(false);
    });
  }

  editUser(User user) async {
    print(user.toJson().toString());
    _setLoading(true);
    var result = await Api.updateUser(user);

    result.fold((l) {
      print('USER DATA' + l.toJson().toString());
      _setLoading(false);
      sharedPrefs.saveUser(l);
      emit('update-user',
          <String, dynamic>{'phone': l.phone, 'password': l.password});
      ToastServices.displayToast('تم تحديث البيانات بنجاح',
          type: ToastType.Success);
    }, (error) {
      ToastServices.displayToast(error.message, type: ToastType.Error);
      _setLoading(false);
    });
  }
}
