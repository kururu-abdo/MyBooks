import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mybooks/core/model/account.dart';
import 'package:mybooks/core/model/new_user.dart';
import 'package:mybooks/core/model/payment_trans.dart';
import 'package:mybooks/core/model/transaction.dart';
import 'package:mybooks/core/model/transaction_type.dart';
import 'package:mybooks/core/model/user.dart';
import 'package:mybooks/core/utils/failure.dart';

class Api {
  static const endpoint = 'http://192.168.8.172:7000';
  //  'https://heroku-kururu-mybooks.herokuapp.com';

  static Future<Either<User, Failure>> SignUser(NewUser user) async {
    try {
      var res = await http
          .post(Uri.parse(endpoint + "/user/add"), body: user.toJson())
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        print(res.body);
        User user = User.fromJson(json.decode(res.body));
        return Left(user);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" هذا الهاتف مستخدم من قبل شخص اخر "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<User, Failure>> loign(
      String phone, String password) async {
    try {
      var res = await http
          .get(
            Uri.parse(
                endpoint + "/user/login?phone=${phone}&password=${password}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        print(res.body);
        User user = User.fromJson(json.decode(res.body));
        return Left(user);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" خطأ في  الهاتف أو كلمة المرور "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<Account, Failure>> addAccount(
      String accountName, String uid) async {
    try {
      var res = await http.post(Uri.parse(endpoint + "/accounts/add"),
          body: <String, dynamic>{
            "name": accountName,
            "uid": uid
          }).timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        print(res.body);
        Account account = Account.fromJson(json.decode(res.body));
        return Left(account);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" غير مصرح لك بإجراء العملية "));
      } else if (res.statusCode == 404) {
        return Right(CustomUnauthorizedException(" هذا الحساب موجود بالفعل  "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<Account, Failure>> deleteAccount(
      String account_id) async {
    try {
      var res = await http.post(Uri.parse(endpoint + "/accounts/delete"),
          body: <String, dynamic>{
            "id": account_id,
          }).timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        print(res.body);
        Account account = Account.fromJson(json.decode(res.body));
        return Left(account);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" غير مصرح لك بإجراء العملية "));
      } else if (res.statusCode == 404) {
        return Right(CustomUnauthorizedException(" هذا الحساب موجود بالفعل  "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<dynamic, Failure>> deleteTransaction(String uid) async {
    try {
      var res = await http.post(Uri.parse(endpoint + "/transaction/delete"),
          body: <String, dynamic>{
            "id": uid,
          }).timeout(Duration(seconds: 12));
      if (res.statusCode == 200) {
        print(json.decode(res.body).runtimeType);

        return Left(res.body);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" غير مصرح لك بإجراء العملية "));
      } else if (res.statusCode == 404) {
        return Right(CustomUnauthorizedException(" هذا الحساب موجود بالفعل  "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<List<Account>, Failure>> fetchAccounts(
      String uid) async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint + "/accounts/all?uid=${uid}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        Iterable body = json.decode(res.body);
        List<Account> accounts = body.map((e) => Account.fromJson(e)).toList();
        return Left(accounts);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" غير مصرح لك بإجراء العملية "));
      } else if (res.statusCode == 404) {
        return Right(CustomUnauthorizedException(" هذا الحساب موجود بالفعل  "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<List<TransactionType>, Failure>>
      fetchTransactionTypes() async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint + "/transaction/types"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        Iterable body = json.decode(res.body);
        List<TransactionType> accounts =
            body.map((e) => TransactionType.fromJson(e)).toList();
        return Left(accounts);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" غير مصرح لك بإجراء العملية "));
      } else if (res.statusCode == 404) {
        return Right(CustomUnauthorizedException(" هذا الحساب موجود بالفعل  "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<List<Transaction>, Failure>> fetchTransactions(
      String uid) async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint + "/transaction/all?uid=${uid}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        Iterable body = json.decode(res.body);
        List<Transaction> trans =
            body.map((e) => Transaction.fromJson(e)).toList();
        return Left(trans);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" غير مصرح لك بإجراء العملية "));
      } else if (res.statusCode == 404) {
        return Right(CustomUnauthorizedException(" هذا الحساب موجود بالفعل  "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<List<Transaction>, Failure>> fetchLastTransactions(
      String uid) async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint + "/transaction/last?uid=${uid}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        Iterable body = json.decode(res.body);
        List<Transaction> trans =
            body.map((e) => Transaction.fromJson(e)).toList();
        return Left(trans);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" غير مصرح لك بإجراء العملية "));
      } else if (res.statusCode == 404) {
        return Right(CustomUnauthorizedException(" هذا الحساب موجود بالفعل  "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<List<Transaction>, Failure>> fetchUserTransactions(
      String uid, String account) async {
    try {
      var res = await http
          .get(
            Uri.parse(
                endpoint + "/transaction/user?uid=${uid}&account=${account}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        Iterable body = json.decode(res.body);
        List<Transaction> trans =
            body.map((e) => Transaction.fromJson(e)).toList();
        return Left(trans);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" غير مصرح لك بإجراء العملية "));
      } else if (res.statusCode == 404) {
        return Right(CustomUnauthorizedException(" هذا الحساب موجود بالفعل  "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<dynamic, Failure>> addTransaction(
      String uid, String typeid, String account, double amount) async {
    try {
      var res = await http.post(Uri.parse(endpoint + "/transaction/add"),
          body: <String, dynamic>{
            "amount": amount.toString(),
            "user": uid,
            "account": account,
            "note": "",
            "type": typeid,
          }).timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        print(res.body);
        //  User user = User.fromJson(json.decode(res.body));
        return Left(res.body);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" هذا الهاتف مستخدم من قبل شخص اخر "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<dynamic, Failure>> updqtaeTransaction(
      String trans_id, String typeid, double amount) async {
    try {
      var res = await http.post(Uri.parse(endpoint + "/transaction/update"),
          body: <String, dynamic>{
            "amount": amount.toString(),
            "id": trans_id,
            "note": "",
            "type": typeid,
          }).timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        print(res.body);
        //  User user = User.fromJson(json.decode(res.body));
        return Left(res.body);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" هذا الهاتف مستخدم من قبل شخص اخر "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<dynamic, Failure>> getUserNetAmount(
      String uid, String account) async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint +
                "/transaction/user/net-amount?uid=${uid}&account=${account}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        var result = json.decode(res.body);

        return Left(result["net_amount"]);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" خطأ في  الهاتف أو كلمة المرور "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<dynamic, Failure>> getNetAmount(String uid) async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint + "/transaction/me/net-amount?uid=${uid}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        var result = json.decode(res.body);

        return Left(result["net_amount"]);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" خطأ في  الهاتف أو كلمة المرور "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<List<Account>, Failure>> searchAccounts(
      String q, String uid) async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint + "/accounts/search?uid=${uid}&q=${q}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        Iterable body = json.decode(res.body);
        List<Account> accounts = body.map((e) => Account.fromJson(e)).toList();
        return Left(accounts);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" غير مصرح لك بإجراء العملية "));
      } else if (res.statusCode == 404) {
        return Right(CustomUnauthorizedException(" هذا الحساب موجود بالفعل  "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<dynamic, Failure>> getInAmount(String uid) async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint + "/transaction/in?uid=${uid}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        var result = json.decode(res.body);

        return Left(result["amount"]);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" خطأ في  الهاتف أو كلمة المرور "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<dynamic, Failure>> getOutAmount(String uid) async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint + "/transaction/out?uid=${uid}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        var result = json.decode(res.body);

        return Left(result["amount"]);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" خطأ في  الهاتف أو كلمة المرور "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<dynamic, Failure>> getMonthAmount(String uid) async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint + "/transaction/month?uid=${uid}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        var result = json.decode(res.body);

        return Left(result["amount"]);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" خطأ في  الهاتف أو كلمة المرور "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<dynamic, Failure>> getWeekAmount(String uid) async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint + "/transaction/week?uid=${uid}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        var result = json.decode(res.body);

        return Left(result["amount"]);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" خطأ في  الهاتف أو كلمة المرور "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<dynamic, Failure>> getTodayAmount(String uid) async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint + "/transaction/today?uid=${uid}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        var result = json.decode(res.body);

        return Left(result["amount"]);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" خطأ في  الهاتف أو كلمة المرور "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<dynamic, Failure>> getAccountNetAmount(
      String uid, String account) async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint +
                "/transaction/user/net-amount?uid=${uid}&account=${account}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        var result = json.decode(res.body);

        return Left(result["net_amount"]);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" خطأ في  الهاتف أو كلمة المرور "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<User, Failure>> getUser(String uid) async {
    try {
      var res = await http
          .get(Uri.parse(endpoint + "/user/profile?uid=${uid}"))
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        print(res.body);
        User user = User.fromJson(json.decode(res.body));
        return Left(user);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" هذا الهاتف مستخدم من قبل شخص اخر "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<User, Failure>> updateUser(User user) async {
    try {
      var res = await http
          .post(Uri.parse(endpoint + "/user/update"), body: <String, dynamic>{
        'id': user.sId,
        'name': user.name,
        'place_name': user.placeName,
        'phone': user.phone,
        'password': user.password
      }).timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        print(res.body);
        User user = User.fromJson(json.decode(res.body));
        return Left(user);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" هذا الهاتف مستخدم من قبل شخص اخر "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<dynamic, Failure>> addPaymentTransaction(
      String trans, double amount) async {
    try {
      var res = await http
          .post(Uri.parse(endpoint + "/payment/add"), body: <String, dynamic>{
        "amount": amount.toString(),
        "transId": trans,
      }).timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        print(res.body);
        //  User user = User.fromJson(json.decode(res.body));
        return Left(res.body);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" هذا الهاتف مستخدم من قبل شخص اخر "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<List<PaymentTrans>, Failure>> fetchPaymentTRans(
      String trans) async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint + "/payment/all?transId=${trans}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        Iterable body = json.decode(res.body);
        List<PaymentTrans> accounts =
            body.map((e) => PaymentTrans.fromJson(e)).toList();
        return Left(accounts);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" غير مصرح لك بإجراء العملية "));
      } else if (res.statusCode == 404) {
        return Right(CustomUnauthorizedException(" هذا الحساب موجود بالفعل  "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<dynamic, Failure>> getReminingBalance(
      String trans) async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint + "/payment/remain?transID=${trans}"),
          )
          .timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        return Left(json.decode(res.body)['amount']);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" غير مصرح لك بإجراء العملية "));
      } else if (res.statusCode == 404) {
        return Right(CustomUnauthorizedException(" هذا الحساب موجود بالفعل  "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<dynamic, Failure>> updateStatus(
      String trans, String status) async {
    try {
      var res = await http.post(Uri.parse(endpoint + "/transaction/mark-done"),
          body: <String, dynamic>{
            "transId": trans,
            "status": status
          }).timeout(Duration(seconds: 12));

      if (res.statusCode == 200) {
        print(json.decode(res.body));
        return Left(json.decode(res.body));
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" غير مصرح لك بإجراء العملية "));
      } else if (res.statusCode == 404) {
        return Right(CustomUnauthorizedException(" هذا الحساب موجود بالفعل  "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }

  static Future<Either<dynamic, Failure>> updatePassword(
      String pwd, String uid) async {
    try {
      var res = await http.post(Uri.parse(endpoint + "/user/update-password"),
          body: <String, dynamic>{
            "uid": uid,
            "password": pwd
          }).timeout(Duration(seconds: 12));
      if (res.statusCode == 200) {
        return Left(res.body);
      } else if (res.statusCode == 500 ||
          res.statusCode == 501 ||
          res.statusCode == 503) {
        return Right(CustomServerException("خطأ في الخادم"));
      } else if (res.statusCode == 403) {
        return Right(
            CustomUnauthorizedException(" غير مصرح لك بإجراء العملية "));
      } else if (res.statusCode == 404) {
        return Right(CustomUnauthorizedException(" هذا الحساب موجود بالفعل  "));
      } else {
        return Right(UnknownException("خطأ غير معروف"));
      }
    } on TimeoutException {
      return Right(CustomTimeoutException("انتهت مهلة الاتصال"));
    } on SocketException {
      print("Done");
      return Right(CustomConnectionException(" تأكد من الاتصال بالانترنت"));
    } catch (e) {
      print(e.toString());
      return Right(UnknownException("خطأ غير معروف"));
    }
  }
}
