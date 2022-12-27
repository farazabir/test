import 'package:blood/screens/Homepage.dart';
import 'package:blood/screens/Login_screen.dart';
import 'package:blood/screens/Signup_screen.dart';
import 'package:blood/screens/NavigationScreen.dart';
import 'package:blood/utils/checker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';

 void main()  async {

 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();

  runApp(const MyApp());  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Checker(),
      routes: {
        "Login":(context) => LoginScreen(),
        "SignUp":(context) => SignUp(),
        "Homepage":(context) => Homepage(),
      },
    );

    
  }
}