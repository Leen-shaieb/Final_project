import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Utils/Utils.dart';
import 'package:final_project/Utils/clientConfig.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



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

    Future insertUser(BuildContext context, String firstName, String lastName) async {

      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //  String? getInfoDeviceSTR = prefs.getString("getInfoDeviceSTR");
      var url = "users/insertUser.php?firstName=" + firstName + "&lastName=" + lastName;
      final response = await http.get(Uri.parse(serverPath + url));
       //print(serverPath + url);
      setState(() { });
      Navigator.pop(context);
    }


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


                insertUser(context, '', '');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Homepagescreen(title: 'HomePage')),

                );
              },
              child: Text('Register'),),


          ],
        ),
      ),
    );
  }
}
