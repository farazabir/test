import 'package:blood/screens/FindDonor.dart';
import 'package:blood/screens/Homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import "package:flutter/material.dart";


class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
    
  int currentPageIndex = 0 ;
  
  final screens = [
    Center(child: Homepage(),),
    Center(child: FindDonor(),),
    Center(child: Homepage(),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffFEF6F6),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor:Color(0xffFEF6F6),
        color: Colors.redAccent.withOpacity(.8),
        
        items:[
          Icon(Icons.home),
          Icon(Icons.map),
          Icon(Icons.person),
        ] ,
        onTap: (index){
          setState(() {
            currentPageIndex = index;
            print(index);
          });
        },
      ),
      body: screens[currentPageIndex],
    );
  }
}