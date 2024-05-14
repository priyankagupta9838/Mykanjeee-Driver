import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/routes/routesname.dart';
import 'package:mykanjeedriver/utils/theamscolors.dart';

import '../api/checkout.dart';
import '../constrant.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ThemColors.buttonColor,
        title: AutoSizeText(
          "Hi User",
          style: GoogleFonts.cabin(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.userProfile);
              },
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ))
        ],
      ),
      body:

      userModel["is_active"]==1
          ?

      StreamBuilder(
        stream: CheckOut().getOngoingOrders(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data=jsonDecode(snapshot.data!.body);
            return snapshot.data?.statusCode==200 && data["data"].length>0
            ?
            Padding(
               padding: EdgeInsets.only(
                   right: size.width * 0.02, left: size.width * 0.02),
               child: SingleChildScrollView(
                 scrollDirection: Axis.vertical,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(
                       height: size.height * 0.13,
                       width: size.width,
                       child: Padding(
                         padding: const EdgeInsets.all(3),
                         child: Card(
                           color: ThemColors.buttonColor,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               AutoSizeText(
                                 "4",
                                 style: GoogleFonts.cabin(color: Colors.white),
                               ),
                               AutoSizeText(
                                 "Delivery Waiting",
                                 style: GoogleFonts.cabin(color: Colors.white),
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),
                     SizedBox(
                       height: size.height * 0.01,
                     ),
                     AutoSizeText(
                       "Recent Activity",
                       style: GoogleFonts.cabin(
                           color: Colors.black87,
                           fontSize: size.height * 0.02,
                           fontWeight: FontWeight.w600),
                     ),
                     SizedBox(
                       height: size.height * 0.015,
                     ),
                     SizedBox(
                       height: size.height * 0.13 * 5,
                       child: ListView.builder(
                         scrollDirection: Axis.vertical,
                         physics: const NeverScrollableScrollPhysics(),
                         itemCount: 2,
                         itemBuilder: (context, index) {
                           return Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                               height: size.height * 0.11,
                               width: size.width,
                               decoration: BoxDecoration(
                                   color: Colors.grey.shade200,
                                   borderRadius: BorderRadius.all(
                                       Radius.circular(size.height * 0.02))),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       SizedBox(
                                         width: size.width * 0.03,
                                       ),
                                       const Icon(
                                         CupertinoIcons.gift,
                                         color: Colors.black87,
                                       ),
                                       SizedBox(
                                         width: size.width * 0.03,
                                       ),
                                       Column(
                                         mainAxisAlignment:
                                         MainAxisAlignment.center,
                                         crossAxisAlignment:
                                         CrossAxisAlignment.center,
                                         children: [
                                           AutoSizeText(
                                             "Order_Id-VEN001",
                                             style: GoogleFonts.cabin(
                                                 color: Colors.black87),
                                           ),
                                           AutoSizeText(
                                             "Order date and time",
                                             style: GoogleFonts.cabin(
                                                 color: Colors.black87),
                                           ),
                                         ],
                                       ),
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       AutoSizeText(
                                         "Delivered",
                                         style: GoogleFonts.cabin(
                                             color: Colors.black87),
                                       ),
                                       SizedBox(
                                         width: size.width * 0.03,
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                           );
                         },
                       ),
                     )
                   ],
                 ),
               ),
             )
                :
            Padding(
              padding: EdgeInsets.only(
                  right: size.width * 0.02, left: size.width * 0.02),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.13,
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Card(
                          color: ThemColors.buttonColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AutoSizeText(
                                "0",
                                style: GoogleFonts.cabin(color: Colors.white),
                              ),
                              AutoSizeText(
                                "Delivery Waiting",
                                style: GoogleFonts.cabin(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    AutoSizeText(
                      "Recent Activity",
                      style: GoogleFonts.cabin(
                          color: Colors.black87,
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    SizedBox(
                      height: size.height * 0.13 * 5,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: size.height * 0.11,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.height * 0.02))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                      const Icon(
                                        CupertinoIcons.gift,
                                        color: Colors.black87,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                            "Order_Id-VEN001",
                                            style: GoogleFonts.cabin(
                                                color: Colors.black87),
                                          ),
                                          AutoSizeText(
                                            "Order date and time",
                                            style: GoogleFonts.cabin(
                                                color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      AutoSizeText(
                                        "Delivered",
                                        style: GoogleFonts.cabin(
                                            color: Colors.black87),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );

          }
         else{
            return  const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
        },
      )

          :
      SizedBox(
        height: size.height*1,
        child: Center(
          child: AutoSizeText("Not Active",style: GoogleFonts.cabin(
              fontWeight: FontWeight.w600,
              fontSize: size.height*0.03
          ),),
        ),
      )
      ,
    );
  }
}
