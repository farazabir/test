import 'package:blood/main.dart';
import 'package:blood/screens/Login_screen.dart';
import 'package:blood/utils/GetuserDetails.dart';
import 'package:blood/widgets/BloodRequest.dart';
import 'package:blood/widgets/TotalUser.dart';
import 'package:blood/widgets/AllUserList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GetUserDetails userDetails = new GetUserDetails();

  @override
  initState() {
    // TODO: implement initState
    // getDoc();
    userDetails.getUserList();
    userDetails.getDoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: FutureBuilder(
          future: userDetails.getDoc(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CircularProgressIndicator(
                color: Colors.redAccent,
              );
            } else
              // ignore: curly_braces_in_flow_control_structures
              return Column(
                
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Welcome,",
                                  style: GoogleFonts.michroma(
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                  ),
                                ),
                                //logout button
                                ElevatedButton(
                                  child: Icon(
                                    Icons.logout_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    // logout function
                                    FirebaseAuth.instance.signOut();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: StadiumBorder()),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "${userDetails.firstName} ${userDetails.lastName} ",
                                style: GoogleFonts.michroma(
                                  textStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child: BloodRequest(),
                                ),
                                //tota user container
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 50, top: 30),
                                  child: TotalUser(),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                 AllUserList(),
                  
                ],
              );
          },
        ),
         
      ),
      
    );
  }
}
