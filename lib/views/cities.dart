import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourist/theme/theme.dart';

class Cities extends StatefulWidget {
  final String id;
  // ignore: use_key_in_widget_constructors
  Cities(this.id);

  @override
  _CitiesState createState() => _CitiesState();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
}

class _CitiesState extends State<Cities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CustomListView(widget: widget));
  }
}

class CustomListView extends StatelessWidget {
  const CustomListView({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Cities widget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: widget.firestore
            .collection('peshawar/${widget.id}/city')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('loading');
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                String name = snapshot.data!.docs[index]['name'];
                String image = snapshot.data!.docs[index]['img'];
                String id = snapshot.data!.docs[index].id;

                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 170,
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
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  name,
                                  style: heading2.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
