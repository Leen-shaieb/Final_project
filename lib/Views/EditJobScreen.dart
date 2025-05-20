import 'dart:convert';

import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:final_project/Utils/clientConfig.dart';

import '../Models/JobNameModel.dart';

class EditJobScreen extends StatefulWidget {
  const EditJobScreen({super.key, required this.title, required this.jb});

  final String title;
  final JobModel jb;

  @override
  State<EditJobScreen> createState() => _EditJobScreenState();
}

class _EditJobScreenState extends State<EditJobScreen> {
  late TextEditingController _txtJobTitle;
  late TextEditingController _txtLocation;
  late TextEditingController _txtDescription;
  final _txtTitleJob = TextEditingController();

  int jobNameId=0;

  @override
  void initState() {
    super.initState();
    _txtJobTitle = TextEditingController(text: widget.jb.JobName);
    _txtLocation = TextEditingController(text: widget.jb.Location);
    _txtDescription = TextEditingController(text: widget.jb.Description);
  }

  @override
  void dispose() {
    _txtJobTitle.dispose();
    _txtLocation.dispose();
    _txtDescription.dispose();
    super.dispose();
  }

  Future<void> updateJob(BuildContext context) async {
    FocusScope.of(context).unfocus(); // لإغلاق لوحة المفاتيح

    if (_txtJobTitle.text.isEmpty || _txtLocation.text.isEmpty || _txtDescription.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final url =
        "Job/updateJob.php?jobNameID=${jobNameId}&Description=${_txtDescription.text}&Location=${_txtLocation.text}&jobID=${widget.jb.jobID}";
    print(serverPath + url);

    final response = await http.get(Uri.parse(serverPath + url));

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Job updated successfully')),
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepagescreen(title: 'HomePage')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error updating job')),
      );
    }
  }
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
      body: SingleChildScrollView(
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
                updateJob(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Save Changes', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
