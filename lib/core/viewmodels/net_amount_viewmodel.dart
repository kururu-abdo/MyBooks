import 'package:mybooks/core/enums/view_state.dart';
import 'package:mybooks/core/services/api.dart';
import 'package:mybooks/core/utils/failure.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:stacked/stacked.dart';

class NetAmountViewmodel extends BaseViewModel {
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
      socket!.on('net-amount', updateNetAmount);

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

  void updateNetAmount(data) {
    _setAmount(data);
  }

  void emit(String event, data) {
    socket!.emit(event, data);
  }

  ViewState _state = ViewState.Idle;
  ViewState get state => _state;
  _setState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  Failure? _failure;
  Failure get failure => _failure!;
  dynamic _amount = 0.0;
  dynamic get amount => _amount;

  _setAmount(dynamic amount) {
    _amount = amount;
    notifyListeners();
  }

  _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  fetchNetAmount(String uid) async {
    _setState(ViewState.Busy);
    var result = await Api.getNetAmount(uid);

    result.fold((amount) {
      _setAmount(amount);

      _setState(ViewState.Idle);
    }, (error) {
      _setState(ViewState.Error);
      _setFailure(error);
    });
  }
}
