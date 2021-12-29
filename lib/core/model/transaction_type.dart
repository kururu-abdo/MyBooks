class TransactionType {
  String? sId;
  String? typeName;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TransactionType(
      {this.sId, this.typeName, this.createdAt, this.updatedAt, this.iV});

  TransactionType.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    typeName = json['typeName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['typeName'] = this.typeName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
