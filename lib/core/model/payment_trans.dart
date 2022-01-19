class PaymentTrans {
  int? amount;
  String? transID;
  String? sId;
  String? date;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PaymentTrans(
      {this.amount,
      this.transID,
      this.sId,
      this.date,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PaymentTrans.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    transID = json['transID'];
    sId = json['_id'];
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['transID'] = this.transID;
    data['_id'] = this.sId;
    data['date'] = this.date;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
