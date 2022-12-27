import 'package:blood/widgets/TotalUser.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class GetUserDetails {
  final user = FirebaseAuth.instance.currentUser;


  var firstName;
  var lastName;
  var phone;
  var bloodGroup;
  var totalUser;
  List userList = [];
 

  //Get Total userNumber
  getTotalUser() async {
    await FirebaseFirestore.instance.collection("User").get().then((value) {
      var userData = value.docs;
      totalUser = value.size;

      print(totalUser);
    }).catchError((e) {
      print(e);
    });
  }

  //get specific firesotre document
  getDoc() async {
    getTotalUser();
    await FirebaseFirestore.instance
        .collection("User")
        .where("uid", isEqualTo: user?.uid)
        .get()
        .then((value) {
      var userData = value.docs[0];
      firstName = userData['firstName'];
      lastName = userData['lastName'];

      phone = userData['phone'];
      bloodGroup = userData['bloodGroup'];
    }).catchError((e) {
      print(e);
    });
  }


  //get all user data 
   getUserList() async{
    

    try{
      await FirebaseFirestore.instance.collection("User").orderBy("firstName",descending: false).get()
      .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          userList.add(element.data());
          
          print(userList.length);
        });
      });
   return userList;
    } catch(e){
      print(e.toString());
      return  null;
    }
  }
}
