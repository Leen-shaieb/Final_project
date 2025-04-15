import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Utils/Utils.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:final_project/Views/HomePageWorkersScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:final_project/Utils/clientConfig.dart';
import 'package:http/http.dart' as http;


class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key, required this.title, required this.profile});

  final String title;
  final UserModel profile;


  @override
  State<EditProfileScreen> createState() => EditProfileScreenPageState( );


}
late  JobModel? jb;

class EditProfileScreenPageState extends State<EditProfileScreen> {

  //final JobModel? jb;


  @override
  Widget build(BuildContext context) {
    final _txtFirstName = TextEditingController();
    final _txtLastName = TextEditingController();
    final _txtCity = TextEditingController();
    final _txtEmail = TextEditingController();
    final _txtDegree=TextEditingController();
    final _txtPassword=TextEditingController();
    final _txtRePassword=TextEditingController();


    Future UpdateProfile(BuildContext context) async {

      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //  String? getInfoDeviceSTR = prefs.getString("getInfoDeviceSTR");
      var url = "Job/updateJob.php?jobName=" +_txtJobTitle.text +"&Description=" + _txtDescription.text +"&Location="+ _txtLocation.text + "&jobID=" + widget.jb.jobID;
      final response = await http.get(Uri.parse(serverPath + url));
      print(serverPath + url);
      // setState(() { });
      // Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>Homepagescreen(title: 'HomePage')),
      );
    }




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

            Text("Email", style: TextStyle(fontSize: 20),),
            TextField(
              controller: _txtEmail,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email'),),

            Text("Degree:", style: TextStyle(fontSize: 20),),
            TextField(
              controller: _txtDegree,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Degree:',),),



            Text("C.V:", style: TextStyle(fontSize: 20),),
            TextField(decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'PDF File'),),

            Text("Password",style:TextStyle( fontSize: 20),),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password'),),

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
              child: Text('Save'),),


          ],
        ),
      ),
    );
  }
}
