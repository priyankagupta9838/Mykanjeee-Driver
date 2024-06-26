/*
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/checkout.dart';
import '../../constrant.dart';
import '../../routes/routesname.dart';



class AcceptedServiceOrder extends StatefulWidget {
  const AcceptedServiceOrder({super.key});

  @override
  State<AcceptedServiceOrder> createState() => _AcceptedServiceOrderState();
}

class _AcceptedServiceOrderState extends State<AcceptedServiceOrder> {
  bool loading=true;
  Map<String ,dynamic>data={};
  final scrollController=ScrollController();
  bool isLoadingMoreData=false;
  int page=1;
  var newData = [];
  Set<int> orderIds = {};
  @override
  void initState() {
    // TODO: implement initState
    CheckOut().allAcceptedServiceOrder("QUOTE","COLLECTED").then((value) {

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
    scrollController.addListener(checkDataAndLoad);
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
        data["data"].length>0

            ?
        Padding(
          padding:  EdgeInsets.only(right: size.width*0.02,left: size.width*0.02),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ( size.height*0.13*data["data"].length)+size.height*0.15,
                  child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:data["data"].length,
                    itemBuilder:(context, index) {
                       if(index<data["data"].length){
                         return  InkWell(
                           onTap: (){
                             Navigator.pushNamed(context, RoutesName.acceptedServiceOderDetail,arguments:data["data"][index]);
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
                                                 color: Colors.black87,
                                                 fontSize: size.height*0.018,
                                                 fontWeight: FontWeight.w400
                                             ),

                                           ),
                                           AutoSizeText(
                                             "${data['data'][index]["createdAt"].toString().split("T")[0]} - ${(data['data'][index]["createdAt"].toString().split("T")[1]).split(".")[0]}",

                                             style: GoogleFonts.cabin(
                                                 color: Colors.black87,
                                                 fontSize: size.height*0.017,
                                                 fontWeight: FontWeight.w400
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


  void checkDataAndLoad() {


    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {

      if (!isLoadingMoreData) {
        print("callsed....");
        page++;

        setState(() {
          isLoadingMoreData = true;
        });
        CheckOut().allAcceptedServiceOrder("QUOTE","COLLECTED").then((value) {
          if(value.isNotEmpty){

            var newItems = value["data"];
            for (var item in newItems) {
              if (!orderIds.contains(item["id"])) {
                newData.add(item);
                orderIds.add(item["id"]);
              }
            }
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


      }
    }
  }
}
*/
