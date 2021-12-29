import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mybooks/core/model/account.dart';
import 'package:mybooks/core/model/new_user.dart';
import 'package:mybooks/core/model/transaction.dart';
import 'package:mybooks/core/model/transaction_type.dart';
import 'package:mybooks/core/model/user.dart';
import 'package:mybooks/core/utils/failure.dart';

class Api {
  static const endpoint = 'http://192.168.8.172:7000';
  //'https://heroku-kururu-mybooks.herokuapp.com';

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

  static Future<Either<List<Transaction>, Failure>> fetchTransactions() async {
    try {
      var res = await http
          .get(
            Uri.parse(endpoint + "/transaction/all"),
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
                endpoint + "/transaction/user?uid=${uid}&user=${account}"),
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
}
