import 'dart:convert';


class User {
  User({
    this.id = "",
    this.name = "",
    this.phone = "",
    this.address="",

  });

  String id;
  String name;
  String phone;
  String address;

  factory User.fromJson(Map<String, dynamic>json) =>
      User(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "phone": phone,
        "address":address,
      };
}
