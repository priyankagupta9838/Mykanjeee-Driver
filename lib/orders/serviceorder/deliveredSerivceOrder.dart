import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/checkout.dart';
import '../../constrant.dart';
import '../../routes/routesname.dart';



class DeliveredServiceOrder extends StatefulWidget {
  const DeliveredServiceOrder({super.key});

  @override
  State<DeliveredServiceOrder> createState() => _DeliveredServiceOrderState();
}

class _DeliveredServiceOrderState extends State<DeliveredServiceOrder> {
  bool loading=true;
  Map<String ,dynamic>data={};
  @override
  void initState() {
    // TODO: implement initState
    CheckOut().allAssignedOrder("QUOTE","DELIVERED").then((value) {
      if(value.isNotEmpty){
        data=value;
        loading=false;

        setState(() {

        });
      }
      else{

        loading=true;
        setState(() {

        });

      }

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: userModel["is_active"]==1
          ?



      SizedBox(
        height: size.height*1,
        child: !loading && data["data"].length>0

            ?
        Padding(
          padding:  EdgeInsets.only(right: size.width*0.02,left: size.width*0.02),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height:  ( size.height*0.13*data["data"].length)+size.height*0.15,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:data["data"].length,
                    itemBuilder:(context, index) {

                      return  InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RoutesName.dropOffOderDetail,arguments:data["data"][index]);
                        },
                        child: Padding(
                          padding:  EdgeInsets.only(bottom: size.height*0.015,right: size.width*0.02,left: size.width*0.02),
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
                ),

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height*0.2,
                ),
                Container(
                  height: size.height*0.15,
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
        )
        ,
      )
          :
      SizedBox(
        height: size.height*1,
        child: Center(
          child: AutoSizeText("You are not active",style: GoogleFonts.cabin(
              fontWeight: FontWeight.w600,
              fontSize: size.height*0.03
          ),),
        ),
      )
      ,
    );
  }
}
