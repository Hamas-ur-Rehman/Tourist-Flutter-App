import 'package:flutter/material.dart';
import 'package:tourist/theme/theme.dart';
import 'package:tourist/views/authentication/userdetails.dart';

class ChooseAdmin extends StatefulWidget {
  const ChooseAdmin({Key? key}) : super(key: key);

  @override
  _ChooseAdminState createState() => _ChooseAdminState();
}

class _ChooseAdminState extends State<ChooseAdmin> {
  bool adminstatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose account\ntype',
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
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          adminstatus = true;
                        });
                      },
                      child: SizedBox(
                        height: 300,
                        child: Card(
                          color: adminstatus ? primaryBlue : Colors.white,
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Business\nAccount',
                                style: heading2.copyWith(
                                    color:
                                        adminstatus ? Colors.white : textBlack,
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Image.asset(
                                'assets/images/business.png',
                                height: 70,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Expanded(
                                  child: Text(
                                    'Business account allows you to create and manage and add your own services your own business profile.',
                                    style: heading6.copyWith(
                                      fontSize: 14,
                                      color: adminstatus
                                          ? Colors.white
                                          : textBlack,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
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
                          adminstatus = false;
                        });
                      },
                      child: SizedBox(
                        height: 300,
                        child: Card(
                          color: !adminstatus ? primaryBlue : Colors.white,
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Tourist\nAccount',
                                style: heading2.copyWith(
                                    color:
                                        !adminstatus ? Colors.white : textBlack,
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Image.asset(
                                'assets/images/tourist.png',
                                height: 70,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Expanded(
                                  child: Text(
                                    'Tourist account allows you to browse places and book hotels and other services.',
                                    style: heading6.copyWith(
                                      fontSize: 14,
                                      color: !adminstatus
                                          ? Colors.white
                                          : textBlack,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserDetails(
                                    adminstatus: adminstatus,
                                  )),
                        );
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
    );
  }
}
