import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourist/theme/theme.dart';
import 'package:tourist/views/adminHomepage.dart';
import 'package:tourist/views/authentication/adminchoice.dart';
import 'package:tourist/views/homepage.dart';
import 'package:tourist/widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  bool isChecked = false;
  bool adminStatus = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  setprefs({required bool isAdmin, required String name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('isAdmin', isAdmin);
      prefs.setString('name', name);
    });
  }

  late String name;
  late String email;
  isloggedinprefs({
    required String email,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('email', email);
    });
  }

  //login function
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('User not found')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Wrong Password')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong.'),
      ));
    }
    return user;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
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
                          'Login to your\naccount',
                          style: heading2.copyWith(color: textBlack),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'assets/images/accent.png',
                          width: 99,
                          height: 4,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: textWhiteGrey,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter email';
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return 'Please enter valid email';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email',
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
                          Container(
                            decoration: BoxDecoration(
                              color: textWhiteGrey,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                }

                                return null;
                              },
                              controller: passwordController,
                              obscureText: !passwordVisible,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: heading6.copyWith(color: textGrey),
                                suffixIcon: IconButton(
                                  color: textGrey,
                                  splashRadius: 1,
                                  icon: Icon(passwordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                  onPressed: togglePassword,
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  isChecked ? primaryBlue : Colors.transparent,
                              borderRadius: BorderRadius.circular(4.0),
                              border: isChecked
                                  ? null
                                  : Border.all(color: textGrey, width: 1.5),
                            ),
                            width: 20,
                            height: 20,
                            child: isChecked
                                ? const Icon(
                                    Icons.check,
                                    size: 20,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text('Remember me', style: regular16pt),
                      ],
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

                                await loginUsingEmailPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        context: context)
                                    .then((value) async {
                                  var firebaseUser =
                                      FirebaseAuth.instance.currentUser!;
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(firebaseUser.uid)
                                      .get()
                                      .then((value) {
                                    setprefs(
                                      isAdmin: value.data()!['isAdmin'],
                                      name: value.data()!['name'],
                                    );
                                    setState(() {
                                      adminStatus = value.data()!['isAdmin'];
                                      name = value.data()!['name'];
                                      email = value.data()!['email'];
                                    });
                                  });
                                  if (isChecked) {
                                    isloggedinprefs(
                                        email: emailController.text);
                                  }
                                  if (value != null) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => adminStatus
                                            ? AdminHomePage(
                                                name: name,
                                                email: email,
                                              )
                                            : HomePage(
                                                name: name,
                                                email: email,
                                              ),
                                      ),
                                    );
                                  }
                                });
                                setState(() {
                                  loading = false;
                                });
                              }
                            },
                            borderRadius: BorderRadius.circular(14.0),
                            child: Center(
                              child: Text(
                                "Login",
                                style: heading5.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: Text(
                        'OR',
                        style: heading6.copyWith(color: textGrey),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomPrimaryButton(
                      buttonColor: const Color(0xfffbfbfb),
                      textValue: 'Login with Google',
                      textColor: textBlack,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: regular16pt.copyWith(color: textGrey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const ChooseAdmin(),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
                            style: regular16pt.copyWith(color: primaryBlue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
