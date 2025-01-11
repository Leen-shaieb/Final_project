import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:final_project/Views/Register2Screen.dart';
import 'package:flutter/material.dart';




class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.title});


  final String title;

  @override
  State<RegisterScreen> createState() => RegisterScreenPageState();
}

class RegisterScreenPageState extends State<RegisterScreen> {



  @override
  Widget build(BuildContext context) {
    final _txtFirstName = TextEditingController();
    final _txtLastName = TextEditingController();
    final _txtCity = TextEditingController();
    final _txtEmail = TextEditingController();
    //final _txtBirthDate =


    void saveStep()
    {
      var user = new UserModel();
      user.FirstName = _txtFirstName.text;
      user.LastName=_txtLastName.text;
      user.Email=_txtEmail.text;
      user.City=_txtLastName.text;
      //user.BirthDate=_txtBirthDate.text;




      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Register2Screen(title: 'Register',lastStepUser: user,)),
      );
    }



    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text("First Name:", style: TextStyle(fontSize: 20),),
            TextField(
              controller:_txtFirstName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'First Name'),
            ),

            Text("Last Name:", style: TextStyle(fontSize: 20),),
            TextField(
              controller: _txtLastName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Last Name'),),

            Text("City:", style: TextStyle(fontSize: 20),),
            TextField(
              controller: _txtCity,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'City'),),

            Text("Email", style: TextStyle(fontSize: 20),),
            TextField(
              controller: _txtEmail,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email'),),

            Text("Birth Date:", style: TextStyle(fontSize: 20),),
            TextField(
              //controller: _txtBirthDate,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Birth Date'),),

            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),

              ),
              onPressed: () {
                saveStep();
              },
              child: Text('Continue'),),




          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
