import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

import 'connectivity.dart';

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade200,
              Colors.purple.shade50,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: size.width * 0.03, right: size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.08),
              SizedBox(height: size.height * 0.15),
              CircleAvatar(
                backgroundColor: Colors.purple,
                radius: size.height * 0.04,
                backgroundImage: const AssetImage("assets/logo/download.png"),
              ),
              SizedBox(height: size.height * 0.05),
              SizedBox(
                height: size.height * 0.07,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AutoSizeText(

                      "You're almost there!",
                      style: GoogleFonts.cabin(

                        color: Colors.black87,
                        fontSize: size.height * 0.022,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AutoSizeText(
                      "Follow the step listed below.",
                      style: GoogleFonts.cabin(

                        color: Colors.black87,
                        fontSize: size.height * 0.022,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: size.height * 0.1),
              SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.04,
                child: AutoSizeText(
                  "• Fill in your bank detail",
                  style: GoogleFonts.cabin(
                    color: Colors.black87,
                    fontSize: size.height * 0.022,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.07,
                child: AutoSizeText(
                  "• Keep your PAN card and Aadhar card\n   ready to go ",
                  style: GoogleFonts.cabin(
                    color: Colors.black87,
                    fontSize: size.height * 0.022,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.08,
                child: AutoSizeText(
                  "• Proceed to list your pre-loved items for\n   sale.",
                  style: GoogleFonts.cabin(
                    color: Colors.black87,
                    fontSize: size.height * 0.022,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.18),
              ElevatedButton(

                style: ElevatedButton.styleFrom(
                  elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(size.height*0.01))),
                    backgroundColor: const Color.fromRGBO(174, 144, 194, 1)
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckConnection(),));
                },
                child: Center(
                  child: AutoSizeText(
                    "Continue",
                    style: GoogleFonts.cabin(
                      color: Colors.white,
                      fontSize: size.height * 0.022,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
