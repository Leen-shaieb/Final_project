import 'dart:collection';
import 'dart:convert';
import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Views/AddJobScreen.dart';
import 'package:final_project/Views/EditProfileScreen.dart';
import 'package:final_project/Views/JobDetails.dart'; // استيراد صفحة تفاصيل الوظيفة
import 'package:final_project/Views/WorkersScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:final_project/Utils/clientConfig.dart';

class HomepageworkersScreen extends StatefulWidget {
  HomepageworkersScreen({super.key, required this.title});

  final String title;

  @override
  State<HomepageworkersScreen> createState() =>
      HomepageworkersScreenPageState();
}

class HomepageworkersScreenPageState extends State<HomepageworkersScreen> {
  var _selectedIndex = 0;
  UserModel us = new UserModel();

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
            builder: (context) =>
                EditProfileScreen(title: 'EditProfileScreen', profile: us)),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      title: 'edit profile',
                      profile: us,
                    )),
              );
            },
          ),
        ],
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
                  child: Text(
                    'אין תוצאות',
                    style: TextStyle(fontSize: 23, color: Colors.black),
                  ),
                ),
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
                            onTap: () {
                              // الانتقال إلى صفحة تفاصيل الوظيفة عند النقر
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobDetailsScreen(title:"jobdetails", jb:project),
                                ),
                              );
                            },
                            title: Text(
                              project.JobName!.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            subtitle: Text(
                              "[" + project.Location! + "]" + "\n",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            isThreeLine: false,
                          ),
                        );
                      },
                    ),
                  ),
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
            ),
          );
        },
      ),
    );
  }
}

Future getJobs() async {
  var url = "/Job/getJobs.php";
  print(serverPath + url);

  final response = await http.get(Uri.parse(serverPath + url));
  print(serverPath + url);
  List<JobModel> arr = [];

  for (Map<String, dynamic> i in json.decode(response.body)) {
    arr.add(JobModel.fromJson(i));
  }
  return arr;
}
