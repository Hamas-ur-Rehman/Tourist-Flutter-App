// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourist/theme/theme.dart';
import 'package:tourist/views/admin/update.dart';

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
  bool loading = false;

  fetchfirestore(int index) async {
    String myDocId = ids[index]['id'];
    DocumentSnapshot? documentSnapshot;
    List data = [];
    await FirebaseFirestore.instance
        .collection('peshawar/${ids[index]['location']}/biz')
        .doc(myDocId)
        .get()
        .then((value) {
      setState(() {
        documentSnapshot = value;
      });
    });
    setState(() {
      data = [
        {
          'address': documentSnapshot!.get('address'),
          'hotel': documentSnapshot!.get('hotel'),
          'img': documentSnapshot!.get('img'),
          'name': documentSnapshot!.get('name'),
          'price': documentSnapshot!.get('price'),
          'transport': documentSnapshot!.get('transport'),
        }
      ];
    });
    return data;
  }

  buildbiz(index, data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${data['name']}",
                    style: heading2.copyWith(color: textBlack),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });

                        await FirebaseFirestore.instance
                            .collection(
                                'peshawar/${ids[index]['location']}/biz')
                            .doc(ids[index]['id'])
                            .delete()
                            .then((value) async {
                          await FirebaseFirestore.instance
                              .collection('users/${widget.docid}/biz')
                              .doc(ids[index]['id'])
                              .delete();
                          setState(() {
                            ids.removeAt(index);
                            loading = false;
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Business deleted'),
                            ));
                          });
                        });
                      }),
                  IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Update(
                                  docid: ids[index]['id'],
                                  bizaddress: data['address'],
                                  imagelink: data['img'],
                                  bizname: data['name'],
                                  price: data['price'],
                                  dropdownvalue: ids[index]['location'],
                                  transport: data['transport'],
                                  hotel: data['hotel'],
                                  user: widget.docid),
                            ));
                      }),
                ],
              ),
            ],
          )),
    );
  }

  fetchbizData(userid, context) async {
    try {
      await FirebaseFirestore.instance
          .collection('users/$userid/biz')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          setState(() {
            ids.add({"id": doc.id, 'location': doc['location']});
          });
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
    return loading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
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
                          itemBuilder: (context, index) {
                            return StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection(
                                        'peshawar/${ids[index]['location']}/biz')
                                    .doc('${ids[index]['id']}')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const SizedBox();
                                  }
                                  var userDocument = snapshot.data;
                                  return buildbiz(index, userDocument);
                                });
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
