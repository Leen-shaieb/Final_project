import 'dart:collection';
import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Views/AddJobScreen.dart';
import 'package:flutter/material.dart';

class Homepagescreen extends StatefulWidget {
  Homepagescreen({super.key, required this.title});

  final String title;

  @override
  State<Homepagescreen> createState() => HomepagescreenPageState();
}

class HomepagescreenPageState extends State<Homepagescreen> {
  List<JobModel> listofjobs1 = [
    JobModel(JobTitle: 'Programmer', Location: 'Microsoft'),
    JobModel(JobTitle: 'Programmer', Location: 'Checkpoint')
  ];

  @override
  //Widget build(BuildContext context) {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:
      ListView.builder(
        itemCount:listofjobs1.length,
        itemBuilder:(BuildContext context,int index){
          return Text(listofjobs1[index].PrintJobDetails());
        },
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Increment',
        onPressed: () {



          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>AddJobScreen(title: 'AddJobScreen')),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      // )

      /*
          Column(
            children: [
              ListView.builder(
                itemCount:listofjobs1.length,
                itemBuilder:(BuildContext context,int index){
                  return Text(listofjobs1[index].PrintJobDetails());
                },
                // This trailing comma makes auto-formatting nicer for build methods.
              ),
              Text("ddd"),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Increment',
        onPressed: (){},
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    )

       */
      // onPressed: null,
      // child: Text("dddd"))
      // ],
      // )
    );
  }
}


