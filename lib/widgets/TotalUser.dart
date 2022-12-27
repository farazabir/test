

import 'package:blood/screens/Homepage.dart';
import 'package:blood/utils/GetuserDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalUser extends StatelessWidget {
  const TotalUser({super.key});

  @override
  Widget build(BuildContext context) {

    final GetUserDetails userDetails = new GetUserDetails();

   

    return  FutureBuilder(
            future: userDetails.getTotalUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator(
                  color: Colors.redAccent,
                );
              } else
                // ignore: curly_braces_in_flow_control_structures
                return Container(
                  
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          ""'User'"",
                          style: GoogleFonts.michroma(
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                        Text(
                          ""'${userDetails.totalUser}'"",
                          style: GoogleFonts.spaceMono(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w800
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                );
            },
          );
  }
}