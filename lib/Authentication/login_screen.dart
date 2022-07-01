import 'package:book_a_hall_admin_app/Screens/HomePage.dart';
import 'package:book_a_hall_admin_app/Screens/landing_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Widgets/custom_textfield.dart';
import '../constants/constants.dart';
import 'auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String adminEmail = '';
  String adminPassword = '';

  @override
  void initState() {
    super.initState();
  }

  var email = TextEditingController();
  var password = TextEditingController();
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .13,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                        child: Text(
                      'ADMIN',
                      style: TextStyle(
                          color: greenColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      'Email',
                      style: TextStyle(
                          color: greenColor, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      hintText: 'Type your email',
                      prefixIcon: Icons.person,
                      controller: email,
                      textColor: greenColor,
                      iconColor: greenColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Password',
                      style: TextStyle(
                          color: greenColor, fontWeight: FontWeight.w500),
                    ),
                    CustomTextField(
                      hintText: 'Type your Password',
                      prefixIcon: Icons.lock,
                      controller: password,
                      textColor: greenColor,
                      iconColor: greenColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const Text(
                  'Forget Password?',
                  style: TextStyle(
                      color: greenColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 70,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          await auth.loginWithEmail(email.text, password.text);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LandingPage()),
                                  (route) => false);
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Invalid Credentials.')));
                        }
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: purpleColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // getAdminCredentials() async {
  //   DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
  //       .collection(kAdmin)
  //       .doc('a9WBHXTOwETcS3Qwlx7M')
  //       .get();
  //   String tempEmail = documentSnapshot.get('email');
  //   String tempPassword = documentSnapshot.get('password');
  //   setState(() {
  //     adminEmail = tempEmail;
  //     adminPassword = tempPassword;
  //   });
  // }
}
