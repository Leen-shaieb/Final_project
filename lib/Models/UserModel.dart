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
    this.Degree="",
    this.University="",
    this.Password="",
    this.userType=2,
    this.companyID=0,

  });

  String FirstName;
  String LastName;
  String City;
  //DateTime? BirthDate;
  String Email;
  String Degree;
  String University;
  String Password;
  int userType;
  int companyID;

  factory UserModel.fromJson(Map<String, dynamic>json) =>
      UserModel(
        FirstName: json["firstName"],
        LastName: json["firstName"] ,
        Email: json["email"],
        //Degree: json["email"],
        //University: json["email"],
        Password: json["password"],
        companyID: json["companyID"]??0,


      );

  Map<String, dynamic> toJson() =>
      {
        "FirstName":FirstName,
        "LastName": LastName,
        "City": City,
        //"BirthDate": BirthDate,
        "Email": Email,
        "Degree": Degree,
        "Uninversity": University,
        "Password": Password,
        "userType": userType,
        " companyID":  companyID,

      };



































































/*

  JobMode(String JobTitle,String Location)
      {
        this.JobTitle=JobTitle;
      this.Location=Location;
      }
 */
}

