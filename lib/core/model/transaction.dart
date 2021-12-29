import 'package:mybooks/core/model/account.dart';
import 'package:mybooks/core/model/transaction_type.dart';
import 'package:mybooks/core/model/user.dart';

class Transaction {
  String? sId;
  int? amount;
  String? note;
  TransactionType? type;
  Account? account;
  User? userID;
  String? date;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Transaction(
      {this.sId,
      this.amount,
      this.note,
      this.type,
      this.account,
      this.userID,
      this.date,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Transaction.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    amount = json['amount'];
    note = json['note'];
    type = json['type'] != null ? new TransactionType.fromJson(json['type']) : null;
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
    userID =
        json['userID'] != null ? new User.fromJson(json['userID']) : null;
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['amount'] = this.amount;
    data['note'] = this.note;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    if (this.userID != null) {
      data['userID'] = this.userID!.toJson();
    }
    data['date'] = this.date;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}