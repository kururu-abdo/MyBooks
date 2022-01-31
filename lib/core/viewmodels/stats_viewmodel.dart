import 'package:mybooks/core/enums/view_state.dart';
import 'package:mybooks/core/services/api.dart';
import 'package:mybooks/core/utils/failure.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:stacked/stacked.dart';

class StatsViewmodel extends BaseViewModel {
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
      socket!.on('net-amount', updateNetAmount);
      socket!.on('in-amount', updateInAMount);
      socket!.on('out-amount', updateOutAmount);
      socket!.on('month-amount', upadateMonthAmount);
      socket!.on('day-amount', upadateDayAmount);
      socket!.on('week-amount', upadateWeekAmount);

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

  void upadateWeekAmount(data) {
    print(data);
    _setWeeklyAmount(data);
  }

  void upadateDayAmount(data) {
    print(data);
    _setDailAmount(data);
  }

  void upadateMonthAmount(data) {
    print(data);
    _setmonthlAmount(data);
  }

  void updateOutAmount(data) {
    print(data);
    _setnoutAmount(data);
  }

  void updateInAMount(data) {
    _setinAmount(data);
  }

  void updateNetAmount(data) {
    print(data);
    _setnoutAmount(data);
  }

  void emit(String event, data) {
    print(data);
    socket!.emit(event, data);
  }

  dynamic _dailayAmount = 0.0;
  dynamic get dailayAmount => _dailayAmount;
  _setDailAmount(dynamic amount) {
    _dailayAmount = amount;
    notifyListeners();
  }

  dynamic _weeklyAmount = 0.0;
  dynamic get weeklyAmount => _weeklyAmount;
  _setWeeklyAmount(dynamic amount) {
    _weeklyAmount = amount;
    notifyListeners();
  }

  dynamic _monthlAmount = 0.0;
  dynamic get monthlAmount => _monthlAmount;
  _setmonthlAmount(dynamic amount) {
    _monthlAmount = amount;
    notifyListeners();
  }

  dynamic _inAmount = 0.0;
  dynamic get inAmount => _inAmount;
  _setinAmount(dynamic amount) {
    _inAmount = amount;
    notifyListeners();
  }

  dynamic _outAmount = 0.0;
  dynamic get outAmount => _outAmount;
  _setnoutAmount(dynamic amount) {
    _outAmount = amount;
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

//methods

  fetchInAmount(String uid) async {
    _setState(ViewState.Busy);
    var result = await Api.getInAmount(uid);

    result.fold((l) {
      print("-----DATA-----" + l.toString());
      _setState(ViewState.Idle);
      _setinAmount(l);
    }, (error) {
      _setState(ViewState.Error);
    });
  }

  fetchOutAmount(String uid) async {
    _setState(ViewState.Busy);
    var result = await Api.getOutAmount(uid);

    result.fold((l) {
      print("-----DATA-----" + l.toString());

      _setState(ViewState.Idle);
      _setnoutAmount(l);
    }, (error) {
      _setState(ViewState.Error);
    });
  }

  fetchTodayAmount(String uid) async {
    _setState(ViewState.Busy);
    var result = await Api.getTodayAmount(uid);

    result.fold((l) {
      print("-----DATA-----" + l.toString());

      _setState(ViewState.Idle);
      _setDailAmount(l);
    }, (error) {
      _setState(ViewState.Error);
    });
  }

  fetchWeekAmount(String uid) async {
    _setState(ViewState.Busy);
    var result = await Api.getWeekAmount(uid);

    result.fold((l) {
      print("-----DATA-----" + l.toString());

      _setState(ViewState.Idle);
      _setWeeklyAmount(l);
    }, (error) {
      _setState(ViewState.Error);
    });
  }

  fetchMonthAmount(String uid) async {
    _setState(ViewState.Busy);
    var result = await Api.getMonthAmount(uid);

    result.fold((l) {
      print("-----DATA-----" + l.toString());

      _setState(ViewState.Idle);
      _setmonthlAmount(l);
    }, (error) {
      _setState(ViewState.Error);
    });
  }
}
