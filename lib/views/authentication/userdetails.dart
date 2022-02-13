// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourist/theme/theme.dart';
import 'package:tourist/views/authentication/signup.dart';

class UserDetails extends StatefulWidget {
  UserDetails({required this.adminstatus});
  final bool adminstatus;
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _UserDetailsState extends State<UserDetails> {
  var _image;
  late String name;
  late String img64;
  Future getImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  Future getImageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    var image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  Future getImage() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Select Image'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.camera),
                        SizedBox(width: 10),
                        Text('Camera'),
                      ],
                    ),
                    onTap: () async {
                      Navigator.of(context).pop();
                      await getImageFromCamera();
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.image),
                          SizedBox(width: 20),
                          Text('Gallery'),
                        ],
                      ),
                      onTap: () async {
                        Navigator.of(context).pop();
                        await getImageFromGallery();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account \nDetails',
                      style: heading2.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Image.asset(
                      'assets/images/accent.png',
                      width: 99,
                      height: 4,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: (_image != null)
                                  ? Image.file(
                                      _image,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      'assets/images/login.png',
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 80,
                          left: 90,
                          child: GestureDetector(
                            onTap: () async => await getImage(),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: primaryBlue,
                                  width: 2,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: primaryBlue,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    color: textWhiteGrey,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Name';
                      }

                      return null;
                    },
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: heading6.copyWith(color: textGrey),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const SizedBox(height: 30),
                Material(
                  borderRadius: BorderRadius.circular(14.0),
                  elevation: 0,
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_image == null) {
                              ByteData bytes = await rootBundle
                                  .load('assets/images/logo_splash.png');
                              var buffer = bytes.buffer;
                              String img =
                                  base64.encode(Uint8List.view(buffer));
                              setState(() {
                                img64 = img;
                              });
                            } else {
                              final bytes = await _image.readAsBytes();
                              String img = base64Encode(bytes);
                              setState(() {
                                img64 = img;
                              });
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup(
                                        adminstatus: widget.adminstatus,
                                        base64: img64,
                                        name: name.toString(),
                                      )),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(14.0),
                        child: Center(
                          child: Text(
                            "Next",
                            style: heading5.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
