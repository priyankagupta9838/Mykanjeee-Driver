import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../api/useraccount.dart';
import '../constrant.dart';
import '../utilityfunction.dart';


class UerProfile extends StatefulWidget {
  const UerProfile({Key? key}) : super(key: key);

  @override
  State<UerProfile> createState() => _UerProfileState();
}

class _UerProfileState extends State<UerProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController alternativeMobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController city1Controller = TextEditingController();
  TextEditingController pinCode1Controller = TextEditingController();
  TextEditingController city2Controller = TextEditingController();
  TextEditingController pinCode2Controller = TextEditingController();

  String profilePath = "";
  String profileUrl = "";
  String profileId="";
  bool dataFetched = false;
  bool edit = false;
  String pinCodePattern=r'^\d{6}$';
  bool pinCodeValidation1=true;
  bool addressDefault=false;
  bool loading=false;
  bool isDataNull=true;
  bool  firstNameEnable=false;
  bool  lastNameEnable=false;
  bool  mobileNumberEnable=false;
  bool  altMobileEnable=false;
  bool  emailEnable=false;
  bool validMobile=true;
  bool validAltMobile=true;
  String mobilePattern =r'^(?:\+?91)?[0-9]{10}$';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (userModel.isNotEmpty) {
      dataFetched = false;
      firstNameController.text =
      userModel["name"].toString().split(" ")[0];
      // lastNameController.text =userModel["fullname"].toString().contains(" ")
      // ?
      // userModel["fullname"].toString().split(" ")[1]
      //     :
      //     "";
      emailController.text = userModel["email"].toString() != "null"
          ? userModel["email"].toString()
          : "";
      mobileNumberController.text = userModel["phone"].toString() != "null"
          ? userModel["phone"].toString()
          : "";
    }

    UserAccount().fetchUserAccount().then((value) {
      if(value.isNotEmpty){
        firstNameController.text=value["first_name"];
        lastNameController.text=value["last_name"];
        mobileNumberController.text=value["phone"];
        alternativeMobileNumberController.text=value["alt_phone"];
        emailController.text=value["email"];
        profileId=value["id"].toString();
        loading=true;
        isDataNull=false;
        setState(() {

        });
      }
      else{
        loading=true;
        isDataNull=true;
        setState(() {

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:
            loading && isDataNull
                ?
            Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Container(
                  color: const Color.fromRGBO(247, 244, 249, 1),
                  height: size.height * 0.065,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.arrow_left,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: size.width * 0.25,
                      ),
                      AutoSizeText(
                        "Account",
                        style: GoogleFonts.openSans(
                            decoration: TextDecoration.none,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: size.height * 0.025),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                GestureDetector(
                  onTap: () async {
                    await UtilityFunctions().imagePicker().then((value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          profilePath = value.toString();
                          setState(() {});
                        });
                      }
                    });
                  },
                  child: CircleAvatar(
                    radius: size.height * 0.06,
                    backgroundImage:
                    profilePath != "" ? FileImage(File(profilePath)) : null,
                    child: profilePath == ""
                        ? Icon(
                      Icons.person,
                      size: size.height * 0.06,
                      color: Colors.grey,
                    )
                        : null,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.028,
                ),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.09,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: size.height * 0.1,
                        width: size.width * 0.42,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "First Name*",
                              style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontSize: size.height * 0.018,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                              width: size.width * 0.9,
                              child: TextField(
                                controller: firstNameController,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: size.height * 0.02,
                                ),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 0.02)),
                                        borderSide: const BorderSide(
                                            color: Colors.black45, width: 1)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 0.02)),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 1)),
                                    hintText: "First Name",
                                    contentPadding:
                                    EdgeInsets.all(size.height * 0.01)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                        width: size.width * 0.42,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "Last Name",
                              style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontSize: size.height * 0.018,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              height: size.height * 0.051,
                              width: size.width * 0.9,
                              child: TextField(
                                controller: lastNameController,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: size.height * 0.02,
                                ),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 0.02)),
                                        borderSide: const BorderSide(
                                            color: Colors.black45, width: 1)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 0.02)),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 1)),
                                    hintText: "Last Name",
                                    contentPadding:
                                    EdgeInsets.all(size.height * 0.01)),
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
                  height: size.height * 0.022,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Mobile Number*",
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      height: size.height * 0.085,
                      width: size.width * 0.9,
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
                    AutoSizeText(
                      "Alternative Mobile Number",
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      height: size.height * 0.085,
                      width: size.width * 0.9,
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
                                borderSide:   BorderSide(
                                    color:validAltMobile
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
                                    validAltMobile
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
                    AutoSizeText(
                      "E-Mail*",
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      height: size.height * 0.053,
                      width: size.width * 0.9,
                      child: TextField(
                        controller: emailController,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: size.height * 0.02,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.02)),
                                borderSide: const BorderSide(
                                    color: Colors.black45, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.02)),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1)),
                            hintText: "E-Mail",
                            contentPadding: EdgeInsets.all(size.height * 0.01)),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                SizedBox(
                  height: size.height * 0.052,
                  width: size.width * 0.95,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.height * 0.01))),
                        backgroundColor:


                        (firstNameController.text.isNotEmpty &&
                            mobileNumberController.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                            address1Controller.text.isNotEmpty )
                            ?
                        const Color.fromRGBO(86, 59, 105, 1)
                            :
                        const Color.fromRGBO(29, 27, 32, 0.12)

                    ),
                    onPressed: () async {
                      if (firstNameController.text.isNotEmpty &&
                          mobileNumberController.text.isNotEmpty &&
                          emailController.text.isNotEmpty
                      ) {
                        Map<String, String> userData = {
                          "firstName": firstNameController.text,
                          "lastName": lastNameController.text,
                          "mobileNumber": mobileNumberController.text,
                          "alternativeMobile": alternativeMobileNumberController.text,
                          "email": emailController.text,
                        };

                        await UserAccount().addProfileDetails(userData).then((value) async {
                          if (value == "success") {
                            UtilityFunctions().successToast(
                                "Details saved successfully");
                          }});
                      } else {
                        UtilityFunctions().errorToast(
                            "Please provide all (*) fields.");
                      }
                    },
                    child: AutoSizeText(
                      "Save",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: size.height * 0.022,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.035,
                ),
              ],
            )
                :
            Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Container(
                  color: const Color.fromRGBO(247, 244, 249, 1),
                  height: size.height * 0.065,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.arrow_left,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: size.width * 0.25,
                      ),
                      AutoSizeText(
                        "Account",
                        style: GoogleFonts.openSans(
                            decoration: TextDecoration.none,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: size.height * 0.025),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                GestureDetector(
                  onTap: () async {
                    await UtilityFunctions().imagePicker().then((value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          profilePath = value.toString();
                          setState(() {});
                        });
                      }
                    });
                  },
                  child: CircleAvatar(
                    radius: size.height * 0.06,
                    backgroundImage:
                    profilePath != "" ? FileImage(File(profilePath)) : null,
                    child: profilePath == ""
                        ? Icon(
                      Icons.person,
                      size: size.height * 0.06,
                      color: Colors.grey,
                    )
                        : null,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.028,
                ),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.09,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: size.height * 0.1,
                        width: size.width * 0.42,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "First Name*",
                              style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontSize: size.height * 0.018,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                              width: size.width * 0.9,
                              child: TextField(
                                controller: firstNameController,
                                enabled: firstNameEnable,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: size.height * 0.02,
                                ),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 0.02)),

                                        borderSide: const BorderSide(
                                            color: Colors.black45, width: 1)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 0.02)),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 1)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 0.02)),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 1)),
                                    hintText: "First Name",
                                    contentPadding:
                                    EdgeInsets.all(size.height * 0.01)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                        width: size.width * 0.42,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "Last Name",
                              style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontSize: size.height * 0.018,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              height: size.height * 0.051,
                              width: size.width * 0.9,
                              child: TextField(
                                controller: lastNameController,
                                enabled: lastNameEnable,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: size.height * 0.02,
                                ),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 0.02)),
                                        borderSide: const BorderSide(
                                            color: Colors.black45, width: 1)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 0.02)),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 1)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.width * 0.02)),
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 1)),
                                    hintText: "Last Name",
                                    contentPadding:
                                    EdgeInsets.all(size.height * 0.01)),
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
                  height: size.height * 0.022,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Mobile Number*",
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      height: size.height * 0.053,
                      width: size.width * 0.9,
                      child: TextField(
                        controller: mobileNumberController,
                        enabled: mobileNumberEnable,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: size.height * 0.02,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.02)),
                                borderSide: const BorderSide(
                                    color: Colors.black45, width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.02)),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.02)),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1)),
                            hintText: "Mobile Number",
                            contentPadding: EdgeInsets.all(size.height * 0.01)),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.022,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Alternative Mobile Number*",
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      height: size.height * 0.053,
                      width: size.width * 0.9,
                      child: TextField(
                        controller: alternativeMobileNumberController,
                        enabled: altMobileEnable,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: size.height * 0.02,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.02)),
                                borderSide: const BorderSide(
                                    color: Colors.black45, width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.02)),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.02)),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1)),
                            hintText: "Alternative Mobile Number*",
                            contentPadding: EdgeInsets.all(size.height * 0.01)),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.022,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "E-Mail*",
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      height: size.height * 0.053,
                      width: size.width * 0.9,
                      child: TextField(
                        controller: emailController,
                        enabled: emailEnable,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: size.height * 0.02,
                        ),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.02)),
                                borderSide: const BorderSide(
                                    color: Colors.black45, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.02)),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.02)),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1)),
                            hintText: "E-Mail",
                            contentPadding: EdgeInsets.all(size.height * 0.01)),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                SizedBox(
                  height: size.height * 0.052,
                  width: size.width * 0.95,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(size.height * 0.01))),
                        backgroundColor:  edit
                            ?
                        const Color.fromRGBO(86, 59, 105, 1)
                            :
                        const Color.fromRGBO(29, 27, 32, 0.12)),
                    onPressed: () async {
                      if(edit){
                        if (firstNameController.text.isNotEmpty &&
                            mobileNumberController.text.isNotEmpty &&
                            emailController.text.isNotEmpty
                        ) {
                          Map<String, String> userData = {
                            "firstName": firstNameController.text,
                            "lastName": lastNameController.text,
                            "mobileNumber": mobileNumberController.text,
                            "alternativeMobile": alternativeMobileNumberController.text,
                            "email": emailController.text,
                            "profile_id":profileId
                          };
                          print("Called....$profileId");
                          await UserAccount().updateProfileDetails(userData).then((value) async {
                            if (value == "success") {
                              UtilityFunctions().successToast(
                                  "Details edited successfully");
                              edit=false;
                              firstNameEnable=false;
                              lastNameEnable=false;
                              mobileNumberEnable=false;
                              altMobileEnable=false;
                              emailEnable=false;
                              setState(() {

                              });
                            }});
                        } else {
                          UtilityFunctions().errorToast(
                              "Please provide all (*) fields.");
                        }
                      }
                      else{
                        edit=true;
                        firstNameEnable=true;
                        lastNameEnable=true;
                        mobileNumberEnable=true;
                        altMobileEnable=true;
                        emailEnable=true;
                        setState(() {

                        });
                      }
                    },
                    child: AutoSizeText(
                      edit?"Save Changes":"Edit",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.035,
                ),
              ],
            )
        ),
      ),
    );
  }
}
