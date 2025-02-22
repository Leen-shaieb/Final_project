import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Utils/Utils.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:final_project/Views/HomePageWorkersScreen.dart';
import 'package:flutter/material.dart';



class JobDetailsScreen extends StatefulWidget {
  JobDetailsScreen({super.key, required this.title, required this.jb});

  final String title;
  final JobModel jb;


  @override
  State<JobDetailsScreen> createState() => JobDetailsScreenPageState( );


}
late  JobModel? jb;

class JobDetailsScreenPageState extends State<JobDetailsScreen> {

  //final JobModel? jb;


  @override
  Widget build(BuildContext context) {
    final _txtFirstName = TextEditingController();
    final _txtLastName = TextEditingController();
    final _txtCity = TextEditingController();
    final _txtEmail = TextEditingController();






    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("First Name:", style: TextStyle(fontSize: 20),),
            TextField(
              controller:_txtFirstName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'First Name'),
            ),

            Text("Last Name:", style: TextStyle(fontSize: 20),),
            TextField(
              controller: _txtLastName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Last Name'),),

            Text("City:", style: TextStyle(fontSize: 20),),
            TextField(
              controller: _txtCity,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'City'),),

            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),

              ),
              onPressed: () {
                //Edit();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>HomepageworkersScreen(title: 'HomePage')),
                );
              },
              child: Text('Apply'),),


          ],
        ),
      ),
    );
  }
}
