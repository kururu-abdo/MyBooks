import 'package:mybooks/core/model/payment_trans.dart';
import 'package:mybooks/core/services/api.dart';
import 'package:mybooks/core/services/sharedPrefs_service.dart';
import 'package:mybooks/core/utils/failure.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:stacked/stacked.dart';

class PaymentViewModel extends BaseViewModel {
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
      socket!.on('remains', deleteAccount2);
      socket!.on('payments', updateAccount);
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

  void deleteAccount2(data) {
    var result = data['amount'];
    
  }

  void updateAccount(data) {
    Iterable I = data;
    List<PaymentTrans> paymentTrans =
        I.map((e) => PaymentTrans.fromJson(e)).toList();
    _setTrans(paymentTrans);
  }

  List<PaymentTrans> _trans = [];
  List<PaymentTrans> get trans => _trans;
  _setTrans(List<PaymentTrans> trans) {
    _trans = trans;
    notifyListeners();
  }

  void emit(String event, data) {
    socket!.emit(event, data);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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

  //add pament

  addPayment(String trans, double amount) async {
    _setLoading(true);
    var result = await Api.addPaymentTransaction(trans, amount);
    result.fold((done) {
      emit("payment", <String, dynamic>{"transId": trans});

      // sharedPrefs.getUser().sId!
      _setLoading(false);
    }, (error) {
      _setLoading(false);
      _setFailure(error);
    });
  }

  // all payment

  getPayments(String trans) async {
    _setLoading(true);
    var result = await Api.fetchPaymentTRans(trans);
    result.fold((done) {
      _setLoading(false);
      _setTrans(done);
    }, (error) {
      _setLoading(false);
      _setFailure(error);
    });
  }
}
