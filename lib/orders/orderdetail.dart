import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mykanjeedriver/utils/theamscolors.dart';
import 'package:searchfield/searchfield.dart';
import 'dart:io';
import '../utilityfunction.dart';
class OrderDetail extends StatefulWidget {
   OrderDetail({super.key,required this.data});
   Map<dynamic,dynamic>data;
  @override
  State<OrderDetail> createState() => _OrderDetailState();
}
class _OrderDetailState extends State<OrderDetail> {
  List<String>services=['Accept','Reject','Delivered'];
  String establishmentLicenseImage="";

  SearchController searchController=SearchController();
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
                      suggestionItemDecoration: SuggestionDecoration(),
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
                        setState(() {
                          FocusScope.of(context).unfocus();

                        });
                      },
                      enabled: true,
                      itemHeight: 50,
                      maxSuggestionsInViewPort: 3,
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
                        establishmentLicenseImage.isNotEmpty
                            ? Icon(Icons.check_circle,
                            color: Colors.green,
                            size: size.height * 0.033)
                            : const Icon(
                          CupertinoIcons.cloud_upload,
                          color: Colors.purple,
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
                                      if (fileSizeInMB <= 7) {
                                        establishmentLicenseImage = value.path;
                                        setState(() {});
                                        print(
                                            "Embesimemt path : $establishmentLicenseImage");
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
                        const AutoSizeText("PDF or JPG (max 7 MB)")
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

                  },
                  child: Row(
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