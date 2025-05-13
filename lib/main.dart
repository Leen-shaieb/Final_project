import 'dart:io';
import 'package:final_project/Models/UserModel.dart';
import 'package:final_project/Utils/db.dart';
import 'package:final_project/Views/HomePageScreen.dart';
import 'package:final_project/Views/HomePageWorkersScreen.dart';
import 'package:flutter/material.dart';
import 'package:final_project/Views/RegisterScreen.dart';
import 'package:final_project/Models/CheckLoginModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart' ;
import 'package:final_project/Utils/Utils.dart';
import 'package:final_project/Utils/clientConfig.dart';
import 'dart:convert';

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
        // Primary Color (Lavender)
        primarySwatch: MaterialColor(0xFFE6E6FA, {
          50: Color(0xFFF8F8FF),
          100: Color(0xFFECECFE),
          200: Color(0xFFDCDCFB),
          300: Color(0xFFCACAE9),
          400: Color(0xFFBCB8D7),
          500: Color(0xFFE6E6FA),
          600: Color(0xFFA999CC),
          700: Color(0xFF8C7AB8),
          800: Color(0xFF6F5CA4),
          900: Color(0xFF523D90),
        }),
        // ColorScheme with Background and Secondary/Accent
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFE6E6FA), // Lavender
          secondary: const Color(0xFFBA55D3), // Darker Lilac (Accent)
          background: const Color(0xFFF8F8FF), // Very Light Lavender
          onBackground: const Color(0xFF2E2E2E), // Text color on background
          onPrimary: Colors.white, // Color of text/icons on primary color
          onSecondary: Colors.white, // Color of text/icons on secondary color
          surface: const Color(0xFFFFFFFF), // Default surface color
          onSurface: const Color(0xFF2E2E2E), // Text color on surface
        ),
        // Text Theme with Charcoal color
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF2E2E2E)),
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2E2E2E)),
          bodySmall: TextStyle(color: Color(0xFF2E2E2E)),
          labelLarge: TextStyle(color: Color(0xFF2E2E2E)),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sign in'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override

  Widget build(BuildContext context) {


    final _txtUserName = TextEditingController();
    final _txtPassword = TextEditingController();


    checkConction() async {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          // print('connected to internet');// print(result);// return 1;
        }
      } on SocketException catch (_) {
        // print('not connected to internet');// print(result);
        var uti = new Utils();
        uti.ShowMyDialog(context, "لا يوجد اتصال بالانترنت", "تشغيل التطبيق يتطلب اتصال بالانترنت، ارجو الاتصال والمحاولة من جديد");
        return;
      }
    }


    checkSavedPars() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _txtUserName.text = prefs.get("userName").toString();
      _txtPassword.text = prefs.get("password").toString();
    }


    Future checkLogin(BuildContext context) async {
      if(_txtPassword.text != "" && _txtUserName.text != "") {
        var url = "login/checkLogin.php?firstName=" + _txtUserName.text + "&password=" + _txtPassword.text;
        final response = await http.get(Uri.parse(serverPath + url));
        print(response);
        print(serverPath + url);
        if (checkLoginModel
            .fromJson(jsonDecode(response.body))
            .result == 0) {
          print("SharedPreferences 0");
          var uti = new Utils();
          uti.ShowMyDialog(context, "", "اسم المستخدم او كلمة السر غير صحيحات");
        }
        else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('token', checkLoginModel
              .fromJson(jsonDecode(response.body))
              .result!);
          await prefs.setInt('userType', checkLoginModel
              .fromJson(jsonDecode(response.body))
              .userTypeID!);
          await prefs.setInt('companyID', checkLoginModel
              .fromJson(jsonDecode(response.body))
              .companyID!);
          await prefs.setInt('DegreeID', checkLoginModel
              .fromJson(jsonDecode(response.body))
              .DegreeID!);

          await prefs.setString('userName', _txtUserName.text);
          await prefs.setString('password', _txtPassword.text);




          if (checkLoginModel
              .fromJson(jsonDecode(response.body))
              .userTypeID == 1) {     // company

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Homepagescreen(title: "HomePage")),
            );
          }
          else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomepageworkersScreen(title: "HomePage")),
            );
          }
        }
      }
      else
      {
        var uti = new Utils();
        uti.ShowMyDialog(context, "", "you should fill in username and password");
      }
    }



    checkConction();

    checkSavedPars();


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "UserName",
                style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.bodyMedium?.color, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _txtUserName,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  hintText: 'Enter your username',
                 // hintStyle: const TextStyle(textAlign: TextAlign.center, color: Colors.grey),
                  contentPadding: const EdgeInsets.all(12.0),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                "Password",
                style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.bodyMedium?.color, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _txtPassword,
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  hintText: 'Enter your password',
                  //hintStyle: const TextStyle(textAlign: TextAlign.center, color: Colors.grey),
                  contentPadding: const EdgeInsets.all(12.0),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 25.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  checkLogin(context);
                },
                child: const Text('Sign In', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New Account?",
                    style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen(title: "Register")),
                      );
                    },
                    child: Text('Create new account', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}