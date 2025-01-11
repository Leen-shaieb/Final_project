import 'dart:convert';
import 'package:flutter/material.dart';



class UserModel {



  UserModel(
  {

    this.FirstName="",
    this.LastName="",
    this.City="",
    this.BirthDate=null,
    this.Email="",
    this.Degree="",
    this.University="",


  });
  String FirstName;
  String LastName;
  String City;
  DateTime? BirthDate;
  String Email;
  String Degree;
  String University;

  factory UserModel.fromJson(Map<String, dynamic>json) =>
      UserModel(
        FirstName: json["FirstName"],
        LastName: json["LastName"],
        City: json["City"],
        BirthDate: json["BirthDate"],
        Email: json["Email"],
        Degree: json["Degree"],
        University: json["University"],

      );

  Map<String, dynamic> toJson() =>
      {
        "FirstName":FirstName,
        "LastName": LastName,
        "City": City,
        "BirthDate": BirthDate,
        "Email": Email,
        "Degree": Degree,
        "Uninversity": University,

      };
}

