import 'dart:convert';
import 'package:flutter/material.dart';



class UserModel {


  UserModel(
  {

    this.FirstName="",
    this.LastName="",
    this.City="",
    //this.BirthDate=null,
    this.Email="",
    this.DegreeID=0,
    this.University="",
    this.Password="",
    this.userType=2,
    this.companyID=0,
    this.userID=0,
    this.CV="",
    this.Degree="",

  });

  String FirstName;
  String LastName;
  String City;
 String CV;
  String Email;
  int DegreeID;
  String University;
  String Password;
  int userType;
  int companyID;
  String Degree;
int userID;
  factory UserModel.fromJson(Map<String, dynamic>json) =>
      UserModel(
        FirstName: json["firstName"],
        LastName: json["LastName"]??"" ,
        Email: json["email"],
        //Degree: json["email"],
        //University: json["email"],
        Password: json["password"],
        companyID: json["companyID"]??0,
          DegreeID: json["DegreeID"]??0,
        userID: json["userID"]??0,
      CV: json["CV"]??"",

      );

  Map<String, dynamic> toJson() =>
      {
        "FirstName":FirstName,
        "LastName": LastName,
        "city": City,
        //"BirthDate": BirthDate,
        "Email": Email,
        "DegreeID": DegreeID,
        "Uninversity": University,
        "Password": Password,
        "userType": userType,
        " companyID":  companyID,
        "Degree":Degree,

      };


}

