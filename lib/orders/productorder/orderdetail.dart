import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mykanjeedriver/api/checkout.dart';
import 'package:mykanjeedriver/utils/theamscolors.dart';
import 'package:searchfield/searchfield.dart';
import 'dart:io';
import '../../utilityfunction.dart';


class OrderDetail extends StatefulWidget {
  OrderDetail({super.key,required this.data});
  Map<dynamic,dynamic>data;
  @override
  State<OrderDetail> createState() => _OrderDetailState();
}
class _OrderDetailState extends State<OrderDetail> {
  List<String>services=['Reject','Delivered'];
  String imageKey="";
  bool imagePhotoUploaded=false;
  bool buttonClick=false;
  bool reject=false;
  SearchController searchController=SearchController();
  TextEditingController errorController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    print("${widget.data["order_data"]["id"]}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 227, 240,1),
      appBar:AppBar(
        backgroundColor: const Color.fromRGBO(194, 172, 209, 1),
        title:  AutoSizeText("Accepted Order Details",style: GoogleFonts.roboto(
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
                  AutoSizeText("${widget.data["order_details"].length}X${widget.data["order_details"][0]["product"]["product_name"].toString()}",style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: size.height*0.019,
                      fontWeight: FontWeight.w500
                  ),),

                  AutoSizeText("Rs.${(widget.data["order_data"]["total_amount"]+ widget.data["order_data"]["total_shipping"])}",style: GoogleFonts.openSans(
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
                  AutoSizeText("Address",style: GoogleFonts.openSans(
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
                  SizedBox(
                    width: size.width*0.8,
                    child: AutoSizeText(

                      "${widget.data["delivery_address"]}",style: GoogleFonts.openSans(
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
                        }
                      },
                      child: Icon(Icons.location_on,color: Colors.purple.shade300,size: size.width*0.1,))

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
                height: size.height*0.017,
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
                height: size.height*0.017,
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

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Upload a photo of product",style: GoogleFonts.openSans(
                      color: Colors.black87,
                      fontSize: size.height*0.02,
                      fontWeight: FontWeight.w500
                  ),),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  Container(
                    height: size.height * 0.15,
                    width: size.width * 1,
                    decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.grey.shade400)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        imagePhotoUploaded
                            ?
                        SizedBox(
                          height: size.height*0.03,
                          width: size.height*0.03,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                        )
                            :
                        ( imageKey.toString()== "" ||imageKey.trim().toString().isEmpty)

                            ?
                        const Icon(
                          CupertinoIcons.cloud_upload,
                          color: Colors.black54,
                        )
                            :
                        Icon(
                          Icons.check_circle_outline_outlined,
                          color: Colors.green.shade800,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker
                                      .pickImage(source: ImageSource.gallery)
                                      .then((value) async {
                                    if (value != null) {
                                      File? image = File(value.path);
                                      int fileSizeInBytes =
                                      image.lengthSync();
                                      double fileSizeInKB = fileSizeInBytes / 1024;
                                      double fileSizeInMB = fileSizeInKB / 1024;
                                      if (fileSizeInMB <= 10) {
                                        imagePhotoUploaded=true;
                                        setState(() {

                                        });
                                        UtilityFunctions().postImage("driver_status_update", value.path.toString()).then((value1) {

                                          if(value1=="Something went wrong"){
                                            imagePhotoUploaded=false;
                                            setState(() {

                                            });
                                            UtilityFunctions().errorToast(value1.toString());

                                          }else if(value1=="Please check your internet."){
                                            imagePhotoUploaded=false;
                                            setState(() {

                                            });
                                            UtilityFunctions().errorToast(value1.toString());

                                          }else{
                                            imageKey=value1.toString();
                                            imagePhotoUploaded=false;
                                            setState(() {

                                            });

                                          }

                                        });


                                        print(
                                            "Embesimemt path : ${value.path.toString()}");
                                      } else {
                                        UtilityFunctions().errorToast(
                                            "Image has large size.");
                                      }

                                      print("File size is : $fileSizeInMB");

                                    } else {
                                      UtilityFunctions().errorToast(
                                          "Please select image.");
                                    }
                                  });
                                },
                                child: const AutoSizeText("Click To Upload")),
                            const AutoSizeText("or drag and drop ")
                          ],
                        ),
                        const AutoSizeText("PNG or JPG (max 10 MB)")
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: size.height*0.03,
              ),
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
                      if(searchController.text.trim().toString().isNotEmpty && imageKey !=""){

                        if(searchController.text=="Reject"){
                         if(errorController.text.isNotEmpty){
                           buttonClick=true;
                           setState(() {

                           });
                           CheckOut().rejectOrderByCustomer(widget.data["order_data"]["id"],imageKey,errorController.text).then((value) {
                             if(value=="success"){
                               UtilityFunctions().successToast("Order Rejected Successfully");
                               Navigator.pop(context);

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
                          CheckOut().deliveredOrder(widget.data["order_data"]["id"],imageKey).then((value) {
                            if(value=="success"){
                              UtilityFunctions().successToast("Order Delivered Successfully");
                              Navigator.pop(context);

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
                        UtilityFunctions().errorToast("Please Select the Order Status and upload the image");
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
              ),
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