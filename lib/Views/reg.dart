import 'package:flutter/material.dart';
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
      home: const MyPage(title: 'Leen Shaieb'),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key, required this.title});


  final String title;

  @override
  State<MyPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyPage> {
  int _counter = 0;

  void _incrementCounter() {
   setState(() {

      _counter++;

    });
  }

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
