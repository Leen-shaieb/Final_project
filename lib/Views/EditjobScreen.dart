import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Utils/Utils.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';



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

    void Edit()
    {
      if(jb==null)
        return;
      if(jb!=null)
      {
        if (_txtJobTitle.text != '')
        {
          //jb.JobTitle=_txtJobTitle.text;
        }
        if (_txtLocation.text != '')
        {
          //jb.Location=_txtLocation.text;
        }
        if (_txtDescription.text != '')
        {
          //jb.Description=_txtDescription.text;
        }
      }
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
                //Edit();
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
