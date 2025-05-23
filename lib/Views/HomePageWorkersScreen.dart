import 'dart:convert';
import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Views/AddJobScreen.dart';
import 'package:final_project/Views/EditProfileScreen.dart';
import 'package:final_project/Views/JobDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:final_project/Utils/clientConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appliedJobsScreen.dart';

class HomepageworkersScreen extends StatefulWidget {
  const HomepageworkersScreen({super.key, required this.title});

  final String title;

  @override
  State<HomepageworkersScreen> createState() => _HomepageworkersScreenPageState();
}

class _HomepageworkersScreenPageState extends State<HomepageworkersScreen> {
  UserModel us = UserModel();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => appliedJobsScreen(title: 'History')));
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen(title: 'Edit Profile',profile: us,)));
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
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobDetailsScreen(title: "Job Details", jb: job),
                        ),
                      );
                    },
                  ),

                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'jobs'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Edit Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}

Future<List<JobModel>> getJobs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var ffg= await prefs.getInt("DegreeID");
  var url = "/Job/getJobs.php?DegreeID=$ffg";
  print(serverPath + url);

  final response = await http.get(Uri.parse(serverPath + url));
  if (response.statusCode == 200) {
    List arr = json.decode(response.body);
    return arr.map((e) => JobModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load jobs');
  }
}
