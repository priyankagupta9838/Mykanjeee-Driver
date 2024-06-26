import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/api/checkout.dart';
import 'package:mykanjeedriver/utils/theamscolors.dart';
import 'package:searchfield/searchfield.dart';
import '../../Statemanagement/PageBlok.dart';
import '../../Statemanagement/PageEvents.dart';
import '../../Statemanagement/PageState.dart';
import '../../constrant.dart';
import '../../utilityfunction.dart';





class AssignedServiceOrderDetail extends StatefulWidget {
  AssignedServiceOrderDetail({super.key,required this.data});
  Map<dynamic,dynamic>data;
  @override
  State<AssignedServiceOrderDetail> createState() => _AssignedServiceOrderDetailState();
}
class _AssignedServiceOrderDetailState extends State<AssignedServiceOrderDetail> {
  List<String>services=['Accept','Reject',];
  String imageKey="";
  bool imagePhotoUploaded=false;
  bool buttonClick=false;
  bool reject=false;
  SearchController searchController=SearchController();
  TextEditingController errorController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 227, 240,1),
      appBar:AppBar(
        backgroundColor: const Color.fromRGBO(194, 172, 209, 1),
        title:  AutoSizeText("Assign Service Order Details",style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: size.height*0.022,
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

                  AutoSizeText("Assign to you",style: GoogleFonts.openSans(
                      color: Colors.black87,
                      fontSize: size.height*0.019,
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
                      fontSize: size.height*0.02,
                      fontWeight: FontWeight.w500
                  ),),

                ],
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
                      // :
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
                height: size.height*0.023,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("update Order Status",style: GoogleFonts.openSans(
                      color: Colors.black87,
                      fontSize: size.height*0.02,
                      fontWeight: FontWeight.w500
                  ),),
                  SizedBox(
                    height: size.height*0.01,
                  ),

                  SizedBox(
                    height: size.height*0.06,
                    child: SearchField(
                      suggestionItemDecoration: SuggestionDecoration(

                      ),
                      key: const Key('searchfield'),

                      controller: searchController,
                      readOnly: true,
                      searchStyle: GoogleFonts.openSans(
                          decoration: TextDecoration.none,
                          color: Colors.black87,
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w500),
                      suggestionStyle: GoogleFonts.openSans(


                          color: Colors.black,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w500),
                      suggestionsDecoration: SuggestionDecoration(


                          color: Colors.purple.shade50,
                          //shape: BoxShape.rectangle,

                          padding: EdgeInsets.all(size.height * 0.015),
                          // border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(0)),
                      searchInputDecoration: InputDecoration(

                          filled: true,
                          suffixIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black87,
                          ),
                          hintText: "Please Select",

                          hintStyle: GoogleFonts.openSans(
                              color: Colors.grey,
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w500),
                          contentPadding: EdgeInsets.only(
                              top: size.height * 0.01,
                              left: size.height * 0.02),

                          focusedBorder: OutlineInputBorder(

                              borderRadius: BorderRadius.circular(
                                  size.height * 0.01)
                          ),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  size.height * 0.01)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(

                                  size.height * 0.01)
                          ),


                          fillColor: Colors.white,

                          border: InputBorder.none
                      ),
                      onSuggestionTap: (value) {
                        if(value.searchKey=="Reject")
                        {
                          reject=true;

                          setState(() {
                            FocusScope.of(context).unfocus();

                          });
                        }
                        else{
                          reject=false;
                          setState(() {
                            FocusScope.of(context).unfocus();

                          });
                        }

                      },
                      enabled: true,
                      itemHeight: 50,
                      maxSuggestionsInViewPort: 2,
                      suggestions:
                      services.map((e) => SearchFieldListItem(e))
                          .toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height*0.03,
              ),
              reject
                  ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Write the Reason here",style: GoogleFonts.openSans(
                      color: Colors.black87,
                      fontSize: size.height*0.02,
                      fontWeight: FontWeight.w500
                  ),),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  SizedBox(
                    height: size.height*0.1,
                    child:  TextField(
                      controller: errorController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:BorderRadius.all(Radius.circular(size.height*0.01)),
                              borderSide: const BorderSide(color: Colors.black87)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:BorderRadius.all(Radius.circular(size.height*0.01)),
                              borderSide: const BorderSide(color: Colors.black87)
                          ),
                          disabledBorder: OutlineInputBorder(
                              borderRadius:BorderRadius.all(Radius.circular(size.height*0.01)),
                              borderSide: const BorderSide(color: Colors.black87)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:BorderRadius.all(Radius.circular(size.height*0.01)),
                              borderSide: const BorderSide(color: Colors.black87)
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius:BorderRadius.all(Radius.circular(size.height*0.01)),
                              borderSide: const BorderSide(color: Colors.black87)
                          )

                      ),

                    ),
                  ),
                ],
              )
                  :
              const SizedBox(),
              SizedBox(
                height: size.height*0.017,
              ),



              SizedBox(
                height: size.height*0.06,
              ),
              BlocBuilder<AssignedServiceBlo,AssignedServiceState>(builder: (context, state) {

                return
                  SizedBox(
                    height: size.height*0.052,
                    width: size.width*0.95,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(size.height*0.01))),
                          backgroundColor:ThemColors.buttonColor


                      ),
                      onPressed: () {

                        if(!buttonClick){
                          if(searchController.text.trim().toString().isNotEmpty){

                            if(searchController.text=="Reject"){
                              if(errorController.text.isNotEmpty){
                                buttonClick=true;
                                setState(() {
                                });
                                CheckOut().rejectOrderByDriver(widget.data["order_data"]["id"],errorController.text).then((value) {
                                  if(value=="success"){
                                    // BlocProvider.of<AssignedServiceBlo>(context).add(AssignedServiceUpdateEvent());

                                    UtilityFunctions().successToast("Order Rejected Successfully");
                                    Navigator.pop(context);
                                    serviceOrderPageController.jumpToPage(1
                                    );
                                  }else{
                                    UtilityFunctions().successToast(value.toString());

                                    buttonClick=false;
                                    setState(() {

                                    });

                                  }

                                });
                              }
                              else{
                                UtilityFunctions().successToast("Please write the reason");
                              }
                            }
                            else{
                              buttonClick=true;
                              setState(() {

                              });
                              CheckOut().acceptOrderByDriver(widget.data["order_data"]["id"]).then((value) {
                                if(value=="success"){
                                  BlocProvider.of<AssignedServiceBlo>(context).add(AssignedServiceUpdateEvent());

                                  UtilityFunctions().successToast("Order Accepted Successfully");
                                  Navigator.pop(context);
                                  serviceOrderPageController.jumpToPage(1);

                                }else{
                                  UtilityFunctions().successToast(value.toString());

                                  buttonClick=false;
                                  setState(() {

                                  });

                                }

                              });
                            }

                          }
                          else{
                            UtilityFunctions().errorToast("Please Select the Order Status");
                          }



                        }else{
                          UtilityFunctions().errorToast("Please Wait...");
                        }


                      },
                      child:

                      buttonClick
                          ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Center(
                            child: SizedBox(
                              height: size.height*0.03,
                              width: size.height*0.03,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                          :
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          AutoSizeText("Update Order Status",
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: size.height*0.022,
                                fontWeight: FontWeight.w500
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
              },),

              SizedBox(
                height: size.height*0.03,
              ),
            ],
          ),
        ),
      ),
    );

  }
}