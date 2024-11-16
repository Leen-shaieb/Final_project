import 'dart:convert';


class User {
  User({
    /*this.id = "",
    this.name = "",
    this.phone = "",
    this.address="",*/
this.LastName="",

  });

  String FirstName;
  String LastName;
  DateTime BithDate;
  String Email;
  String Degree;
  String University;


  factory User.fromJson(Map<String, dynamic>json) =>
      User(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() =>
      {

      };
}
