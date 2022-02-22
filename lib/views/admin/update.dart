// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourist/main.dart';
import 'package:tourist/theme/theme.dart';
import 'package:tourist/views/Home/adminHomepage.dart';
import 'package:tourist/views/admin/adminpanel.dart';

class Update extends StatefulWidget {
  String docid;
  String dropdownvalue;
  String bizname;
  int price;
  String bizaddress;
  String imagelink;
  bool hotel;
  bool transport;
  String user;
  Update(
      {required this.docid,
      required this.dropdownvalue,
      required this.bizname,
      required this.bizaddress,
      required this.price,
      required this.imagelink,
      required this.hotel,
      required this.transport,
      required this.user,
      Key? key})
      : super(key: key);

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  updatecontrollers() {
    setState(() {
      nameController.text = widget.bizname;
      addressController.text = widget.bizaddress;
      priceController.text = widget.price.toString();
      imageController.text = widget.imagelink;
      location = widget.dropdownvalue;
    });
  }

  late String location;

  var items = [
    'Peshawar',
    'Lahore',
    'Karachi',
    'Multan',
    'Quetta',
    'Bahawalpur',
    'Islamabad'
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    updatecontrollers();
  }

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
                                'Update Your\nBusiness',
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
                                  controller: nameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Name';
                                    }

                                    return null;
                                  },
                                  onChanged: (value) {
                                    widget.bizname = value;
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
                                  controller: addressController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Address';
                                    }

                                    return null;
                                  },
                                  onChanged: (value) {
                                    widget.bizaddress = value;
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
                                    value: widget.dropdownvalue,
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
                                        widget.dropdownvalue = newValue!;
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
                                  controller: priceController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Amount';
                                    }

                                    return null;
                                  },
                                  onChanged: (value) {
                                    try {
                                      setState(() {
                                        widget.price = int.parse(value);
                                      });
                                    } catch (e) {
                                      setState(() {
                                        widget.price = 0;
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
                                  controller: imageController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter image link';
                                    }
                                    bool validURL =
                                        Uri.parse(imageController.text).host ==
                                                ''
                                            ? false
                                            : true;
                                    if (!validURL) {
                                      return 'Please enter valid image link';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    widget.imagelink = value;
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
                                  });
                                  if (location != widget.dropdownvalue) {
                                    await FirebaseFirestore.instance
                                        .collection('peshawar/$location/biz')
                                        .doc(widget.docid)
                                        .delete()
                                        .then((value) async {
                                      await FirebaseFirestore.instance
                                          .collection(
                                              'users/${widget.user}/biz')
                                          .doc(widget.docid)
                                          .delete();

                                      await FirebaseFirestore.instance
                                          .collection(
                                              'peshawar/${widget.dropdownvalue}/biz')
                                          .doc(widget.docid)
                                          .set({
                                        'name': widget.bizname,
                                        'address': widget.bizaddress,
                                        'price': widget.price,
                                        'hotel': widget.hotel,
                                        'transport': widget.transport,
                                        'img': widget.imagelink,
                                      }).then((value) async {
                                        await FirebaseFirestore.instance
                                            .collection(
                                                'users/${widget.user}/biz')
                                            .doc(widget.docid)
                                            .set({
                                          'location': widget.dropdownvalue
                                        });

                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const MyApp()),
                                          (Route<dynamic> route) => false,
                                        );
                                      });
                                    });
                                  } else {
                                    await FirebaseFirestore.instance
                                        .collection(
                                            'peshawar/${widget.dropdownvalue}/biz')
                                        .doc(widget.docid)
                                        .update({
                                      'name': widget.bizname,
                                      'address': widget.bizaddress,
                                      'price': widget.price,
                                      'img': widget.imagelink,
                                    }).then((value) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Updated Successfully',
                                          ),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    });
                                  }
                                }
                              },
                              borderRadius: BorderRadius.circular(14.0),
                              child: Center(
                                child: Text(
                                  "Update",
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
