import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Utils/clientConfig.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';

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

  Future<void> insertJob(JobModel job) async {
    final url =
        "Job/insertJob.php?jobName=${job.JobName}&Description=${job.Description}&Location=${job.Location}";
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
      ..Description = _txtDescription.text;
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
            buildTextField("Job Title", _txtTitleJob),
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
