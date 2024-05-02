import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/utils/theamscolors.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ThemColors.buttonColor,
        centerTitle: true,
        title: AutoSizeText(
          "Notification",
          style: GoogleFonts.cabin(
              color: Colors.white
          ),

        ),

      ),
      body:Padding(
        padding:  EdgeInsets.only(right: size.width*0.02,left: size.width*0.02),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              SizedBox(
                height:  size.height*1,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder:(context, index) {

                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            height: size.height*0.15,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.all(Radius.circular(size.height*0.02))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  AutoSizeText(
                                    "Payment Reminder",
                                    style: GoogleFonts.cabin(
                                        color: Colors.black87,
                                      fontSize: size.height*0.025,
                                      fontWeight: FontWeight.w500
                                    ),

                                  ),
                                  AutoSizeText(
                                    "Your Order has been shipped \n and is on its way ",
                                    style: GoogleFonts.cabin(
                                        color: Colors.black87,
                                        fontSize: size.height*0.02
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.topRight,

                              child: Icon(CupertinoIcons.multiply))
                        ],
                      ),
                    );
                  },),
              )
            ],
          ),
        ),
      ),
    );
  }
}
