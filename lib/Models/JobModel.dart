import 'dart:convert';
import 'package:flutter/material.dart';

class JobModel {

 JobModel(
      {
        this.JobTitle="",
        this.Location="",
        this.Description="",
      });

  String JobTitle;
  String Location;
  String Description;


  JobMode(String JobTitle,String Location)
      {
        this.JobTitle=JobTitle;
      this.Location=Location;
      }

  String PrintJobDetails()
  {
  String str='';
  str= 'JobTitle: '+ this.JobTitle;
  str+= ' Location: '+ this.Location;
  return str;
  }

 factory JobModel.fromJson(Map<String, dynamic>json) =>
     JobModel(
       JobTitle: json["JobTitle"],
       Location: json["Location"],
       Description: json["Description"],

     );

 Map<String, dynamic> toJson() =>
     {
       "JobTitle":JobTitle,
       "Location": Location,
       "Description": Description,

     };
}

