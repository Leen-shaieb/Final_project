import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Utils/db.dart';
import 'package:final_project/Views/EditProfileScreen.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';
import 'package:final_project/Views/RegisterScreen.dart';

void main()
{
  runApp(const MyApp());


}


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
      home: const AddJobScreen(title: 'Leen Shaieb'),
    );
  }
}

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key, required this.title});

  final String title;

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _txtTitleJob = TextEditingController();
    final _txtLocation = TextEditingController();
    final _txtDescription = TextEditingController();
    JobModel createjob()
    {
      var jb=new JobModel();
      jb.JobTitle=_txtTitleJob.text;
      jb.Location=_txtLocation.text;
      jb.Description=_txtDescription.text;
      return jb;
    }


    return Scaffold(
      /*appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),*/
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Title Job:", style: TextStyle(fontSize: 20),),
            TextField(
              controller:_txtTitleJob,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title Job'),),


              Text("Location:", style: TextStyle(fontSize: 20),),
              TextField(
                controller:_txtLocation,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Location'),
            ),
            Text("Description:", style: TextStyle(fontSize: 20),),
            TextField(
              controller:_txtDescription,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description'),),

            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),

              ),
              onPressed: () {
               var jb=createjob();
               insertJob(jb);

              },
              child: Text('Add'),),



          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
