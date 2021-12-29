import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mybooks/core/enums/toast_type.dart';
import 'package:mybooks/core/enums/view_state.dart';
import 'package:mybooks/core/model/new_user.dart';
import 'package:mybooks/core/model/transaction.dart';
import 'package:mybooks/core/services/api.dart';
import 'package:mybooks/core/services/toast_services.dart';
import 'package:mybooks/core/utils/failure.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/locstor.dart';
import 'package:mybooks/ui/screens/home.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:stacked/stacked.dart';

import '../../main.dart';

class UserTransactionsViewModel extends BaseViewModel {
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
      // socket!.on('onAcccounts', onAcccounts);
      socket!.on('account-trans', updateTrans);
           // socket!.on('account-trans', updateTrans);

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

  void emit(String event, data) {
    socket!.emit(event, data);
  }

  updateTrans(data) {
    print("EXPOSE NEW DATA");
    Iterable I = data;
    List<Transaction> trans = I.map((e) => Transaction.fromJson(e)).toList();

    _setTransactions(trans);
  }

  ViewState _state = ViewState.Idle;
  ViewState get state => _state;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _visibility = false;
  bool get visibility => _isLoading;
  _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  List<Transaction> _transactions = [];
  List<Transaction> get transactions => _transactions;

  _setTransactions(List<Transaction> trans) {
    _transactions = trans;
    notifyListeners();
  }

  Failure? _failure;
  Failure get failure => _failure!;

  _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  _setState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  setVisibility(bool val) {
    _visibility = val;
    notifyListeners();
  }

  addTransaction(
      String uid, String typeid, String account, double amount) async {
    _setLoading(true);
    var result = await Api.addTransaction(uid, typeid, account, amount);
    result.fold((l) {
      ToastServices.displayToast("تمت إصافة العملية بنجاح",
          type: ToastType.Success);
      // locator.get<AppRouter>().push(HomeRouter(), onFailure: (failure) {
      //   ToastServices.displayToast(failure.toString(), type: ToastType.Error);
      // });
      emit(
          "new-transaction", <String, dynamic>{"uid": uid, "account": account});
      _setLoading(false);
    }, (error) {
      ToastServices.displayToast(error.message, type: ToastType.Error);
      _setLoading(false);
      _setFailure(error);
    });
  }

  fetchTransactions(String uid, String account) async {
    _setLoading(true);
    _setState(ViewState.Busy);
    var result = await Api.fetchUserTransactions(uid, account);

    result.fold((l) {
      // locator.get<AppRouter>().push(HomeRouter(), onFailure: (failure) {
      //   ToastServices.displayToast(failure.toString(), type: ToastType.Error);
      // });
      _setTransactions(l);
      _setState(ViewState.Idle);
      _setLoading(false);
    }, (error) {
      ToastServices.displayToast(error.message, type: ToastType.Error);
      _setLoading(false);
      _setState(ViewState.Error);
      _setFailure(error);
    });
  }
}
