import 'package:final_project/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';

class Register2Screen extends StatefulWidget {
  const Register2Screen ({super.key, required this.title});

  final String title;

  @override
  State<Register2Screen> createState() => Register2ScreenPageState();
}

class Register2ScreenPageState extends State<Register2Screen> {


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

            Text("PassWord:", style: TextStyle(fontSize: 20),),
            TextField(decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'PassWord'),),



          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
