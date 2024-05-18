
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'connectivity.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      splashIconSize: size.height,
      duration: 3000,
      splash: Container(
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
              SizedBox(
                height: size.height * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(right: size.width*0.04),
                    child: IconButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckConnection(),));

                    }, icon: Icon(
                      CupertinoIcons.arrow_right,
                      color: Colors.white,
                      size: size.height*0.03,
                    )),
                  )

                ],
              ),

              SizedBox(
                height: size.height * 0.15,
              ),
              AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child:   CircleAvatar(
                  backgroundColor: Colors.purple,
                  radius: size.height*0.04,
                  backgroundImage: const AssetImage("assets/logo/download.png"),
                ),

              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: SizedBox(
                  height: size.height * 0.05,
                  child: AutoSizeText(
                    "Welcome to MyKanjee",
                    style: GoogleFonts.cabin(
                      color: Colors.black87,
                      fontSize: size.height * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 3),
                child: SizedBox(
                  height: size.height * 0.03,
                  child: AutoSizeText(
                    "Join our sustainable fashion community",
                    style: GoogleFonts.cabin(
                      color: Colors.black87,
                      fontSize: size.height * 0.022,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 3),
                child: SizedBox(

                  height: size.height * 0.03,
                  child: AutoSizeText(
                    "Join our thriving  community to buy,sell",
                    style: GoogleFonts.cabin(
                      color: Colors.black87,
                      fontSize: size.height * 0.022,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 3),
                child: SizedBox(

                  height: size.height * 0.03,
                  child: AutoSizeText(
                    "and upcycle your clothes",
                    style: GoogleFonts.cabin(
                      color: Colors.black87,
                      fontSize: size.height * 0.021,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      animationDuration: const Duration(milliseconds: 300),
      centered: true,
      nextScreen: CheckConnection(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Colors.transparent,
    );
  }
}
