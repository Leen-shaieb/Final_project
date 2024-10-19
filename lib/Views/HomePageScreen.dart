import 'package:flutter/material.dart';


class Homepagescreen extends StatefulWidget {
  const Homepagescreen ({super.key, required this.title});

  final String title;

  @override
  State<Homepagescreen> createState() => HomepagescreenPageState();
}

class HomepagescreenPageState extends State<Homepagescreen> {


  @override
  //Widget build(BuildContext context) {
    Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),

      body:
         ListView(

           children:const [
          Text('Item1',style: TextStyle(fontSize: 30,color: Colors.blueAccent
          ),
          ),
             Text("-------------------------------",style:TextStyle(fontSize:50,color: Colors.pinkAccent)),

             Text('Item2'),
             Text('Item3'),
           ],
         )

      // This trailing comma makes auto-formatting nicer for build methods.


    );
  }
}
