import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/utils/theamscolors.dart';

class DropOfPending extends StatelessWidget {
  const DropOfPending({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ThemColors.buttonColor,
        centerTitle: true,
        title: AutoSizeText(
          "Drops Of Pending ",
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
                      child: Container(
                        height: size.height*0.11,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.all(Radius.circular(size.height*0.02))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: size.width*0.03,),
                                const Icon(CupertinoIcons.gift,color: Colors.black87,),
                                SizedBox(width: size.width*0.03,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      "Order_Id-VEN001",
                                      style: GoogleFonts.cabin(
                                          color: Colors.black87
                                      ),

                                    ),
                                    AutoSizeText(
                                      "Order date and time",
                                      style: GoogleFonts.cabin(
                                          color: Colors.black87
                                      ),

                                    ),                ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AutoSizeText(
                                  "Status",
                                  style: GoogleFonts.cabin(
                                      color: Colors.black87
                                  ),

                                ),
                                SizedBox(width: size.width*0.03,),
                              ],
                            ),
                          ],
                        ),
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
