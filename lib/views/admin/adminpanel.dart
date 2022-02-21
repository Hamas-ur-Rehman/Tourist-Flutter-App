// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourist/theme/theme.dart';

import 'biztype.dart';

class AdminPanel extends StatefulWidget {
  String docid;
  AdminPanel({required this.docid, Key? key}) : super(key: key);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchbizData(widget.docid, context);
  }

  List ids = [];

  fetchfirestore(int index) async {
    String myDocId = ids[index]['id'];
    DocumentSnapshot? documentSnapshot;

    await FirebaseFirestore.instance
        .collection('peshawar/${ids[index]['location']}/biz')
        .doc(myDocId)
        .get()
        .then((value) {
      documentSnapshot = value;
    });
    List data = [
      {
        'address': documentSnapshot!.get('address'),
        'hotel': documentSnapshot!.get('hotel'),
        'img': documentSnapshot!.get('img'),
        'name': documentSnapshot!.get('name'),
        'price': documentSnapshot!.get('price'),
        'transport': documentSnapshot!.get('transport'),
      }
    ];
    return data;
  }

  buildbiz(index, data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          onTap: () {},
          title: Text(
            "${data[0]['name']}",
            style: heading2.copyWith(color: textBlack),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: textBlack,
          ),
        ),
      ),
    );
  }

  fetchbizData(userid, context) async {
    try {
      await FirebaseFirestore.instance
          .collection('users/$userid/biz')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          ids.add({"id": doc.id, 'location': doc['location']});
          print(ids);
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error Occured while loading the documents'),
      ));
    }
  }

  bool adminstatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BizType(
                docid: widget.docid,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      splashColor: primaryBlue,
                      splashRadius: 10,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin \nPanel',
                        style: heading2.copyWith(color: textBlack),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Image.asset(
                        'assets/images/accent.png',
                        width: 99,
                        height: 4,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Your Businesses',
                style: heading2.copyWith(color: textBlack),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    itemCount: ids.length,
                    itemBuilder: (context, indexi) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: FutureBuilder(
                        future: fetchfirestore(indexi),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: ids.length,
                              itemBuilder: (context, indexi) {
                                return buildbiz(0, snapshot.data);
                              },
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
