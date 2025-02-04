import 'dart:collection';
import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Views/AddJobScreen.dart';
import 'package:final_project/Views/EditProfileScreen.dart';
import 'package:final_project/Views/WorkersScreen.dart';
import 'package:flutter/material.dart';

class HomepageworkersScreen extends StatefulWidget {
  HomepageworkersScreen ({super.key, required this.title});

  final String title;


  @override
  State<HomepageworkersScreen > createState() => HomepageworkersScreenPageState();

}

class HomepageworkersScreenPageState extends State<HomepageworkersScreen > {
  var _selectedIndex=0;

  List<JobModel> listofjobs1 = [
    JobModel(JobTitle: 'Programmer', Location: 'Microsoft'),
    JobModel(JobTitle: 'Programmer', Location: 'Ca')
  ];
  void _onItemTapped(int index)
  {
    if(index == 0)
    {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>AddJobScreen(title: 'AddJobScreen')),
      );
    }
    if(index == 1)
    {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>Editprofilescreen(title: 'EditProfileScreen')),
      );
    }
    setState(()
    {
      _selectedIndex = index;
    });
  }
  @override
  //Widget build(BuildContext context) {
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      ListView.builder(
        itemCount:listofjobs1.length,
        itemBuilder:(BuildContext context,int index){
          return Text(listofjobs1[index].PrintJobDetails());
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'new job',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'edit Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),





      // onPressed: null,
      // child: Text("dddd"))
      // ],
      // )
    );
  }
}



