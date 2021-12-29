import 'dart:convert';

import 'package:mybooks/core/model/account.dart';
import 'package:mybooks/core/model/transaction.dart';
import 'package:mybooks/core/services/api.dart';
import 'package:mybooks/core/utils/strams.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketServices {
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
      socket!.on('onAcccounts', onAcccounts);
      socket!.on('accounts-trans', accountTrans);
      socket!.on('add-account', addAccount);
      socket!.on('delete-account', deleteAccount);
      socket!.on('delete-trans', deleteTrans);
      socket!.on('update-account', updateAccount);
      socket!.on('last-trans', lastTrans);
      socket!.on('disconnect', (_) => print('disconnect'));
      socket!.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }
  }

  deleteAccount(data) {}

  addAccount(data) {}
  updateAccount(data) {
    var obj = json.decode(data.toString());
    Account account  = Account.fromJson(obj);
        StreamProvider<Account>().setData(account);

  }

  deleteTrans(data) {}
  onAcccounts(data) {
    Iterable I = json.decode(data.toString());
    List<Account> accounts = I.map((e) => Account.fromJson(e)).toList();

    StreamProvider<List<Account>>().setData(accounts);
  }

  accountTrans(data) {
    Iterable I = json.decode(data.toString());
    List<Transaction> trans = I.map((e) => Transaction.fromJson(e)).toList();

    StreamProvider<List<Transaction>>().setData(trans);
  }

  lastTrans(data) {
    Iterable I = json.decode(data.toString());
    List<Transaction> trans = I.map((e) => Transaction.fromJson(e)).toList();

    StreamProvider<List<Transaction>>().setData(trans);
  }

  // Send Location to Server
  sendLocation(Map<String, dynamic> data) {
    socket!.emit("location", data);
  }

  // Listen to Location updates of connected usersfrom server
  handleLocationListen(Map<String, dynamic> data) async {
    print(data);
  }

  void emit(String event, data) {
    socket!.emit(event, data);
  }

  // Send update of user's typing status
  sendTyping(bool typing) {
    socket!.emit("typing", {
      "id": socket!.id,
      "typing": typing,
    });
  }

  // Listen to update of typing status from connected users
  void handleTyping(Map<String, dynamic> data) {
    print(data);
  }

  // Send a Message to the server
  sendMessage(String message) {
    socket!.emit(
      "message",
      {
        "id": socket!.id,
        "message": message, // Message to be sent
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // Listen to all message events from connected users
  void handleMessage(Map<String, dynamic> data) {
    print(data);
  }
}
