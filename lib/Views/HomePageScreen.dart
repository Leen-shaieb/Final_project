import 'dart:collection';
import 'dart:convert';
import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Views/AddJobScreen.dart';
import 'package:final_project/Views/EditjobScreen.dart';
import 'package:final_project/Views/WorkersScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:final_project/Utils/clientConfig.dart';

class Homepagescreen extends StatefulWidget {
  Homepagescreen({super.key, required this.title});

  final String title;

  @override
  State<Homepagescreen> createState() => HomepagescreenPageState();
}

class HomepagescreenPageState extends State<Homepagescreen> {
  var _selectedIndex = 0;

  /*
  List<JobModel> listofjobs1 = [
    JobModel(JobTitle: 'Programmer', Location: 'Microsoft'),
    JobModel(JobTitle: 'Programmer', Location: 'Checkpoint')
  ];
   */
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddJobScreen(title: 'AddJobScreen')),
      );
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WorkersScreen(title: 'WorkersScreen')),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  //Widget build(BuildContext context) {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: FutureBuilder(
        future: getJobs(),
        builder: (context, projectSnap) {
          if (projectSnap.hasData) {
            if (projectSnap.data.length == 0) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 2,
                child: Align(
                    alignment: Alignment.center,
                    child: Text('אין תוצאות',
                        style: TextStyle(fontSize: 23, color: Colors.black))),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                    itemCount: projectSnap.data.length,
                    itemBuilder: (context, index) {
                      JobModel project = projectSnap.data[index];

                      return Card(
                          child: ListTile(
                        // enabled: false,
                        onTap: () {},
                        title: Text(
                          project.JobTitle!.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ), // Icon(Icons.timer),

                            subtitle: Text(
                              "[" + project.Location! + "]" + "\n",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                        isThreeLine: false,
                      ));
                    },
                  )),
                ],
              );
            }
          } else if (projectSnap.hasError) {
            print(projectSnap.error);
            return Center(
                child: Text('שגיאה, נסה שוב',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
          }
          return Center(
              child: new CircularProgressIndicator(
            color: Colors.red,
          ));
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'new job',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Workers',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),

      // onPressed: null,
      // child: Text("dddd"))
      // ],
      // )
    );
  }

  Future getJobs() async {
    var url = "/Job/getJobs.php";
    print(serverPath + url);

    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    List<JobModel> arr = [];

    for (Map<String, dynamic> i in json.decode(response.body)) {
      if(JobModel.fromJson(i).Location=="Microsoft")
        arr.add(JobModel.fromJson(i));
    }
    return arr;
  }
}
