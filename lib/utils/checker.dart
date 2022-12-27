import 'package:blood/auth/auth.dart';
import 'package:blood/screens/Homepage.dart';
import 'package:blood/screens/Login_Screen.dart';
import 'package:blood/screens/NavigationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Checker extends StatelessWidget {
  const Checker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot) {
          if(snapshot.hasData){
            return NavigationScreen();
          }else{
            return Auth();
          }
        },
      ),
    );
  }
}