import 'package:url_launcher/url_launcher.dart';
import 'package:blood/utils/GetuserDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AllUserList extends StatefulWidget {
  const AllUserList({super.key});

  @override
  State<AllUserList> createState() => _AllUserListState();
}

class _AllUserListState extends State<AllUserList> {
  List userDetailsList = [];
  final GetUserDetails userDetails = new GetUserDetails();

  @override
  void initState() {
    // TODO: implement initState
    fetchUsers();

    super.initState();
  }

  fetchUsers() async {
    dynamic result = await userDetails.getUserList();

    dynamic userresult = result;

    if (result == null) {
      print("Unable to get data");
    } else {
      setState(() {
        userDetailsList = userresult;
        print(userDetails);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: userDetailsList.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.redAccent.shade200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(
                          'Name: ${ userDetailsList[index]['firstName'] } ${  userDetailsList[index]['lastName']} ' 
                             ,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 5),
                        child: Text(
                          'Blood Group: ' +
                              userDetailsList[index]['bloodGroup'],
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 5),
                        child: Text(
                          'Contact: ' + userDetailsList[index]['phone'],
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                  //call user button and send notification button
                  Column(
                    children: [
                      //send notification button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: Icon(
                            Icons.person_outlined,
                            color: Colors.white,
                            size: 19,
                          ),
                          onPressed: () {
                            // Do something when the button is pressed
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: StadiumBorder()),
                        ),
                      ),
                      //call user button
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: ElevatedButton(
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 19,
                          ),
                           onPressed: () async {
                            var url = ("tel:${userDetailsList[index]['phone']}");
                             launchUrlString(url);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: StadiumBorder()),
                        ),
                      ),
                      
                      
                    ],
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
