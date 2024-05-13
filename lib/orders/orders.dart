import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/utils/theamscolors.dart';
import '../api/checkout.dart';
import '../routes/routesname.dart';



class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ThemColors.buttonColor,
        centerTitle: true,
        title: AutoSizeText(
          "All Orders",
          style: GoogleFonts.cabin(
              color: Colors.white
          ),

        ),

      ),
      body:StreamBuilder(
        stream: CheckOut().getOngoingOrders(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data=jsonDecode(snapshot.data!.body);
            return snapshot.data?.statusCode==200 && data["data"].length>0
                ?
              Padding(
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
                        itemCount:data["data"].length,
                        itemBuilder:(context, index) {

                          return  InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, RoutesName.orderDetail,arguments:data["data"][index]);
                            },
                            child: Padding(
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              "Order_ID-${data['data'][index]["order_id"]}",
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
                            ),
                          );
                        },),
                    )
                  ],
                ),
              ),
            )
                :
               SizedBox(
                 height: size.height,
                 width: size.width,
                 child: Center(
                   child: AutoSizeText(
                     "No Order found",
                     style: GoogleFonts.cabin(
                       fontSize: size.height*0.03,
                       fontWeight: FontWeight.w600
                     ),
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
      ),
    );
  }
}