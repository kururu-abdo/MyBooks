import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mybooks/core/enums/toast_type.dart';
import 'package:mybooks/core/model/account.dart';
import 'package:mybooks/core/model/new_user.dart';
import 'package:mybooks/core/services/api.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/services/toast_services.dart';
import 'package:mybooks/core/utils/failure.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/locstor.dart';
import 'package:mybooks/ui/screens/home.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:stacked/stacked.dart';

import '../../main.dart';

class AccountViewModel extends BaseViewModel {
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
      socket!.on('update-account', updateAccount);
      socket!.on('delete-account', deleteAccount2);
      socket!.on('accounts', updateAccount);
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

  void deleteAccount2(data) {}
  void updateAccount(data) {
    Iterable I = data;
    List<Account> accounts = I.map((e) => Account.fromJson(e)).toList();
    _setAccounts(accounts);
  }

  void emit(String event, data) {
    socket!.emit(event, data);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _visibility = false;
  bool get visibility => _isLoading;
  List<Account> _acccounts = [];
  List<Account> get accounts => _acccounts;

  _setAccounts(List<Account> accounts) {
    _acccounts = accounts;
    notifyListeners();
  }

  _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Failure? _failure;
  Failure get failure => _failure!;

  _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  setVisibility(bool val) {
    _visibility = val;
    notifyListeners();
  }

  deleteAccount(String account) async {
    _setLoading(true);
    var result = await Api.deleteAccount(account);

    result.fold((l) {
      // _setAccounts(l);
      _setLoading(false);
      emit("update-account",
          <String, dynamic>{"uid": sharedPrefs.getUser().sId});
      // ToastServices.displayToast("تمت إضافة الحساب بنجاح",
      //     type: ToastType.Success);
    }, (error) {
      ToastServices.displayToast(error.message, type: ToastType.Error);
      _setLoading(false);
      _setFailure(error);
    });
  }

  fetcaAccounts(String uid) async {
    _setLoading(true);
    var result = await Api.fetchAccounts(uid);

    result.fold((l) {
      _setAccounts(l);
      _setLoading(false);
      // ToastServices.displayToast("تمت إضافة الحساب بنجاح",
      //     type: ToastType.Success);
    }, (error) {
      ToastServices.displayToast(error.message, type: ToastType.Error);
      _setLoading(false);
      _setFailure(error);
    });
  }

  addACcount(String accountName, String uid) async {
    _setLoading(true);
    var result = await Api.addAccount(accountName, uid);

    result.fold((l) {
      _setLoading(false);
      emit("update-account",
          <String, dynamic>{"uid": sharedPrefs.getUser().sId});
      ToastServices.displayToast("تمت إضافة الحساب بنجاح",
          type: ToastType.Success);
    }, (error) {
      ToastServices.displayToast(error.message, type: ToastType.Error);
      _setLoading(false);
      _setFailure(error);
    });
  }
}
