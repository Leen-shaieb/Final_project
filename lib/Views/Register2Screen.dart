import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Utils/Utils.dart';
import 'package:final_project/Utils/clientConfig.dart';
import 'package:final_project/Views/HomePageScreen.dart';
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
  State<Register2Screen> createState() => _Register2ScreenPageState();
}

class _Register2ScreenPageState extends State<Register2Screen> {
  final _txtDegree = TextEditingController();
  final _txtUniversity = TextEditingController();
  final _txtPassword = TextEditingController();
  final _txtRePassword = TextEditingController();
  final _txtcv = TextEditingController();

  late UserModel _user;

  @override
  void initState() {
    super.initState();
    _user = widget.lastStepUser;
  }

  Future<void> insertUser(UserModel user) async {
    final url = "User/insertUser.php?firstName=${user.FirstName}&lastName=${user.LastName}&email=${user.Email}&password=${user.Password}&userType=2";
    print(serverPath + url);

    await http.get(Uri.parse(serverPath + url));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homepagescreen(title: 'HomePage')),
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
      //..DegreeID = _txtDegree.value
      ..University = _txtUniversity.text
      ..Password = _txtPassword.text;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildTextField('Degree', _txtDegree),
            buildTextField('University', _txtUniversity),
            buildTextField('C.V', _txtcv),
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
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Register', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
