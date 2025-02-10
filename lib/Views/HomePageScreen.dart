import 'dart:collection';
import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Views/AddJobScreen.dart';
import 'package:final_project/Views/EditjobScreen.dart';
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
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),

      body:
      ListView.builder(
        itemCount:listofjobs1.length,
        itemBuilder:(BuildContext context,int index)
        {
          return ListTile(
            //title: Text(listofjobs1[index].JobTitle),
            subtitle: Column(
              children:
              [
                Text('Job Title:${listofjobs1[index].JobTitle}'),
                Text('location :${listofjobs1[index].Location} '),
                Text('Description :${listofjobs1[index].Description} '),
                //Navigator.push(context, route)
                Row(

                  children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),

                  ),
                  onPressed: ()
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>EditJobScreen(title: 'EditJob',jb: listofjobs1[index],)),
                    );
                  },
                  child: Text('edit job'),),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),

                  ),
                  onPressed: ()
                  {


                  },
                  child: Text('workers'),
                ),
                  ]
                ),

              ],
            ),

          );
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
            label: 'Workers',
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



