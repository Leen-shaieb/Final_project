import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Views/HomePageWorkersScreen.dart';

class EditProfileScreen extends StatefulWidget {
  final String title;
  final UserModel profile;

  const EditProfileScreen({super.key, required this.title, required this.profile});

  @override
  State<EditProfileScreen> createState() => EditProfileScreenPageState();  // استخدم الاسم الصحيح هنا
}

class EditProfileScreenPageState extends State<EditProfileScreen> {
  final _txtFirstName = TextEditingController();
  final _txtCity = TextEditingController();
  final _txtEmail = TextEditingController();
  final _txtDegree = TextEditingController();
  final _txtPassword = TextEditingController();

  Widget buildTextField(String label, TextEditingController controller, {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Future<void> UpdateProfile() async {
    // تنفيذ التعديل هنا
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomepageworkersScreen(title: 'HomePage')),
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
            buildTextField("First Name", _txtFirstName),
            buildTextField("City", _txtCity),
            buildTextField("Email", _txtEmail),
            buildTextField("Degree", _txtDegree),
            buildTextField("Password", _txtPassword, obscure: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: UpdateProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Save', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

