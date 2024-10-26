import 'dart:convert';


class User {
  User({
    this.id = "",
    this.name = "",
    this.phone = "",


  });

  String id;
  String name;
  String phone;

  factory User.fromJson(Map<String, dynamic>json) =>
      User(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "phone": phone,
      };
}
