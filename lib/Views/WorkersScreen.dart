import 'dart:collection';
import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Views/AddJobScreen.dart';
import 'package:final_project/Views/WorkersScreen.dart';
import 'package:flutter/material.dart';

class WorkersScreen extends StatefulWidget {
  WorkersScreen({super.key, required this.title});

  final String title;


  @override
  State<WorkersScreen> createState() => WorkersScreenPageState();

}

class WorkersScreenPageState extends State<WorkersScreen> {

List<UserModel> listofusers=[
  UserModel(FirstName: 'a',Degree: 'a'),
  UserModel(FirstName: 'b',Degree: 'b'),
];

  @override
  //Widget build(BuildContext context) {
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      ListView.builder(
        itemCount:listofusers.length,
        itemBuilder:(BuildContext context,int index){
          return Text(listofusers[index].PrintUserDetails());
        },
      ),
    );
  }
}



