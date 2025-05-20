import 'dart:convert';

import 'package:final_project/Models/JobNameModel.dart';
import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Utils/clientConfig.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  State<AddJobScreen> createState() => AddJobScreenState();
}

class AddJobScreenState extends State<AddJobScreen> {
  final _txtTitleJob = TextEditingController();
  final _txtLocation = TextEditingController();
  final _txtDescription = TextEditingController();
  int jobNameId=0;
  Future<List<JobNameModel>> getJobsName() async {
    var url = "/JobName/GetJobsName.php";
    print(serverPath + url);

    final response = await http.get(Uri.parse(serverPath + url));

    if (response.statusCode == 200) {
      List<JobNameModel> arr = [];
      for (Map<String, dynamic> i in json.decode(response.body)) {
        arr.add(JobNameModel.fromJson(i));
      }
      return arr;
    } else {
      throw Exception('فشل تحميل البيانات');
    }
  }


  void showJobsBottomSheet() async {
    List<JobNameModel> jobs = await getJobsName();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return ListView.builder(
              controller: scrollController,
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(jobs[index].JobName!),
                  onTap: () {
                    _txtTitleJob.text=jobs[index].JobName!;
                    jobNameId=jobs[index].JobNameID!;
                  //  context: jobs[index].JobName!;
                    Navigator.pop(context);
                    print('تم اختيار: ${jobs[index].JobName}');
                  },
                );
              },
            );
          },
        );
      },
    );
  }


  Future<void> insertJob(JobModel job) async {
    final url =
        "Job/insertJob.php?jobNameID=${job.JobNameID}&Description=${job.Description}&Location=${job.Location}";
    print(serverPath + url);

    // Uncomment the following lines when the server is ready:
    // final response = await http.get(Uri.parse(serverPath + url));
    // print(response.body);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homepagescreen(title: 'HomePage')),
    );
  }

  JobModel createJob() {
    return JobModel()
      ..JobName = _txtTitleJob.text
      ..Location = _txtLocation.text
      ..Description = _txtDescription.text
      ..JobNameID=jobNameId;
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
           ElevatedButton(
            onPressed: showJobsBottomSheet,
            child: Text('Job Name'),),

          buildTextField("Location", _txtLocation),
            buildTextField("Description", _txtDescription),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final job = createJob();
                insertJob(job);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Add Job', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
