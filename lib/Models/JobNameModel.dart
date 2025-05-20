
import 'dart:convert';
import 'package:flutter/material.dart';

class JobNameModel {
  JobNameModel({
    this.JobName = "",
    this.JobNameID=0,
  });

  String ? JobName;
  int? JobNameID;




  factory JobNameModel.fromJson(Map<String, dynamic> json) {
    return JobNameModel(

      JobName: json['jobName'],
      JobNameID: json['JobNameID']??0,

    );
  }
  Map<String, dynamic> toJson() => {
    "jobName": JobName,
    "JobNameID":  JobNameID,
  };
}
