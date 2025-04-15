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
    this.Password="",
    this.userType=2,

  });

  String FirstName;
  String LastName;
  String City;
  DateTime? BirthDate;
  String Email;
  String Degree;
  String University;
  String Password;
  int userType;

  factory UserModel.fromJson(Map<String, dynamic>json) =>
      UserModel(
        FirstName: json["firstName"],
        Email: json["email"],
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
        "Password": Password,
        "userType": userType,

      };



































































/*

  JobMode(String JobTitle,String Location)
      {
        this.JobTitle=JobTitle;
      this.Location=Location;
      }
 */
}

