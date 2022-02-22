// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourist/theme/theme.dart';

import 'cities.dart';

class FeaturedCity extends StatefulWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FeaturedCity({
    Key? key,
    required this.name,
    required this.image,
    required this.description,
    required this.id,
  }) : super(key: key);

  late String name;
  late String image;
  late String description;
  late String id;

  @override
  State<FeaturedCity> createState() => _FeaturedCityState();
}

class _FeaturedCityState extends State<FeaturedCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
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
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.description,
                style: TextStyle(color: Colors.grey[800], fontSize: 18),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Text(
                      '${widget.name} Businesses',
                      style: heading2.copyWith(color: textBlack, fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.26,
                child: CustomBottomList(
                    widget: widget,
                    id: widget.id,
                    database:
                        widget.firestore.collection('peshawar').snapshots()))
          ],
        ),
      ),
    );
  }
}

class CustomBottomList extends StatelessWidget {
  CustomBottomList({
    Key? key,
    required this.widget,
    required this.database,
    required this.id,
  }) : super(key: key);

  final FeaturedCity widget;
  var database;
  String id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: database,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return StreamBuilder<QuerySnapshot>(
              stream:
                  widget.firestore.collection('peshawar/$id/biz').snapshots(),
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
                      String id = snapshot.data!.docs[index].id;

                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Cities(id)),
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
              });
        });
  }
}
