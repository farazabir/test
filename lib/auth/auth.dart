import 'package:blood/screens/Login_screen.dart';
import 'package:blood/screens/Signup_screen.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  
  //show login screen
  bool showLoginScreen = true;

  void toggleScreens(){
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginScreen){
      return LoginScreen();
    }else{
      return SignUp();
    }
  }
}