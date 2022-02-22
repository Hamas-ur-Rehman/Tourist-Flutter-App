// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourist/theme/theme.dart';
import 'package:tourist/views/HomeComponents/bizdetails.dart';
import 'package:tourist/views/HomeComponents/cities.dart';
import 'package:tourist/views/Profile/profile.dart';
import 'dart:math';

import '../HomeComponents/featuredcity.dart';

class HomePage extends StatefulWidget {
  String name;
  String email;
  HomePage({required this.name, required this.email, Key? key})
      : super(key: key);
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 5, 0, 5),
                  child: Text(
                    'Let\'s \nExplore ',
                    style: heading2.copyWith(color: textBlack, fontSize: 35),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: const Icon(
                        Icons.person,
                        size: 30,
                        color: Color(0xff2972ff),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(
                              adminx: false,
                              namex: widget.name,
                              emailx: widget.email,
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: CustomListView(
                  widget: widget,
                )),
            FeaturedSite(widget: widget),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 5, 0, 5),
                  child: Text(
                    'Businesses',
                    style: heading2.copyWith(color: textBlack, fontSize: 35),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.26,
              child: CustomBottomList(
                widget: widget,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class FeaturedSite extends StatelessWidget {
  FeaturedSite({
    Key? key,
    required this.widget,
  }) : super(key: key);

  var database;
  final HomePage widget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: widget.firestore.collection('peshawar').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          int rand = Random().nextInt(snapshot.data!.docs.length);
          String idx = snapshot.data!.docs[rand].id;
          String name = snapshot.data!.docs[rand]['name'];
          return StreamBuilder<QuerySnapshot>(
              stream:
                  widget.firestore.collection('peshawar/$idx/city').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                int ind = Random().nextInt(snapshot.data!.docs.length);
                String image = snapshot.data!.docs[ind]['img'];
                String description = snapshot.data!.docs[ind]['description'];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FeaturedCity(
                                image: image,
                                name: name,
                                description: description,
                                id: idx,
                              )),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: SizedBox(
                      height: 170,
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}

class CustomBottomList extends StatelessWidget {
  const CustomBottomList({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final HomePage widget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: widget.firestore.collection('peshawar').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          return StreamBuilder<QuerySnapshot>(
              stream: widget.firestore
                  .collection(
                      'peshawar/${snapshot.data!.docs[Random().nextInt(snapshot.data!.docs.length - 1) + 1].id}/biz')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data!.docs[index]['name'];
                      String image = snapshot.data!.docs[index]['img'];
                      String address = snapshot.data!.docs[index]['address'];
                      int price = snapshot.data!.docs[index]['price'];

                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BizDetails(
                                          name: name,
                                          image: image,
                                          address: address,
                                          price: price,
                                        )),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.network(
                                      image,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          name,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            backgroundColor: Colors.white54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              });
        });
  }
}

class CustomListView extends StatelessWidget {
  const CustomListView({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final HomePage widget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
          stream: widget.firestore.collection('peshawar').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  String name = snapshot.data!.docs[index]['name'];
                  String image = snapshot.data!.docs[index]['img'];
                  String id = snapshot.data!.docs[index].id;

                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Cities(id)),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.network(
                                  image,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
