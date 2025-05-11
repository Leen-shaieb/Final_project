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
            buildTextField("First Name", _txtFirstName),
            buildTextField("Last Name", _txtLastName),
            buildTextField("City", _txtCity),
            buildTextField("Email", _txtEmail),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Continue', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
