import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Views/HomePageWorkersScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Utils/clientConfig.dart';
import 'HomePageScreen.dart';

class EditProfileScreen extends StatefulWidget {
  final String title;
  final UserModel profile;

  const EditProfileScreen({super.key, required this.title, required this.profile});

  @override
  State<EditProfileScreen> createState() => EditProfileScreenPageState();
}

class EditProfileScreenPageState extends State<EditProfileScreen> {
  final _txtFirstName = TextEditingController();
  final _txtCity = TextEditingController();
  final _txtEmail = TextEditingController();
  final _txtDegree = TextEditingController();
  final _txtPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  void dispose() {
    _txtFirstName.dispose();
    _txtCity.dispose();
    _txtEmail.dispose();
    _txtDegree.dispose();
    _txtPassword.dispose();
    super.dispose();
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool obscure = false}) {
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



  Future<UserModel> userDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ffg = await prefs.getInt("token");
    var url = "/User/getUserDetails.php?userID=$ffg";
    print(serverPath + url);
    final response = await http.get(Uri.parse(serverPath + url));
    print(response.body);
    final jsonList = json.decode(response.body) as List<dynamic>;
    print(jsonList);

    if (jsonList.isEmpty) {
      throw Exception("No user data found");
    }

    final userData = jsonList[0];
    return UserModel(
      FirstName: userData['firstName'],
      Email: userData['email'],
      Password: userData['password'],
      City: userData['city'],
      //Degree: userData['Degree'],



    );
  }

  void getUserData() async {
    try {
      UserModel user = await userDetails();
      setState(() {
        _txtFirstName.text = user.FirstName;
        _txtEmail.text = user.Email;
        _txtCity.text = user.City;
        //_txtDegree.text = user.Degree;
        _txtPassword.text = user.Password;
      });
    } catch (e) {
      print("Error getting user data: $e");
      // You could show a snackbar or dialog here to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load profile data: ${e.toString()}')),
      );
    }
  }
  Future<void> updateUser() async {
    FocusScope.of(context).unfocus(); // لإغلاق لوحة المفاتيح

    if (_txtFirstName.text.isEmpty || _txtPassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ffg = await prefs.getInt("token");
    print("token"+"$ffg");
    final url =
        "User/updateUser.php?userID=${ffg}&firstName=${_txtFirstName.text}&city=${_txtCity.text}&email=${_txtEmail.text}&password=${_txtPassword.text}";
    print(serverPath + url);

    final response = await http.get(Uri.parse(serverPath + url));

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Job updated successfully')),
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomepageworkersScreen(title: 'HomePage')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error updating job')),
      );
    }
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField("First Name", _txtFirstName),
            buildTextField("City", _txtCity),
            buildTextField("Email", _txtEmail),
           // buildTextField("Degree", _txtDegree),
            buildTextField("Password", _txtPassword, obscure: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateUser,
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