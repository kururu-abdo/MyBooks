import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mybooks/core/enums/toast_type.dart';
import 'package:mybooks/core/enums/view_state.dart';
import 'package:mybooks/core/model/new_user.dart';
import 'package:mybooks/core/model/transaction.dart';
import 'package:mybooks/core/model/transaction_type.dart';
import 'package:mybooks/core/services/api.dart';
import 'package:mybooks/core/services/toast_services.dart';
import 'package:mybooks/core/utils/failure.dart';
import 'package:mybooks/core/utils/routes/router.dart';
import 'package:mybooks/locstor.dart';
import 'package:mybooks/ui/screens/home.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:stacked/stacked.dart';

import '../../main.dart';

class TransactionTypeViewModel extends BaseViewModel {





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



  void emit(String event, data) {
    socket!.emit(event, data);
  }










  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _visibility = false;
  bool get visibility => _isLoading;
  List<TransactionType> _transaction_types = [];
  List<TransactionType> get transaction_types => _transaction_types;


  _setTypes(List<TransactionType> types) {
    _transaction_types = types;
    notifyListeners();
  }

  _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  ViewState _state = ViewState.Idle;
  ViewState get state => _state;
  _setState(ViewState state) {
    _state = state;
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

  fetchTypes() async {
    _setState(ViewState.Busy);
    _setLoading(true);
    var result = await Api.fetchTransactionTypes();

    result.fold((types) {
      _setTypes(types);
      _setLoading(false);
    }, (error) {
      _setLoading(false);
      _setFailure(error);
    });
  }

}
