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

class HomepageworkersScreen extends StatefulWidget {
  const HomepageworkersScreen({super.key, required this.title});

  final String title;

  @override
  State<HomepageworkersScreen> createState() => _HomepageworkersScreenPageState();
}

class _HomepageworkersScreenPageState extends State<HomepageworkersScreen> {
  UserModel us = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen(title: 'Edit Profile', profile: us)),
              );
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<List<JobModel>>(
        future: getJobs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.deepPurple),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('שגיאה, נסה שוב', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red)),
            );
          } else if (snapshot.hasData) {
            var jobs = snapshot.data!;
            if (jobs.isEmpty) {
              return Center(
                child: Text('אין תוצאות', style: TextStyle(fontSize: 23, color: Theme.of(context).colorScheme.onBackground)),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                JobModel job = jobs[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      job.JobName ?? '',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      job.Location != null ? "[${job.Location}]" : '',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JobDetailsScreen(title: "Job Details", jb: job)),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('לא נמצאו נתונים'));
          }
        },
      ),
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddJobScreen(title: 'Add New Job')),
          );
        },
        child: const Icon(Icons.add),
      ),*/
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
