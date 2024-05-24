import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/checkout.dart';
import '../../constrant.dart';
import '../../routes/routesname.dart';



class AssignedOrder extends StatelessWidget {
  const AssignedOrder({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: userModel["is_active"]==1
          ?


      StreamBuilder(
        stream: CheckOut().getOngoingOrders(),
        builder: (context, snapshot) {
          if(snapshot.hasData){

            var data=jsonDecode(snapshot.data!.body);
            print("order data is... $data");
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
                              Navigator.pushNamed(context, RoutesName.assignedOrderDetail,arguments:data["data"][index]);
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
                                          "${data['data'][index]["delivery_type"]}",
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height*0.2,
                      width: size.width*0.4,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/no_order_found.jpg"),
                            fit: BoxFit.fill
                        ),

                      ),
                    ),
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    AutoSizeText(
                      "No Order found",
                      style: GoogleFonts.cabin(
                          fontSize: size.height*0.03,
                          fontWeight: FontWeight.w600
                      ),
                    ),
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
