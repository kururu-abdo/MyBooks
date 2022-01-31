import 'package:mybooks/core/enums/toast_type.dart';
import 'package:mybooks/core/enums/view_state.dart';
import 'package:mybooks/core/model/transaction.dart';
import 'package:mybooks/core/model/transaction_type.dart';
import 'package:mybooks/core/services/api.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/services/toast_services.dart';
import 'package:mybooks/core/utils/failure.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:stacked/stacked.dart';

import '../../main.dart';

class LastTransactionViewModel extends BaseViewModel {
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
      socket!.on('last-trans', updateTrans);
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

  updateTrans(data) {
    Iterable I = data;
    List<Transaction> trans = I.map((e) => Transaction.fromJson(e)).toList();

    _setlastTransactions(trans);
  }

  void emit(String event, data) {
    socket!.emit(event, data);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;
  bool _visibility = false;
  bool get visibility => _visibility;
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

  List<Transaction> _lastTransactions = [];
  List<Transaction> get lastTransactions => _lastTransactions;

  _setlastTransactions(List<Transaction> trans) {
    _lastTransactions = trans;
    notifyListeners();
  }

  TransactionType? _transaction_type;
  TransactionType get transaction_type => _transaction_type!;

  setTransactionType(TransactionType type) {
    _transaction_type = type;
    notifyListeners();
  }

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

  setVisibility() {
    _visibility = !_visibility;
    print(_visibility);
    notifyListeners();
  }

  // addTransaction() async {
  //   _setState(ViewState.Busy);
  // }
  deleteTransaction(String uid) async {
    _setLoading(true);
    _setState(ViewState.Busy);
    var result = await Api.deleteTransaction(uid);

    result.fold((l) {
      // locator.get<AppRouter>().push(HomeRouter(), onFailure: (failure) {
      //   ToastServices.displayToast(failure.toString(), type: ToastType.Error);
      // });
      ToastServices.displayToast('تم حذف العملية بنجاح',
          type: ToastType.Success);

      _setState(ViewState.Idle);
      _setLoading(false);
      nav.pop();
      emit("refresh", <String, dynamic>{"uid": sharedPrefs.getUser().sId!});
    }, (error) {
      ToastServices.displayToast(error.message, type: ToastType.Error);
      _setLoading(false);
      _setState(ViewState.Error);
      _setFailure(error);
    });
  }

  fetchLastTransactions(String uid) async {
    _setLoading(true);
    _setState(ViewState.Busy);
    var result = await Api.fetchLastTransactions(uid);

    result.fold((l) {
      // locator.get<AppRouter>().push(HomeRouter(), onFailure: (failure) {
      //   ToastServices.displayToast(failure.toString(), type: ToastType.Error);
      // });
      _setlastTransactions(l);
      _setState(ViewState.Idle);
      _setLoading(false);
    }, (error) {
      ToastServices.displayToast(error.message, type: ToastType.Error);
      _setLoading(false);
      _setState(ViewState.Error);
      _setFailure(error);
    });
  }

  bool isIn(Transaction tr) {
    return tr.type!.typeName == "مدين";
  }
}
