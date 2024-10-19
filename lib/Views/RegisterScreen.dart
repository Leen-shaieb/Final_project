import 'package:final_project/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';





class Registerscreen extends StatefulWidget {
  const Registerscreen ({super.key, required this.title});


  final String title;

  @override
  State<Registerscreen> createState() => RegisterscreenPageState();
}

class RegisterscreenPageState extends State<Registerscreen> {
  int _counter = 0;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),

      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Homepagescreen (title: "HomePage")),
                );
              },
              child: Text('Homepage'),
            ),


            ListView(
              children: const <Widget>[

                ListTile(
                  title: Text('UserName:'),
                ),
                ListTile(

                  title: Text('email:'),
                ),
                ListTile(
                  title: Text('Phone:'),
                ),

              ],
            ),


          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
