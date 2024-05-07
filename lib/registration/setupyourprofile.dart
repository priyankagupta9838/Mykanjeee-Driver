import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl/intl.dart';

import '../constrant.dart';
import '../routes/routesname.dart';
import '../utilityfunction.dart';

class UserRegistrationProfile extends StatefulWidget {
  UserRegistrationProfile({Key? key,required this.selectedService}) : super(key: key);
  String selectedService="";
  @override
  State<UserRegistrationProfile> createState() => _UserRegistrationProfileState();
}

class _UserRegistrationProfileState extends State<UserRegistrationProfile> {
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController dobController=TextEditingController();
  TextEditingController mobileNumberController=TextEditingController();
  TextEditingController alternativeMobileNumberController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController address1Controller=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController pinCode1Controller=TextEditingController();
  String profilePath="";
  String profileUrl="";

  String mobilePattern =r'^(?:\+?91)?[0-9]{10}$';

  //r'(^(?:[+0]9)?[0-9]{10,12}$)';
  bool validMobile=true;
  bool validAltMobile=true;
  bool emailValidation=true;
  bool pinValidation=true;
  @override
  void initState() {
    // TODO: implement initState

    // if(userRegisterData.isNotEmpty){
    //   firstNameController.text=userRegisterData['firstName']??"" ;
    //   lastNameController.text=userRegisterData['lastName']??"";
    //   mobileNumberController.text=userRegisterData['mobileNumber']??"";
    //   alternativeMobileNumberController.text=userRegisterData['alternativeMobile']??"";
    //   emailController.text= userRegisterData['email']??"";
    //   address1Controller.text=userRegisterData['address1']??"";
    //   city1Controller.text=userRegisterData['city1']??"";
    //   pinCode1Controller.text= userRegisterData['pincode1']??"";
    //
    //
    // }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: size.height*0.028,
              ),
              Container(
                color: const Color.fromRGBO(247, 244, 249, 1),
                height: size.height*0.12,
                width: size.width,
                child: Padding(
                  padding:  EdgeInsets.only(left: size.width*0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(CupertinoIcons.arrow_left,color: Colors.black,) ),
                      SizedBox(height: size.height*0.02,),
                      AutoSizeText("Your Profile",style: GoogleFonts.openSans(
                          decoration: TextDecoration.none,
                          color: const Color.fromRGBO(28, 28, 30, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: size.height*0.025

                      ),),


                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              GestureDetector(
                onTap: () async {
                  // await UtilityFunctions().imagePicker().then((value) {
                  //   if(value.isNotEmpty){
                  //     setState(() {
                  //       profilePath=value.toString();
                  //
                  //     });
                  //   }
                  //
                  // });

                },
                child: SizedBox(
                  height: size.height*0.12,
                  width: size.height*0.12,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: size.height*0.06,
                        backgroundImage:profilePath!=""
                            ?
                        FileImage(File(profilePath))
                            :
                        null,
                        child:
                        profilePath==""
                            ?
                        Icon(Icons.person,size: size.height*0.06,color: Colors.grey,)
                            :
                        null,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                            backgroundColor: Colors.white60,
                            radius: size.height*0.02,
                            child: Icon(Icons.camera_alt,size: size.height*0.03,color: Colors.black87,)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height*0.028,
              ),
              SizedBox(
                width: size.width,
                height: size.height*0.09,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: size.height*0.1,
                      width: size.width*0.42,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText("First Name*",
                            style:GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize:  size.height*0.018,
                                fontWeight: FontWeight.w600
                            ) ,
                          ),
                          SizedBox(
                            height: size.height*0.01,
                          ),
                          SizedBox(
                            height: size.height*0.05,
                            width: size.width*0.9,
                            child: TextField(
                              controller: firstNameController,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: size.height*0.02,
                              ),
                              decoration: InputDecoration(

                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                                      borderSide: const BorderSide(
                                          color: Colors.black45,
                                          width: 1
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                                      borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1
                                      )
                                  ),
                                  hintText: "First Name",
                                  contentPadding: EdgeInsets.all(size.height*0.01)
                              ),
                              textAlign: TextAlign.start,

                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.1,
                      width: size.width*0.42,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText("Last Name*",
                            style:GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize:  size.height*0.018,
                                fontWeight: FontWeight.w600
                            ) ,
                          ),
                          SizedBox(
                            height: size.height*0.01,
                          ),
                          SizedBox(
                            height: size.height*0.051,
                            width: size.width*0.9,
                            child: TextField(
                              controller: lastNameController,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: size.height*0.02,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                                      borderSide: const BorderSide(
                                          color: Colors.black45,
                                          width: 1
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                                      borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1
                                      )
                                  ),
                                  hintText: "Last Name",
                                  contentPadding: EdgeInsets.all(size.height*0.01)
                              ),
                              textAlign: TextAlign.start,

                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
              SizedBox(
                height: size.height*0.01,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Date of Birth*",
                    style:GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize:  size.height*0.018,
                        fontWeight: FontWeight.w600
                    ) ,
                  ),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  SizedBox(
                    height: size.height*0.083,
                    width: size.width*0.9,
                    child:  GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(3000));
                        if (pickedDate != null) {
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            dobController.text=formattedDate;
                          });


                        } else {}
                      },
                      child: TextField(
                        controller: dobController,
                        enableSuggestions: true,
                        readOnly: true,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: size.height*0.02,
                        ),
                        enabled: false,
                        decoration: InputDecoration(
                            error: AutoSizeText(""
                                "Name and DOB should be as per pan card*",
                              maxLines: 1,
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                                fontSize: size.height*0.013,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                                borderSide:   const BorderSide(
                                    color:
                                    Colors.black54,
                                    width: 1
                                )
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                                borderSide:   const BorderSide(
                                    color:
                                    Colors.black54,
                                    width: 1
                                )
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                                borderSide:   const BorderSide(
                                    color:
                                    Colors.black54,
                                    width: 1
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                                borderSide:   const BorderSide(
                                    color:
                                    Colors.black54,
                                    width: 1
                                )
                            ),
                            hintText: "YY/MM/DD",
                            contentPadding: EdgeInsets.all(size.height*0.01)
                        ),
                        textAlign: TextAlign.start,

                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Mobile Number*",
                    style:GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize:  size.height*0.018,
                        fontWeight: FontWeight.w600
                    ) ,
                  ),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  SizedBox(
                    height: size.height*0.086,
                    width: size.width*0.9,
                    child: TextField(
                      controller: mobileNumberController,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: size.height*0.02,
                      ),
                      onChanged: (value) {
                        final regExp = RegExp(mobilePattern);
                        if (!regExp.hasMatch(value.toString())) {
                          validMobile=false;
                          setState(() {

                          });
                        }
                        else{
                          validMobile=true;
                          setState(() {

                          });
                        }
                      },
                      decoration: InputDecoration(
                          error:AutoSizeText(!validMobile?"Invalid number":"",style: GoogleFonts.openSans(
                              fontSize: size.height*0.01,
                              color: Colors.red,
                              fontWeight: FontWeight.w400
                          ),),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                              borderSide:   BorderSide(
                                  color:validMobile
                                      ?
                                  Colors.black54
                                      :
                                  Colors.red,
                                  width: 1
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                              borderSide:   BorderSide(
                                  color:
                                  validMobile
                                      ?
                                  Colors.black
                                      :
                                  Colors.red,
                                  width: 1
                              )
                          ),
                          hintText: "Mobile Number",
                          contentPadding: EdgeInsets.all(size.height*0.01)
                      ),
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Alternative Mobile Number",
                    style:GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize:  size.height*0.018,
                        fontWeight: FontWeight.w600
                    ) ,
                  ),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  SizedBox(
                    height: size.height*0.086,
                    width: size.width*0.9,
                    child: TextField(
                      controller: alternativeMobileNumberController,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: size.height*0.02,
                      ),
                      onChanged: (value) {
                        final regExp = RegExp(mobilePattern);
                        if (!regExp.hasMatch(value.toString())) {
                          validAltMobile=false;
                          setState(() {

                          });
                        }
                        else{
                          validAltMobile=true;
                          setState(() {

                          });
                        }
                      },
                      decoration: InputDecoration(
                          error:AutoSizeText(!validAltMobile?"Invalid number":"",style: GoogleFonts.openSans(
                              fontSize: size.height*0.01,
                              color: Colors.red,
                              fontWeight: FontWeight.w400
                          ),),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                              borderSide:  BorderSide(
                                  color: validAltMobile
                                      ?
                                  Colors.black54
                                      :
                                  Colors.red,
                                  width: 1
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                              borderSide:  BorderSide(
                                  color: validAltMobile
                                      ?
                                  Colors.black
                                      :
                                  Colors.red,
                                  width: 1
                              )
                          ),

                          hintText: "Alternative Mobile Number",
                          contentPadding: EdgeInsets.all(size.height*0.01)
                      ),
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height*0.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("E-Mail*",
                    style:GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize:  size.height*0.018,
                        fontWeight: FontWeight.w600
                    ) ,
                  ),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  SizedBox(
                    height: size.height*0.053,
                    width: size.width*0.9,
                    child: TextField(
                      controller: emailController,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: size.height*0.02,
                      ),
                      onChanged: (value) {
                        String emailPattern=r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                        final regExp = RegExp(emailPattern);
                        if (!regExp.hasMatch(value.toString())) {
                          emailValidation=false;
                          setState(() {

                          });
                        }
                        else{
                          emailValidation=true;
                          setState(() {

                          });
                        }
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                              borderSide:  BorderSide(
                                  color: emailValidation
                                      ?
                                  Colors.black54
                                      :
                                  Colors.red,
                                  width: 1
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                              borderSide:  BorderSide(
                                  color: emailValidation
                                      ?
                                  Colors.black54
                                      :
                                  Colors.red,
                                  width: 1
                              )
                          ),
                          hintText: "E-Mail",
                          contentPadding: EdgeInsets.all(size.height*0.01)
                      ),
                      textAlign: TextAlign.start,

                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height*0.022,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("Address *",
                    style:GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize:  size.height*0.018,
                        fontWeight: FontWeight.w600
                    ) ,
                  ),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  //29ENLPS5946F1Z8
                  SizedBox(
                    height: size.height*0.053,
                    width: size.width*0.9,
                    child:  GooglePlaceAutoCompleteTextField(

                      textEditingController: address1Controller,
                      googleAPIKey: "AIzaSyD2wofI9yNNThitezD-zqxd37HYar3ZO9U",
                      inputDecoration:InputDecoration(
                        focusedBorder:  const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black),
                        ),
                        border:  const OutlineInputBorder(

                          borderSide:
                          BorderSide(color: Colors.black38),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black38),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black38),
                        ),
                        labelText: "Address",
                        contentPadding: EdgeInsets.only(bottom: size.height*0.002),
                        prefixIcon:
                        const Icon(Icons.location_on_outlined),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              address1Controller.clear();
                              setState(() {

                              });
                            },
                            child: const Icon(Icons.cancel_outlined)),
                        prefixIconColor: Colors.grey,
                        alignLabelWithHint: true,
                        labelStyle: GoogleFonts.openSans(
                            fontSize: size.height * 0.018,
                            fontWeight: FontWeight.w400),
                      ),
                      containerVerticalPadding: 0,
                      containerHorizontalPadding: 0,
                      debounceTime: 800,
                      countries: const ["in", "fr"],
                      isLatLngRequired: true,
                      getPlaceDetailWithLatLng: (Prediction prediction) {
                      },
                      itemClick: (Prediction prediction) {
                        address1Controller.text = prediction.description!;
                        address1Controller.selection = TextSelection.fromPosition(
                            TextPosition(offset: prediction.description!.length));
                      },
                      itemBuilder: (context, index, Prediction prediction) {
                        return Row(
                          children: [
                            const Icon(Icons.location_on),
                            const SizedBox(
                              width: 7,
                            ),
                            Expanded(child: AutoSizeText(prediction.description ?? "",
                              style: GoogleFonts.openSans(
                                fontSize: size.height*0.017,
                              ),
                            ))
                          ],
                        );
                      },
                      // if you want to add seperator between list items
                      seperatedBuilder: const Divider(),
                      isCrossBtnShown: false,
                      //containerHorizontalPadding: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height*0.022,
              ),
              SizedBox(
                width: size.width,
                height: size.height*0.09,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: size.height*0.1,
                      width: size.width*0.42,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText("City*",
                            style:GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize:  size.height*0.018,
                                fontWeight: FontWeight.w600
                            ) ,
                          ),
                          SizedBox(
                            height: size.height*0.01,
                          ),
                          SizedBox(
                            height: size.height*0.05,
                            width: size.width*0.9,
                            child: TextField(
                              controller: cityController,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: size.height*0.02,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                                      borderSide: const BorderSide(
                                          color: Colors.black45,
                                          width: 1
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                                      borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1
                                      )
                                  ),
                                  hintText: "City",
                                  contentPadding: EdgeInsets.all(size.height*0.01)
                              ),
                              textAlign: TextAlign.start,

                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.1,
                      width: size.width*0.42,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText("Pin code*",
                            style:GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize:  size.height*0.018,
                                fontWeight: FontWeight.w600
                            ) ,
                          ),
                          SizedBox(
                            height: size.height*0.01,
                          ),
                          SizedBox(
                            height: size.height*0.051,
                            width: size.width*0.9,
                            child: TextField(
                              controller: pinCode1Controller,
                              onChanged: (value) {
                                String pinCodePattern=r'^\d{6}$';
                                final regExp = RegExp(pinCodePattern);
                                if (!regExp.hasMatch(value.toString())) {
                                  pinValidation=false;
                                  setState(() {

                                  });
                                }
                                else{
                                  pinValidation=true;
                                  setState(() {

                                  });
                                }
                              },
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: size.height*0.02,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                                      borderSide:  BorderSide(
                                          color: pinValidation
                                              ?
                                          Colors.black54
                                              :
                                          Colors.red,
                                          width: 1
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                                      borderSide:  BorderSide(
                                          color: pinValidation
                                              ?
                                          Colors.black
                                              :
                                          Colors.red,
                                          width: 1
                                      )
                                  ),
                                  hintText: "Pin code",
                                  contentPadding: EdgeInsets.all(size.height*0.01)
                              ),
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
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
                      backgroundColor: const Color.fromRGBO(174, 144, 194, 1)),
                  onPressed: () async {


                    if(
                    firstNameController.text.trim().toString().isNotEmpty && dobController.text.isNotEmpty && mobileNumberController.text.trim().toString().isNotEmpty &&
                        emailController.text.trim().toString().isNotEmpty && address1Controller.text.trim().toString().isNotEmpty &&
                        cityController.text.trim().toString().isNotEmpty && pinCode1Controller.text.trim().toString().isNotEmpty && emailValidation && validMobile && (alternativeMobileNumberController.text.trim().toString().isEmpty || (alternativeMobileNumberController.text.trim().toString().isNotEmpty && validAltMobile)) && pinValidation
                    ){
                      userRegisterData["firstName"]=firstNameController.text;
                      userRegisterData["lastName"]=lastNameController.text;
                      userRegisterData["dob"]=dobController.text;
                      userRegisterData["mobileNumber"]=mobileNumberController.text;
                      userRegisterData["alternativeMobile"]=alternativeMobileNumberController.text;
                      userRegisterData["email"]=emailController.text;
                      userRegisterData["address1"]=address1Controller.text;
                      userRegisterData["city1"]=cityController.text;
                      userRegisterData["pincode1"]=pinCode1Controller.text;
                     // userRegisterData["profile"]=profilePath;
                      print("User ...$userRegisterData        m,,m,,m,m,m,m,m,");

                      Navigator.pushNamed(context, RoutesName.documentVerification);



                    }
                    else{
                      UtilityFunctions().errorToast("Please provide all (*) fields.");
                    }
                  },
                  child: AutoSizeText("Continue",

                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: size.height*0.022,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height*0.035,
              ),
            ],
          ),
        ),
      ),
    );
  }


}
