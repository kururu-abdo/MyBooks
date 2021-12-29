class NewUser {
  final String name;
  final String phone;
  final String password;
  final String placeName;

  NewUser(this.name, this.phone, this.password, this.placeName);

  Map<String, dynamic> toJson() =>
      {'name': name, 'phone': phone, 'password': password, 'place': placeName};
      
}
