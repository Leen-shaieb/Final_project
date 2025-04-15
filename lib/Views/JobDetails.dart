import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Views/HomePageWorkersScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/clientConfig.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:http/http.dart' as http;

class JobDetailsScreen extends StatefulWidget {
  JobDetailsScreen({super.key, required this.title, required this.jb});

  final String title;
  final JobModel jb;

  @override
  State<JobDetailsScreen> createState() => JobDetailsScreenPageState();
}

class JobDetailsScreenPageState extends State<JobDetailsScreen> {
  final _txtFirstName = TextEditingController();
  final _txtLastName = TextEditingController();
  final _txtCity = TextEditingController();
  late  JobModel? _jb;


  @override
  Widget build(BuildContext context) {
    JobModel jb= widget.jb;


    Future apply(BuildContext context) async {

      SharedPreferences prefs = await SharedPreferences.getInstance();
   int? token = prefs.getInt("token");
  var url = "Job/applyUser.php?userID=" + token!.toString()+ "&jobID=" + jb.jobID.toString();
  final response = await http.get(Uri.parse(serverPath + url));
  print(serverPath + url);
  // setState(() { });
  // Navigator.pop(context);
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) =>HomepageworkersScreen(title: 'HomePage')),
  );
  }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Job Title: ${widget.jb.JobName ?? 'No Title'}", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text("Location: ${widget.jb.Location ?? 'No Location'}", style: TextStyle(fontSize: 20)),
              SizedBox(height: 30),
              Text("Description: ${widget.jb.Description ?? 'No Location'}", style: TextStyle(fontSize: 20)),
              SizedBox(height: 30),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {

                  apply(context);
                  // Navigator.push(
                  //   context,
                    // MaterialPageRoute(
                    //   builder: (context) => HomepageworkersScreen(title: 'HomePage'),
                    // ),
                  // );
                },
                child: Text('Apply'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
