import 'dart:io';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Utils/db.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:final_project/Views/HomePageWorkersScreen.dart';
import 'package:flutter/material.dart';
import 'package:final_project/Views/RegisterScreen.dart';
import'package:final_project/Models/CheckLoginModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart' ;
import 'package:final_project/Utils/Utils.dart';
import 'package:final_project/Utils/clientConfig.dart';


import 'dart:convert';


void main() {
  runApp(const MyApp());


}

List<String> gender=<String>["male","Fammale"];
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Leen Shaieb'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {


    final _txtUserName = TextEditingController();
    final _txtPassword = TextEditingController();

    checkConction() async {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          // print('connected to internet');// print(result);// return 1;
        }
      } on SocketException catch (_) {
        // print('not connected to internet');// print(result);
        var uti = new Utils();
        uti.ShowMyDialog(context, "אין אינטרנט", "האפליקציה דורשת חיבור לאינטרנט, נא להתחבר בבקשה");
        return;
      }
    }


    checkSavedPars() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _txtUserName.text = prefs.get("userName").toString();
      _txtPassword.text = prefs.get("password").toString();
    }


    Future checkLogin(BuildContext context) async {
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //  String? getInfoDeviceSTR = prefs.getString("getInfoDeviceSTR");
      if(_txtPassword.text != "" && _txtUserName.text != "") {
        var url = "login/checkLogin.php?firstName=" + _txtUserName.text +
            "&password=" + _txtPassword.text;
        final response = await http.get(Uri.parse(serverPath + url));
        print(response);
        print(serverPath + url);
        // setState(() { });
        // Navigator.pop(context);
        if (checkLoginModel
            .fromJson(jsonDecode(response.body))
            .result == 0) {
          print("SharedPreferences 0");
          var uti = new Utils();
          uti.ShowMyDialog(context, "", "ת.ז ו/או הסיסמה שגויים");
        }
        else {
          //print("SharedPreferences 1");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('token', checkLoginModel
              .fromJson(jsonDecode(response.body))
              .result!);
          await prefs.setInt('userType', checkLoginModel
              .fromJson(jsonDecode(response.body))
              .userTypeID!);

          await prefs.setString('userName', _txtUserName.text);
          await prefs.setString('password', _txtPassword.text);


          if (checkLoginModel
              .fromJson(jsonDecode(response.body))
              .userTypeID == 1) {     // company
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  Homepagescreen(title: "HomePage")),
            );
          }
          else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  HomepageworkersScreen(title: "register")),
            );
          }
        }
      }
      else
        {
          var uti = new Utils();
          uti.ShowMyDialog(context, "", "you should fill in username and password");
        }
    }



    checkConction();

    checkSavedPars();


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "UserName",
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: _txtUserName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'UserName'
              ),
            ),
            Text(
              "Password",
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: _txtPassword,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Password'),
            ),


            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                checkLogin(context);

              },
              child: Text('sign in'),
            ),
            Text(
              "New Account?",
              style: TextStyle(fontSize: 20),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                Navigator.push(

                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const RegisterScreen(title: "register")),
                );
              },
              child: Text('Create new account'),
            ),

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
//                  insertUser(_txtUserName.text, _txtUserName.text, _txtUserName.text);