// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourist/theme/theme.dart';

class BizType extends StatefulWidget {
  String docid;
  BizType({required this.docid, Key? key}) : super(key: key);

  @override
  _BizTypeState createState() => _BizTypeState();
}

class _BizTypeState extends State<BizType> {
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String randid;
  String getRandString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  String dropdownvalue = 'Peshawar';
  var items = [
    'Peshawar',
    'Lahore',
    'Karachi',
    'Multan',
    'Quetta',
    'Bahawalpur',
    'Islamabad'
  ];
  bool hotel = false;
  bool transport = false;
  late String bizname;
  late String bizaddress;
  late int price;
  late String imagelink;
  String? docid;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: SafeArea(
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
                                'Add a New\nBusiness',
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
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hotel = true;
                                  transport = false;
                                });
                              },
                              child: SizedBox(
                                height: 150,
                                child: Card(
                                  color: hotel ? primaryBlue : Colors.white,
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Hotel',
                                        style: heading2.copyWith(
                                            color: hotel
                                                ? Colors.white
                                                : textBlack,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Image.asset(
                                        'assets/images/hotel.png',
                                        height: 70,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hotel = false;
                                  transport = true;
                                });
                              },
                              child: SizedBox(
                                height: 150,
                                child: Card(
                                  color: !hotel ? primaryBlue : Colors.white,
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Transport',
                                        style: heading2.copyWith(
                                            color: !hotel
                                                ? Colors.white
                                                : textBlack,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Image.asset(
                                        'assets/images/transport.png',
                                        height: 70,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
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
                                    bizname = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Name',
                                    hintStyle:
                                        heading6.copyWith(color: textGrey),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: textWhiteGrey,
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Address';
                                    }

                                    return null;
                                  },
                                  onChanged: (value) {
                                    bizaddress = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Address',
                                    hintStyle:
                                        heading6.copyWith(color: textGrey),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: textWhiteGrey,
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    underline: Container(),
                                    value: dropdownvalue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                          value: items,
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(items),
                                            ],
                                          ));
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: textWhiteGrey,
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Amount';
                                    }

                                    return null;
                                  },
                                  onChanged: (value) {
                                    try {
                                      setState(() {
                                        price = int.parse(value);
                                      });
                                    } catch (e) {
                                      setState(() {
                                        price = 0;
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Price per Night / Ride',
                                    hintStyle:
                                        heading6.copyWith(color: textGrey),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: textWhiteGrey,
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter image link';
                                    }
                                    bool validURL =
                                        Uri.parse(imagelink).host == ''
                                            ? false
                                            : true;
                                    if (!validURL) {
                                      return 'Please enter valid image link';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    imagelink = value;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Image Link',
                                    hintStyle:
                                        heading6.copyWith(color: textGrey),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
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
                                  setState(() {
                                    loading = true;
                                    randid = getRandString(50);
                                  });

                                  await FirebaseFirestore.instance
                                      .collection('peshawar/$dropdownvalue/biz')
                                      .doc(randid)
                                      .set({
                                    'name': bizname,
                                    'address': bizaddress,
                                    'price': price,
                                    'hotel': hotel,
                                    'transport': transport,
                                    'img': imagelink,
                                  }).then((value) async {
                                    await FirebaseFirestore.instance
                                        .collection('users/${widget.docid}/biz')
                                        .doc(randid)
                                        .set({'location': dropdownvalue}).then(
                                            (value) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Added Successfully',
                                          ),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    });
                                  });
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
