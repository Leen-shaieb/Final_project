import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Utils/Utils.dart';
import 'package:final_project/Utils/clientConfig.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Register2Screen extends StatefulWidget {
  Register2Screen ({super.key, required this.title, required this.lastStepUser});

  final String title;
  final UserModel lastStepUser;


  @override
  State<Register2Screen> createState() => Register2ScreenPageState( );


}
late  UserModel? _user;

class Register2ScreenPageState extends State<Register2Screen> {

  // final UserModel? user;

  @override
  Widget build(BuildContext context) {

    Future insertUser(BuildContext context, UserModel user) async {

      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //  String? getInfoDeviceSTR = prefs.getString("getInfoDeviceSTR");
      var url = "User/insertUser.php?firstName=" + user.FirstName + "&lastName=" + user.LastName +"&email="+ user.Email +"&password=" +user.Password +"&userType="+ "1";
      final response = await http.get(Uri.parse(serverPath + url));
      print(serverPath + url);
      // setState(() { });
      // Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>Homepagescreen(title: 'HomePage')),
      );
    }
     UserModel us= widget.lastStepUser;


    final _txtDegree=TextEditingController();
    final _txtPassword=TextEditingController();
    final _txtRePassword=TextEditingController();



    UserModel editUser(UserModel us)
    {
      us.Degree=_txtDegree.text;
      us.Password=_txtPassword.text;
      return us;
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
            TextField(
              controller: _txtDegree,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Degree:',),),

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

              UserModel newus =editUser(us);
              insertUser(context,newus );

              },
              child: Text('Register'),),


          ],
        ),
      ),
    );
  }
}


