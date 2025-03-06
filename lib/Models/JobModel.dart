import 'dart:convert';
import 'package:flutter/material.dart';

class JobModel {
  JobModel({
    this.JobTitle = "",
    this.Location = "",
    this.Description = "",
  });

  String JobTitle;
  String Location;
  String Description;

  JobModel1(String JobTitle, String Location) {
    this.JobTitle = JobTitle;
    this.Location = Location;
  }

  String PrintJobDetails() {
    String str = '';
    str = 'JobTitle: ' + this.JobTitle;
    str += ' Location: ' + this.Location;
    return str;
  }

  ListTile Print() {
    return ListTile(
      title: Text(this.JobTitle),
      subtitle: Text('Location: ${this.Location}'),
      leading: CircleAvatar(
        child: Text(this.Description),
      ),
    );
  }
//

  /*
  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
        JobTitle: json["jobName"],
        Location: json["Location"],
        Description: json["Description"],
      );
*/

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      JobTitle: json['jobName'],
      Location: json['Location'],
      Description: json['Description'],


    );
  }



  // [{jobName":"\u05de\u05e4\u05ea\u05d7 \u05ea\u05d5\u05db\u05e0\u05d4","Location":"haifa","Description":"njknkl"},{"jobID":2,"jobName":"\u05d1\u05d5\u05d3\u05e7 \u05ea\u05d5\u05db\u05e0\u05d4","Location":"","Description":""},{"jobID":3,"jobName":"\u05e8\u05d0\u05e9 \u05e6\u05d5\u05d5\u05ea \u05ea\u05d5\u05db\u05e0\u05d4","Location":"","Description":""},{"jobID":4,"jobName":"\u05d0\u05e8\u05db\u05d8\u05d9\u05e7\u05d8","Location":"","Description":""},{"jobID":5,"jobName":"\u05e8\u05d0\u05e9 \u05e7\u05d1\u05d5\u05e6\u05d4","Location":"","Description":""}]
  Map<String, dynamic> toJson() => {
        "JobTitle": JobTitle,
        "Location": Location,
        "Description": Description,
      };
}
