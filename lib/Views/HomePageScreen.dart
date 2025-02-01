import 'dart:collection';
import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Views/AddJobScreen.dart';
import 'package:final_project/Views/WorkersScreen.dart';
import 'package:flutter/material.dart';

class Homepagescreen extends StatefulWidget {
  Homepagescreen({super.key, required this.title});

  final String title;


  @override
  State<Homepagescreen> createState() => HomepagescreenPageState();

}

class HomepagescreenPageState extends State<Homepagescreen> {
  var _selectedIndex=0;

  List<JobModel> listofjobs1 = [
    JobModel(JobTitle: 'Programmer', Location: 'Microsoft'),
    JobModel(JobTitle: 'Programmer', Location: 'Checkpoint')
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
        MaterialPageRoute(builder: (context) =>WorkersScreen(title: 'WorkersScreen')),
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
        // This trailing comma makes auto-formatting nicer for build methods.
      ),

      /*floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Increment',
        onPressed: () {



          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>AddJobScreen(title: 'AddJobScreen')),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),*/

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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



