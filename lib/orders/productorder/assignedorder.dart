import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/checkout.dart';
import '../../constrant.dart';
import '../../routes/routesname.dart';



class AssignedOrder extends StatefulWidget {
  const AssignedOrder({super.key});

  @override
  State<AssignedOrder> createState() => _AssignedOrderState();
}

class _AssignedOrderState extends State<AssignedOrder> {

  bool loading=true;
  Map<String ,dynamic>data={};
  final scrollController=ScrollController();
  bool isLoadingMoreData=false;
  int page=1;
  List <dynamic> orderData=[];



  @override
  void initState() {
    // TODO: implement initState
    CheckOut().allDeliveredOrder("PRODUCT", "ASSIGNED",page,5).then((value) {
      if(value.isNotEmpty){
        orderData=orderData+value["data"];
        loading=false;
        setState(() {
        });
      }
    });
    scrollController.addListener(pagination);
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
        child:   loading
            ?
        Center(
          child: SizedBox(
            height: size.height*0.03,
            width: size.height*0.03,
            child: const CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
        )
            :
        orderData.isNotEmpty

            ?
        Padding(
          padding:  EdgeInsets.only(right: size.width*0.02,left: size.width*0.02),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height:  ( size.height*0.13*orderData.length)+size.height*0.15,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: scrollController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:orderData.length,
                    itemBuilder:(context, index) {

                      if(index<orderData.length){
                        return  InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, RoutesName.assignedOrderDetail,arguments:orderData[index]);
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
                                            "Order_ID-${orderData[index]["order_id"]}",
                                            style: GoogleFonts.cabin(
                                                color: Colors.black87,
                                                fontSize: size.height*0.018,
                                                fontWeight: FontWeight.w400
                                            ),

                                          ),
                                          AutoSizeText(
                                            "${orderData[index]["createdAt"].toString().split("T")[0]} - ${(orderData[index]["createdAt"].toString().split("T")[1]).split(".")[0]}",

                                            style: GoogleFonts.cabin(
                                                color: Colors.black87,
                                                fontSize: size.height*0.017,
                                                fontWeight: FontWeight.w400
                                            ),

                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      AutoSizeText(
                                        "${orderData[index]["delivery_type"]}",
                                        style: GoogleFonts.cabin(
                                            color: Colors.black87,
                                            fontSize: size.height*0.018,
                                            fontWeight: FontWeight.w400
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
                      }
                      else{
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      }
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

  void pagination() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent ) {
      if (!isLoadingMoreData) {
        page++;
        setState(() {
          isLoadingMoreData = true;
        });
        CheckOut().allDeliveredOrder("PRODUCT", "ASSIGNED",page,5).then((value) {
          if(value.isNotEmpty){
            orderData=orderData+value["data"];
          }
          else{
            setState(() {
              isLoadingMoreData = false;
            });
          }

        });
      }
      else{
        isLoadingMoreData=false;

      }
    }
  }
}
