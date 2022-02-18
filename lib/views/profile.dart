import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourist/main.dart';
import 'package:tourist/theme/theme.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? email;
  bool? isAdmin;
  String? image;
  String? name;

  getprefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email');
      isAdmin = preferences.getBool('isAdmin');
      image = preferences.getString('image');
      name = preferences.getString('name');
      _bytesImage = const Base64Decoder().convert(image!);
    });
  }

  removePrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', "");
    preferences.setBool('isAdmin', false);
    preferences.setString('image', "");
    preferences.setString('name', "");
  }

  late Uint8List _bytesImage;

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
          SizedBox(
            height: 120,
            width: 120,
            child: CircleAvatar(
              backgroundImage: MemoryImage(_bytesImage),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            name ?? 'name',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            email ?? 'email',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            isAdmin == true ? 'Business account' : 'Tourist account',
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
