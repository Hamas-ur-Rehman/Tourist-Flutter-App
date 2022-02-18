// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourist/main.dart';
import 'package:tourist/theme/theme.dart';

class Profile extends StatefulWidget {
  String namex;
  String emailx;
  bool adminx;
  Profile(
      {required this.namex,
      required this.emailx,
      required this.adminx,
      Key? key})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? email;
  bool? isAdmin;
  String? name;

  getprefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email');
      isAdmin = preferences.getBool('isAdmin');
      name = preferences.getString('name');
    });
  }

  removePrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', "");
    preferences.setBool('isAdmin', false);
    preferences.setString('image', "");
    preferences.setString('name', "");
  }

  @override
  void initState() {
    super.initState();
    getprefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Text(
            name ?? widget.namex,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            email ?? widget.emailx,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            isAdmin == true || widget.adminx
                ? 'Business account'
                : 'Tourist account',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Material(
              borderRadius: BorderRadius.circular(14.0),
              elevation: 0,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      removePrefs();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const MyApp(),
                        ),
                        (route) => false,
                      );
                    },
                    borderRadius: BorderRadius.circular(14.0),
                    child: Center(
                      child: Text(
                        "Log out",
                        style: heading5.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
