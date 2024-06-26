import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utilityfunction.dart';

class RejectedServiceOrderDetail extends StatefulWidget {
  RejectedServiceOrderDetail({super.key,required this.data});
  Map<dynamic,dynamic>data;
  @override
  State<RejectedServiceOrderDetail> createState() => _RejectedServiceOrderDetailState();
}
class _RejectedServiceOrderDetailState extends State<RejectedServiceOrderDetail> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 227, 240,1),
      appBar:AppBar(
        backgroundColor: const Color.fromRGBO(194, 172, 209, 1),
        title:  AutoSizeText("Rejected Service Order Details",style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: size.height*0.025,
            fontWeight: FontWeight.w400
        ),),
        centerTitle: true,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,size:size.width*0.065,color: Colors.white,)),
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: size.width*0.03,right: size.width*0.03),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: size.height*0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText("Order Id",style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),),
                  AutoSizeText(widget.data["order_id"].toString(),style: GoogleFonts.openSans(
                      color: Colors.black87,
                      fontSize: size.height*0.022,
                      fontWeight: FontWeight.w500
                  ),)
                ],
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText("Package Id",style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),),
                  AutoSizeText("${widget.data["order_details"][0]["packageId"]}",style: GoogleFonts.openSans(
                      color: Colors.black87,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),)
                ],
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText("Item List",style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),),

                ],
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    "${widget.data["order_details"].length}X ${  widget.data["order_details"][0]["quote"]["service"]["name"].toString()=="UPCYCLE"? widget.data["order_details"][0]["quote"]["services_by_vendor"]["clothing_item_type"].toString() :widget.data["order_details"][0]["quote"]["services_by_vendor"]["material_type"].toString()}",

                    style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),),

                  AutoSizeText("Rs.${(widget.data["order_data"]["total_amount"]).toStringAsFixed(2).toString()}",style: GoogleFonts.openSans(
                      color: Colors.black87,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),)

                ],
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText("Current_order_status",style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),),

                  AutoSizeText("Rejected",style: GoogleFonts.openSans(
                      color: Colors.black87,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),)

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText("Time slot",style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),),

                ],
              ),
              SizedBox(
                height: size.height*0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    widget.data["order_data"]["time_slot"].toString().isNotEmpty

                        ?
                    widget.data["order_data"]["time_slot"].toString()
                        :
                    "Day"



                    ,style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),),

                ],
              ),

              SizedBox(
                height: size.height*0.023,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText("Address",style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),),

                ],
              ),
              SizedBox(
                height: size.height*0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width*0.8,
                    child: AutoSizeText(
                      // widget.data["delivery_type"]=="DELIVERY"?
                      //
                      // widget.data["delivery_address"].toString()
                      //
                      //
                      //     :
                      widget.data["pickup_address"].toString()
                      ,style: GoogleFonts.openSans(
                        color: Colors.black54,

                        fontSize: size.height*0.019,
                        fontWeight: FontWeight.w500
                    ),

                    ),
                  ),
                  InkWell(
                      onTap: (){
                        if(widget.data["delivery_address"]!=null && widget.data["delivery_address"]!=""){
                          UtilityFunctions().openGoogleMaps(widget.data["delivery_address"].toString());
                        }else if(widget.data["pickup_address"]!=null && widget.data["pickup_address"]!=""){
                          UtilityFunctions().openGoogleMaps(widget.data["delivery_address"].toString());
                        }
                      },
                      child: Icon(Icons.location_on,color: Colors.purple.shade300,size: size.width*0.1,))

                ],
              ),
              SizedBox(
                height: size.height*0.017,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    widget.data["order_data"]["time_slot"].toString().isNotEmpty

                        ?
                    widget.data["order_data"]["time_slot"].toString()
                        :
                    "Day"
                ,style: GoogleFonts.openSans(
                      color: Colors.black87,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),),

                ],
              ),

              SizedBox(
                height: size.height*0.023,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText("Order Status",style: GoogleFonts.openSans(
                          color: Colors.black54,
                          fontSize: size.height*0.019,
                          fontWeight: FontWeight.w500
                      ),),
                      AutoSizeText("Rejected",style: GoogleFonts.openSans(
                          color: Colors.red,
                          fontSize: size.height*0.019,
                          fontWeight: FontWeight.w500
                      ),),
                    ],
                  ),
                  SizedBox(
                    height: size.height*0.01,
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );

  }
}