import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Utils/db.dart';
import 'package:final_project/Views/EditProfileScreen.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:final_project/Views/HomePageWorkersScreen.dart';
import 'package:flutter/material.dart';
import 'package:final_project/Views/RegisterScreen.dart';
import 'package:mysql1/mysql1.dart';

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
    void Navi(int id)
    {
      if(id==0)
        {Navigator.push(context,   MaterialPageRoute(
            builder: (context) =>
             Homepagescreen(title: "Homepage ")),);
        }
      if(id==1)
      {Navigator.push(context,   MaterialPageRoute(
          builder: (context) =>
              HomepageworkersScreen(title: "Homepage ")),);
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
                UserModel us=new UserModel(FirstName: _txtUserName.text,Password: _txtPassword.text);
              int type=0 ;
              //type =user.type
              Navi(type);
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
                insertUser("Leen", "shaieb", "123");
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