import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Views/HomePageWorkersScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/clientConfig.dart';
import 'package:http/http.dart' as http;
import 'package:final_project/Utils/Utils.dart';

class JobDetails2Screen extends StatefulWidget {
  const JobDetails2Screen({super.key, required this.title, required this.jb});

  final String title;
  final JobModel jb;

  @override
  State<JobDetails2Screen> createState() => _JobDetails2ScreenPageState();
}

class _JobDetails2ScreenPageState extends State<JobDetails2Screen> {
  Future<void> apply() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? token = prefs.getInt("token");

    if (token != null) {
      var url = "usersApplied/applyUser.php?userID=$token&jobID=${widget.jb.jobID}";
      await http.get(Uri.parse(serverPath + url));
      print(serverPath + url);
      var uti = new Utils();
      await uti.ShowMyDialog(context, "", "لقد تم تقديم الطلب بنجاح");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomepageworkersScreen(title: 'Home Page')),
      );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User token not found')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final job = widget.jb;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.JobName ?? 'No Title',
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.deepPurple),
                  const SizedBox(width: 8),
                  Text(
                    job.Location ?? 'No Location',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                "Description",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                job.Description ?? 'No Description provided.',
                style: const TextStyle(fontSize: 18, height: 1.5),
              ),
              const SizedBox(height: 40),

            ],
          ),
        ),
      ),
    );
  }
}
