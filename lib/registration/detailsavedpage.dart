import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../Authentication/login.dart';

class DetailsSaved extends StatefulWidget {
  const DetailsSaved({Key? key}) : super(key: key);

  @override
  State<DetailsSaved> createState() => _DetailsSavedState();
}

class _DetailsSavedState extends State<DetailsSaved> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 0),
          childCurrent: const DetailsSaved(),
          child: const LogInPage(),
        ),
            (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 0),
            childCurrent: const DetailsSaved(),
            child: const LogInPage(),
          ),
              (route) => false,
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(194, 172, 209, 1),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.2,
                ),
                Icon(Icons.check_circle_outline_outlined, color: Colors.white, size: size.height * 0.16),
                SizedBox(
                  height: size.height * 0.02,
                ),
                AutoSizeText(
                  "Details Saved",
                  style: GoogleFonts.openSans(
                    fontSize: size.height * .035,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.2, right: size.width * 0.2),
                  child: AutoSizeText(
                    "Your details have been saved and sent to the app admin for approval.",
                    style: GoogleFonts.openSans(
                      fontSize: size.height * .0165,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
