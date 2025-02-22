import 'dart:collection';
import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Views/AddJobScreen.dart';
import 'package:final_project/Views/EditProfileScreen.dart';
import 'package:final_project/Views/JobDetails.dart';
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
  UserModel us= new UserModel();

  List<JobModel> listofjobs1 =
  [
    JobModel(JobTitle: 'Programmerrrrr', Location: 'Microsoft',Description: 'xzzzz'),
    JobModel(JobTitle: 'Programmer', Location: 'Ca',Description: 'xzzzz'),
    JobModel(JobTitle: 'Programmer', Location: 'Ca',Description: 'xzzzz')
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
        MaterialPageRoute(builder: (context) =>EditProfileScreen(title: 'EditProfileScreen',profile:us)),
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

        //title: Text(widget.title),
        actions: <Widget>[
    IconButton(
    icon: const Icon(Icons.person),

      onPressed: ()
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>EditProfileScreen(title: 'edit profile',profile: us,)),
        );
      },
    ),
    ]
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

              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),

                ),
                onPressed: ()
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>JobDetailsScreen(title: 'EditJob',jb: listofjobs1[index],)),
                  );

                },
                child: Text('Details'),),
            ],
          ),

        );
        },
    ),

    );
  }
}



