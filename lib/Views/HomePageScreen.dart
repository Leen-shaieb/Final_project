import 'dart:convert';
import 'package:final_project/Models/CompanyModel.dart';
import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Views/AddJobScreen.dart';
import 'package:final_project/Views/allJobs.dart';
import 'package:final_project/Views/UsersAppliedForWork.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:final_project/Utils/clientConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EditJobScreen.dart';


class Homepagescreen extends StatefulWidget {
  const Homepagescreen({super.key, required this.title});

  final String title;

  @override
  State<Homepagescreen> createState() => _HomepagescreenPageState();
}

class _HomepagescreenPageState extends State<Homepagescreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AddJobScreen(title: 'Add Job')));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => allJobsScreen(title: 'Workers')));
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
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary));
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text('שגיאה, נסה שוב', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.error)),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('אין תוצאות', style: TextStyle(fontSize: 23, color: Theme.of(context).colorScheme.onBackground)),
            );
          } else {
            List<JobModel> jobs = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      job.JobName ?? '',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '[${job.Location ?? ''}]',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ),
                    trailing: Wrap(
                      spacing: 12,
                      children: [
                        IconButton(
                          icon: Icon(Icons.person, color: Theme.of(context).colorScheme.secondary),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UsersappliedforworkScreen(title: 'Users Applied', jb: job)),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditJobScreen(title: 'Edit Job', jb: job)),

                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'New Job'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'jobs'),
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? companyID = prefs.getInt('companyID');

    if (companyID == null) {
      throw Exception("No companyID found in preferences");
    }

    final response = await http.get(Uri.parse(serverPath + "Company/getCompanyDetails.php?companyID=$companyID"));
    final jsonList = json.decode(response.body) as List<dynamic>;

    if (jsonList.isEmpty) {
      throw Exception("No company data found");
    }

    final companyData = jsonList[0];
    return CompanyModel(
      companyID: companyData['companyID'],
      companyName: companyData['companyName'],
      location: companyData['location'],
    );
  }

 /* Future<List<JobModel>> getJobs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ffg= await prefs.getInt("CompanyID");
    var url = "/Job/getJobsCompany.php?CompanyID=$ffg";
    print(serverPath + url);
    final response = await http.get(Uri.parse(serverPath + url));
    final jobsJson = json.decode(response.body) as List<dynamic>;
    return jobsJson.map((json) => JobModel.fromJson(json))
        .where((job) => job.companyID == company.companyID)
        .toList();
  }
}*/
Future<List<JobModel>> getJobs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var ffg= await prefs.getInt("companyID");
  var url = "/Job/getJobsCompany.php?companyID=$ffg";
  print(serverPath + url);
  print("companyID from prefs: $ffg");
  final response = await http.get(Uri.parse(serverPath + url));
  //print("Response body: ${response.body}");

  if (response.statusCode == 200) {
    List arr = json.decode(response.body);
    return arr.map((e) => JobModel.fromJson(e)).toList();
  }
  else {
    throw Exception('Failed to load jobs');
  }
}
}

