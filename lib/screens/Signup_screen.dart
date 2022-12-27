import 'dart:async';

import 'package:blood/screens/Homepage.dart';
import 'package:blood/screens/NavigationScreen.dart';
import 'package:blood/utils/checker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  _SignUpState() {
    seletedGroup = bloodgroupList[0];
  }

  //text controller
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  //list for dropdown button
  final bloodgroupList = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];
  String? seletedGroup = "";
  String? gender = "";

  //sign in
  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim());

      print("signup called");

      addUserDetails(
          firstNameController.text.trim(),
          lastNameController.text.trim(),
          seletedGroup.toString(),
          gender.toString(),
          phoneController.text.trim());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NavigationScreen()));
    } on FirebaseAuthException catch (error) {
      // Show error message
      print(error.message);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
            height: 80,
            decoration: BoxDecoration(
                color: Colors.red.shade600,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                error.message!,
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            )),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ));
    }
  }

  //add user details
  Future addUserDetails(
    String firstName,
    String lastName,
    String bloodGroup,
    String gender,
    String phone,
  ) async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection("User").add({
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "bloodGroup": bloodGroup,
      "gender": gender,
      "uid": user.uid,
    });
  }

  //dispose
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFEF6F6),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.bebasNeue(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),

                //first name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFFE0DFD5)),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "First Name",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Last Name field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFFE0DFD5)),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Last Name",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //dropdownbutton for blood group
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: DropdownButtonFormField(
                    value: bloodgroupList[0],
                    items: bloodgroupList.map((e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        seletedGroup = value as String;
                        print(seletedGroup);
                        // . print(value);
                      });
                    },
                    iconEnabledColor: Colors.redAccent,
                    decoration: InputDecoration(
                        labelText: "Blood Group",
                        labelStyle: TextStyle(color: Colors.redAccent),
                        focusColor: Colors.redAccent),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //Gender Selection
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.redAccent.shade100,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text("Select Gender",
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Radio(
                              value: "Male",
                              groupValue: gender,
                              onChanged: (e) {
                                setState(() {
                                  gender = e.toString();
                                });
                              },
                              activeColor: Colors.redAccent.shade700,
                              fillColor: MaterialStateProperty.all(
                                  Colors.redAccent.shade700),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text("Male",
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Radio(
                              value: "FeMale",
                              groupValue: gender,
                              onChanged: (e) {
                                setState(() {
                                   gender = e.toString();
                                  
                                  print(gender);
                                });
                              },
                              activeColor: Colors.redAccent.shade700,
                              fillColor: MaterialStateProperty.all(
                                  Colors.redAccent.shade700),
                            ),
                          ),
                           Padding(
                             padding: const EdgeInsets.only(right:10),
                             child: Text("Female",
                          style: GoogleFonts.lato(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                          ),
                           ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //phone number field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFFE0DFD5)),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone Number",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFFE0DFD5)),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //password Field
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFFE0DFD5)),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: passController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                //Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: InkWell(
                    onTap: () {
                      signUp();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                //Not a member
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("Login");
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
