import 'dart:convert';
import 'package:flutter/material.dart';

class JobModel {
  JobModel({
    this.jobID="",
    this.JobName = "",
    this.Location = "",
    this.Description = "",
    this.companyID=0,
    this.JobNameID=0,
  });

  String jobID;
  String ? JobName;
  String Location;
  String Description;
  int? companyID;
  int? JobNameID;




  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      jobID: json['jobID'] ?? '',
      companyID: json['companyID']??0,
      JobName: json['jobName'],
      JobNameID: json['jobNameID']??0,
      Location: json['Location'] ?? '',
      Description: json['Description'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        "Location": Location,
        "Description": Description,
      };
}

































