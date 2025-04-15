import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Utils/Utils.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:final_project/Utils/clientConfig.dart';


class EditJobScreen extends StatefulWidget {
 EditJobScreen({super.key, required this.title, required this.jb});

  final String title;
  final JobModel jb;


  @override
  State<EditJobScreen> createState() => EditJobScreenPageState( );


}
late  JobModel? jb;

class EditJobScreenPageState extends State<EditJobScreen> {

   //final JobModel? jb;


  @override
  Widget build(BuildContext context) {
    final _txtJobTitle=TextEditingController();
    final _txtLocation=TextEditingController();
    final _txtDescription=TextEditingController();

    JobModel jb= widget.jb;

void Save()
    {
      _txtJobTitle.text=jb.JobName;
      _txtLocation.text=jb.Location;
      _txtDescription.text=jb.Description;

    }

    Future UpdateJob(BuildContext context) async {

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


Save();
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("JobTitle:", style: TextStyle(fontSize: 20),),
            TextField(
              controller: _txtJobTitle,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'JobTitle:'),),

            Text("Location:", style: TextStyle(fontSize: 20),),
            TextField(
              controller: _txtLocation,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Location:'),),

            Text("Description:", style: TextStyle(fontSize: 20),),
            TextField(
              controller: _txtDescription,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Description'),),

            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),

              ),
              onPressed: () {
                UpdateJob(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Homepagescreen(title: 'HomePage')),
                );
              },
              child: Text('Save'),),


          ],
        ),
      ),
    );
  }
}
