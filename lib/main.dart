// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourist/views/adminHomepage.dart';
import 'package:tourist/views/authentication/login.dart';
import 'package:tourist/views/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //initialzing firebase
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  var email;
  var isAdmin;
  var name;
  getprefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email');
      isAdmin = preferences.getBool('isAdmin');
      name = preferences.getString('name');
    });
  }

  @override
  void initState() {
    super.initState();
    getprefs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print("email is $email");
            print("admin is $isAdmin");
            return email == "" || email == null
                ? const LoginPage()
                : isAdmin
                    ? AdminHomePage(name: name, email: email)
                    : HomePage(
                        email: email,
                        name: name,
                      );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
