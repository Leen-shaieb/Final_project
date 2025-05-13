import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Utils/Utils.dart';
import 'package:final_project/Utils/clientConfig.dart';
import 'package:final_project/Views/HomePageWorkersScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register2Screen extends StatefulWidget {
  const Register2Screen({
    super.key,
    required this.title,
    required this.lastStepUser,
  });

  final String title;
  final UserModel lastStepUser;

  @override
  State<Register2Screen> createState() => _Register2ScreenState();
}

class _Register2ScreenState extends State<Register2Screen> {
  final _txtDegree = TextEditingController();
  final _txtUniversity = TextEditingController();
  final _txtPassword = TextEditingController();
  final _txtRePassword = TextEditingController();

  String? _cvFilePath;

  late UserModel _user;

  @override
  void initState() {
    super.initState();
    _user = widget.lastStepUser;
  }

  Future<void> pickCVFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _cvFilePath = result.files.single.path!;
      });
    }
  }

  Future<void> insertUser(UserModel user) async {
    final url = "User/insertUser.php?firstName=${user.FirstName}&lastName=${user.LastName}&email=${user.Email}&password=${user.Password}&userType=2&city=${user.City}&Degree=${user.Degree}";
    print(serverPath + url);

    await http.get(Uri.parse(serverPath + url));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomepageworkersScreen(title: 'HomePage')),
    );
  }

  bool checkPassword() {
    if (_txtPassword.text != _txtRePassword.text) {
      Utils().ShowMyDialog(context, "", "Retype your password");
      return false;
    }
    return true;
  }

  void updateUser() {
    _user
      ..University = _txtUniversity.text
      ..Password = _txtPassword.text
      ..Degree=_txtDegree.text;
  }

  Widget buildTextField(String label, TextEditingController controller, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget buildCVPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('CV', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: pickCVFile,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(_cvFilePath != null
              ? 'Selected: ${_cvFilePath!.split('/').last}'
              : 'Choose PDF File'),
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
            buildTextField('Degree', _txtDegree),
            buildTextField('University', _txtUniversity),
            buildCVPicker(),
            buildTextField('Password', _txtPassword, isPassword: true),
            buildTextField('Retype Password', _txtRePassword, isPassword: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (checkPassword()) {
                  updateUser();
                  insertUser(_user);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Register', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
