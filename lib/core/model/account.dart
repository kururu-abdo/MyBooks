class Account {
  String? sId;
  String? name;

  Account({
    this.sId,
    this.name,
  });

  Account.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['accountName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['accountName'] = this.name;

    return data;
  }
}
