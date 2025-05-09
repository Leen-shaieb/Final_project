import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Views/Register2Screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.title});

  final String title;

  @override
  State<RegisterScreen> createState() => _RegisterScreenPageState();
}

class _RegisterScreenPageState extends State<RegisterScreen> {
  final _txtFirstName = TextEditingController();
  final _txtLastName = TextEditingController();
  final _txtCity = TextEditingController();
  final _txtEmail = TextEditingController();

  void saveStep() {
    var user = UserModel();
    user.FirstName = _txtFirstName.text;
    user.LastName = _txtLastName.text;
    user.City = _txtCity.text;
    user.Email = _txtEmail.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Register2Screen(title: 'Register', lastStepUser: user),
      ),
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
            TextField(
              controller: _txtFirstName,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _txtLastName,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _txtCity,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _txtEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: saveStep,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Continue', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
