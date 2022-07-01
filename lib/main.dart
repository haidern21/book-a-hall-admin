import 'package:book_a_hall_admin_app/Authentication/login_screen.dart';
import 'package:book_a_hall_admin_app/Screens/HomePage.dart';
import 'package:book_a_hall_admin_app/Screens/landing_screen.dart';
import 'package:book_a_hall_admin_app/providers/chat_provider.dart';
import 'package:book_a_hall_admin_app/providers/hall_book_provider.dart';
import 'package:book_a_hall_admin_app/providers/hall_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatProvider>(
            create: (context) => ChatProvider()),
        ChangeNotifierProvider<HallBookProvider>(
            create: (context) => HallBookProvider()),
        ChangeNotifierProvider<HallProvider>(
            create: (context) => HallProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FirebaseAuth.instance.currentUser != null
              ? const LandingPage()
              : const LoginScreen()),
    );
  }
}
