import 'package:blood/screens/FindDonor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BloodRequest extends StatefulWidget {
  const BloodRequest({super.key});

  @override
  State<BloodRequest> createState() => _BloodRequestState();
}

class _BloodRequestState extends State<BloodRequest> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => FindDonor()));
      },
      child: Container(
        height: 60,
        width: 200,
        decoration: BoxDecoration(borderRadius:BorderRadius.circular(40),color: Color.fromARGB(255, 0, 0, 0)),
        child: Center(
          child: Text("Find Donor",
          style: GoogleFonts.roboto(
            textStyle: TextStyle(fontSize: 20,fontWeight:FontWeight.w800,color: Colors.white)
          ),
          ),
        ),
      ),
    );
  }
}