import 'dart:convert';
import 'package:final_project/Models/JobModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:final_project/Utils/clientConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'JobDetails2.dart';


class appliedJobsScreen extends StatefulWidget {
  const appliedJobsScreen({super.key, required this.title});

  final String title;

  @override
  State<appliedJobsScreen> createState() => _appliedJobsScreenPageState();
}

class _appliedJobsScreenPageState extends State<appliedJobsScreen> {
  int _selectedIndex = 0;



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
                          builder: (context) => JobDetails2Screen(title: "Job Details", jb: job),
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

    );
  }




  Future<List<JobModel>> getJobs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ffg= await prefs.getInt("token");
    var url = "/usersApplied/appliedJobs.php?userID=$ffg";
    print(serverPath + url);
    print("token from prefs: $ffg");
    final response = await http.get(Uri.parse(serverPath + url));
    //print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      List arr = json.decode(response.body);
      return arr.map((e) => JobModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}

