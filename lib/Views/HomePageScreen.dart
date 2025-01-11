import 'dart:collection';

import 'package:final_project/Models/JobModel.dart';
import 'package:flutter/material.dart';


class Homepagescreen extends StatefulWidget {
   Homepagescreen ({super.key, required this.title});

  final String title;

  @override
  State<Homepagescreen> createState() => HomepagescreenPageState();
}

class HomepagescreenPageState extends State<Homepagescreen> {
  List<JobModel> listofjobs1=[
   JobModel (JobTitle:'Programmer',Location: 'Microsoft'),
    JobModel(JobTitle:'Programmer',Location: 'Checkpoint')
  ];
  @override
  //Widget build(BuildContext context) {
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),

      body:ListView.builder(
        itemCount:listofjobs1.length,

          itemBuilder:(BuildContext context,int index){
          return Text(listofjobs1[index].PrintJobDetails());
    },

      // This trailing comma makes auto-formatting nicer for build methods.

    ),);
  }
}
