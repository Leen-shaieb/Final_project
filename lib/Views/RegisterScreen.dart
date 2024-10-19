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
          Text("Email",style:TextStyle( fontSize: 20),),
           TextField(decoration: InputDecoration(
               border: OutlineInputBorder(),
               hintText: 'Email'),),


          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
