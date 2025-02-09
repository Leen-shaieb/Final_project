import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Utils/Utils.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';



class Editjobscreen extends StatefulWidget {
 Editjobscreen({super.key, required this.title, required this.jb});

  final String title;
  final JobModel jb;


  @override
  State<Editjobscreen> createState() => EditjobscreenPageState();


}
late  JobModel? _user;

class EditJobscreenPageState extends State<EdotJobscreen> {

  // final UserModel? user;


  @override
  Widget build(BuildContext context) {
    final _txtPassword=TextEditingController();
    final _txtRePassword=TextEditingController();
    // if(_txtRePassword.text!=_txtPassword&&_txtRePassword!="")
    //{
    //    var uti=new Utils();
    // uti.ShowMyDialog(context, 'Wrong Password', '');


    // }


    insertUserFunc()
    {
      //this.lastStepUser;
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



            Text("Degree:", style: TextStyle(fontSize: 20),),
            TextField(decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Degree:'),),

            Text("University:", style: TextStyle(fontSize: 20),),
            TextField(decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'University:'),),

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

            Text("Retype Password",style:TextStyle( fontSize: 20),),
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

                insertUserFunc();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Homepagescreen(title: 'HomePage')),
                );
              },
              child: Text('Finish'),),


          ],
        ),
      ),
    );
  }
}
