import 'package:final_project/Views/EditProfileScreen.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';
import 'package:final_project/Views/RegisterScreen.dart';
void main() {
  runApp(const MyApp());


}
//Leen
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

    return Scaffold(
      /*appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),*/
      body: Center(

         child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          Text("UserName",style:TextStyle( fontSize: 20),),
           TextField(decoration: InputDecoration(
               border: OutlineInputBorder(),
               hintText: 'UserName'),),


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
              onPressed: () {   Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Homepagescreen(title: "Homepage")),
              );},
              child: Text('sign in'),
            ),


            Text("New Account?",style:TextStyle( fontSize: 20),),

            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),

              ),
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen(title: "register")),
              );
              },
              child: Text('Create new account'),

            ),

           IconButton(
               icon:Icon(Icons.person),
               color: Colors.lightBlue,

               onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context)=>const Editprofilescreen(title: 'EditProfile'))
                 );
               },

           )

    /*TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Homepagescreen(title: "Homepage")),
                );
              },
              child: Text('Homepage'),
            )*/

    ],
    ),

      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
