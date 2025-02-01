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


  });

  String FirstName;
  String LastName;
  String City;
  DateTime? BirthDate;
  String Email;
  String Degree;
  String University;
  String Password;





  factory UserModel.fromJson(Map<String, dynamic>json) =>
      UserModel(
        FirstName: json["FirstName"],
        LastName: json["LastName"],
        City: json["City"],
        BirthDate: json["BirthDate"],
        Email: json["Email"],
        Degree: json["Degree"],
        University: json["University"],
        Password: json["Password"],

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

      };
  String PrintUserDetails()
  {
    String str='';
    str= 'First Name '+ this.FirstName;
    str+= ' Degree: '+ this.Degree;
    return str;
  }
  UserModel1(String FirstName,String Degree)
  {
    this.Degree=Degree;
    this.FirstName=FirstName;
    this.LastName="";
    this.City="";
    this.BirthDate=null;
    this.Email="";
    this.University="";

  }


/*

  JobMode(String JobTitle,String Location)
      {
        this.JobTitle=JobTitle;
      this.Location=Location;
      }
 */
}

