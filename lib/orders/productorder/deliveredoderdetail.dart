import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveredOrderDetail extends StatefulWidget {
  DeliveredOrderDetail({super.key,required this.data});
  Map<dynamic,dynamic>data;
  @override
  State<DeliveredOrderDetail> createState() => _DeliveredOrderDetailState();
}
class _DeliveredOrderDetailState extends State<DeliveredOrderDetail> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 227, 240,1),
      appBar:AppBar(
        backgroundColor: const Color.fromRGBO(194, 172, 209, 1),
        title:  AutoSizeText("Order Details",style: GoogleFonts.roboto(
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
                  AutoSizeText("[Package Id]",style: GoogleFonts.openSans(
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
                  AutoSizeText("1xProduct_Title",style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),),

                  AutoSizeText("Rs 300",style: GoogleFonts.openSans(
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
                  AutoSizeText("Current_order_status",style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),),

                  AutoSizeText("status",style: GoogleFonts.openSans(
                      color: Colors.black87,
                      fontSize: size.height*0.022,
                      fontWeight: FontWeight.w500
                  ),)

                ],
              ),
              SizedBox(
                height: size.height*0.023,
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
                height: size.height*0.017,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText("[ Time_slot ]",style: GoogleFonts.openSans(
                      color: Colors.black87,
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
                  AutoSizeText("Special Instructions",style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),),

                ],
              ),
              SizedBox(
                height: size.height*0.017,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText("Delivery_special_instructions",style: GoogleFonts.openSans(
                      color: Colors.black87,
                      fontSize: size.height*0.02,
                      fontWeight: FontWeight.w500
                  ),),

                ],
              ),
              SizedBox(
                height: size.height*0.03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText("Order Status",style: GoogleFonts.openSans(
                          color: Colors.black87,
                          fontSize: size.height*0.02,
                          fontWeight: FontWeight.w500
                      ),),
                      AutoSizeText("Delivered",style: GoogleFonts.openSans(
                          color: Colors.green,
                          fontSize: size.height*0.02,
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