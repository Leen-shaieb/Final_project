import 'dart:collection';
import 'dart:convert';
import 'package:final_project/Models/CompanyModel.dart';
import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Views/AddJobScreen.dart';
import 'package:final_project/Views/WorkersScreen.dart';
import 'package:final_project/Views/UsersAppliedForWork.dart';
import 'package:final_project/Views/EditJobScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:final_project/Utils/clientConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/CheckLoginModel.dart';

class Homepagescreen extends StatefulWidget {
  Homepagescreen({super.key, required this.title});

  final String title;

  @override
  State<Homepagescreen> createState() => HomepagescreenPageState();
}

class HomepagescreenPageState extends State<Homepagescreen> {
  var _selectedIndex = 0;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<List<JobModel>>(
        future: getJobs(),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          } else if (projectSnap.hasError) {
            print(projectSnap.error);
            return Center(
              child: Text('שגיאה, נסה שוב',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground)),
            );
          } else if (!projectSnap.hasData || projectSnap.data!.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 2,
              child: Align(
                alignment: Alignment.center,
                child: Text('אין תוצאות',
                    style: TextStyle(fontSize: 23, color: Theme.of(context).colorScheme.onBackground)),
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: projectSnap.data!.length,
                    itemBuilder: (context, index) {
                      JobModel project = projectSnap.data![index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white, // You might want to adjust this based on your lilac theme
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(
                            project.JobName!.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "[${project.Location!}]",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                            ),
                          ),
                          isThreeLine: false,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.person, color: Theme.of(context).colorScheme.secondary),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UsersappliedforworkScreen(title: 'Usersappliedforwork', jb: project),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditJobScreen(title: 'Edit Job', jb: project),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: _selectedIndex == 0 ? Theme.of(context).colorScheme.secondary : Colors.grey),
            label: 'new job',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: _selectedIndex == 1 ? Theme.of(context).colorScheme.secondary : Colors.grey),
            label: 'Workers',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  Future<CompanyModel> getCompany() async {
    print("gg");
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    int? companyID = await prefs2.getInt('companyID');
    var url = "Company/getCompanyDetails.php?companyID=" + companyID.toString();
    print(serverPath + url);

    final response = await http.get(Uri.parse(serverPath + url));
    print("Response body: ${response.body}");

    // This is the key part - properly decode as a list first
    List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;

    // Check if we have data
    if (jsonList.isEmpty) {
      throw Exception("No company data found");
    }

    // Extract the first company as a Map
    Map<String, dynamic> companyData = jsonList[0];

    // Create the CompanyModel directly
    return CompanyModel(
        companyID: companyData['companyID'],
        companyName: companyData['companyName'],
        location: companyData['location']
    );
  }
  Future<List<JobModel>> getJobs() async {
    var url = "/Job/getJobs.php";
    print(serverPath + url);
    print("gghh");
    SharedPreferences prefs = await SharedPreferences.getInstance();
  print("gg");
    final response = await http.get(Uri.parse(serverPath + url));
    print(response.body);
    print(serverPath + url);
    List<JobModel> arr = [];
  CompanyModel cm= await getCompany();

print(cm.companyName);
    for (Map<String, dynamic> i in json.decode(response.body)) {
      print(i);
      if (JobModel.fromJson(i).companyID ==cm.companyID){
        print("hh");
        arr.add(JobModel.fromJson(i));
      }
    }
    return arr;
  }
}