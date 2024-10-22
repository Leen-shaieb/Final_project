import 'package:final_project/Views/HomePageScreen.dart';
import 'package:final_project/Views/Register2Screen.dart';
import 'package:flutter/material.dart';





class Editprofilescreen extends StatefulWidget {
  const Editprofilescreen ({super.key, required this.title});


  final String title;

  @override
  State<Editprofilescreen> createState() => EditprofilescreenPageState();
}

class EditprofilescreenPageState extends State<Editprofilescreen> {



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

            Icon(
                Icons.person),






          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
