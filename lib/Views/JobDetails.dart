import 'package:final_project/Models/JobModel.dart';
import 'package:final_project/Views/HomePageWorkersScreen.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    // عرض تفاصيل الوظيفة مثل الاسم والموقع داخل الحقول
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
              // عرض تفاصيل الوظيفة هنا
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
                  Navigator.push(
                    context,
                    //ضيفي عملية الي بتودي اسم المستخدم للشركة(قدم للشغل)
                    MaterialPageRoute(
                      builder: (context) => HomepageworkersScreen(title: 'HomePage'),
                    ),
                  );
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
