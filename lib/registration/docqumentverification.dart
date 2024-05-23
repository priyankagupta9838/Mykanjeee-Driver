import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mykanjeedriver/utils/theamscolors.dart';
import 'package:page_transition/page_transition.dart';
import '../api/authorisation.dart';
import '../api/validation.dart';
import '../constrant.dart';
import '../routes/routesname.dart';
import '../utilityfunction.dart';


class AccountDetails2 extends StatefulWidget {
  const AccountDetails2({
    super.key,
  });

  @override
  State<AccountDetails2> createState() => _AccountDetails2State();
}

class _AccountDetails2State extends State<AccountDetails2> {
  TextEditingController panController = TextEditingController();
  TextEditingController adharController = TextEditingController();
  TextEditingController drivingLicenceController = TextEditingController();


  String panCardImagePath = "";
  String adharCardImagePath = "";
  String drivingLicenceImagePath = "";

  bool buttonClicked = false;
  bool panValidation = true;
  bool adharValidation = true;
  bool gstinValidation = true;
  final focus = FocusNode();
  @override
  void initState() {
    // TODO: implement initState

    if(userRegisterData.isNotEmpty){
      panController.text=userRegisterData['panNumber']??"";
      panCardImagePath=userRegisterData['panCardImage']??"";
      adharController.text= userRegisterData['adharNumber']??"";
      adharCardImagePath=userRegisterData['adharCardImage']??"";
      drivingLicenceController.text= userRegisterData['drivingLicence']??"";
      drivingLicenceImagePath= userRegisterData['drivingLicenceImage']??"";

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height * 1,
        width: size.width * 1,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              Container(
                color: const Color.fromRGBO(247, 244, 249, 1),
                height: size.height * 0.12,
                width: size.width,
                child: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            CupertinoIcons.arrow_left,
                            color: Colors.black,
                          )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      AutoSizeText(
                        "Document Verification",
                        style: GoogleFonts.openSans(
                            decoration: TextDecoration.none,
                            color: const Color.fromRGBO(28, 28, 30, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: size.height * 0.025),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: size.height * 0.018,
                  right: size.height * 0.018,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    SizedBox(
                      height: size.height * 0.086,
                      child: TextField(
                        controller: panController,
                        obscureText: false,
                        onChanged: (value) {
                          String uppercaseValuePan = value.toUpperCase();
                          panController.text = uppercaseValuePan;
                          String panRegex = r"^[A-Z]{5}[0-9]{4}[A-Z]$";
                          final regExp = RegExp(panRegex);
                          if (!regExp.hasMatch(uppercaseValuePan.toString())) {
                            panValidation = false;
                            setState(() {});
                          } else {
                            ValidationApi()
                                .validatePanNumber(value.toString(), userRegisterData["firstName"].toString(), userRegisterData["lastName"].toString(), userRegisterData["dob"].toString())
                                .then((value) {
                              if (value == true) {
                                panValidation = true;
                                setState(() {});
                              } else {
                                UtilityFunctions().errorToast("Please check your Name and DOB it should be as per pan card*");
                                panValidation = false;
                                setState(() {});
                              }
                            });
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: size.height*0.0001,left:size.width*0.035),
                          error: AutoSizeText(
                            !panValidation ? "Invalid number" : "",
                            style: GoogleFonts.openSans(
                                fontSize: size.height * 0.01,
                                color: Colors.red,
                                fontWeight: FontWeight.w400),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: panValidation
                                      ? Colors.black
                                      : Colors.red)),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38)),
                          disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: panValidation
                                      ? Colors.black54
                                      : Colors.red)),
                          labelText: 'PAN Number',
                          labelStyle: GoogleFonts.openSans(
                              color:
                              !panValidation ? Colors.red : Colors.black87,
                              fontSize: size.height * 0.018,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
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
                          panCardImagePath.isNotEmpty
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
                                        double fileSizeInKB =
                                            fileSizeInBytes / 1024;
                                        double fileSizeInMB =
                                            fileSizeInKB / 1024;
                                        if (fileSizeInMB <= 7) {
                                          panCardImagePath = value.path;
                                          setState(() {});
                                          print(
                                              "Pan size pat : $panCardImagePath");
                                        } else {
                                          UtilityFunctions().errorToast("Image has large size.");

                                        }

                                          print("File size is : $fileSizeInMB");

                                      } else {
                                        UtilityFunctions().errorToast( "Please select image.");
                                      }
                                    });
                                  },
                                  child: const AutoSizeText("Click To Upload")),
                              const AutoSizeText("or drag and drop ")
                            ],
                          ),
                          const AutoSizeText("PNG or JPG (max 7 MB)")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.028,
                    ),
                    SizedBox(
                      height: size.height * 0.086,
                      child: TextField(
                        controller: adharController,
                        obscureText: false,
                        onChanged: (value) {
                          String panRegex = r'^[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}$';
                          final regExp = RegExp(panRegex);
                          if (!regExp.hasMatch(value.toString())) {
                            adharValidation = false;
                            setState(() {});
                          } else {
                            ValidationApi()
                                .validateAadharNumber(value.toString())
                                .then((value) {
                              if (value == true) {
                                adharValidation = true;
                                setState(() {});
                              } else {
                                adharValidation = false;
                                setState(() {});
                              }
                            });
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: size.height*0.0001,left:size.width*0.035),
                          error: AutoSizeText(
                            !adharValidation ? "Invalid number" : "",
                            style: GoogleFonts.openSans(
                                fontSize: size.height * 0.01,
                                color: Colors.red,
                                fontWeight: FontWeight.w400),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: adharValidation
                                      ? Colors.black
                                      : Colors.red)),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38)),
                          disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: adharValidation
                                      ? Colors.black38
                                      : Colors.red)),
                          labelText: 'AadhaarNumber',
                          labelStyle: GoogleFonts.openSans(
                              color: !adharValidation
                                  ? Colors.red
                                  : Colors.black87,
                              fontSize: size.height * 0.018,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
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
                          adharCardImagePath.isNotEmpty
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
                                        double fileSizeInKB =
                                            fileSizeInBytes / 1024;
                                        double fileSizeInMB =
                                            fileSizeInKB / 1024;
                                        if (fileSizeInMB <= 7) {
                                          adharCardImagePath = value.path;

                                            print(
                                                "Path is :$adharCardImagePath");

                                          setState(() {});
                                        } else {

                                          UtilityFunctions().errorToast(
                                              "Image has large size.");
                                        }

                                          print(
                                              "File size is : $adharCardImagePath");

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
                          const Text("PNG or JPG (max 7 MB)")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.028,
                    ),
                    SizedBox(
                      height: size.height * 0.085,
                      child: TextField(
                        controller: drivingLicenceController,
                        obscureText: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: size.height*0.0001,left:size.width*0.035),
                          error: AutoSizeText(
                            !gstinValidation ? "Invalid number" : "",
                            style: GoogleFonts.openSans(
                                fontSize: size.height * 0.01,
                                color: Colors.red,
                                fontWeight: FontWeight.w400),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: gstinValidation
                                      ? Colors.black
                                      : Colors.red)),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38)),
                          disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: gstinValidation
                                      ? Colors.black38
                                      : Colors.red)),
                          labelText: 'Driving Licence Number',
                          labelStyle: GoogleFonts.openSans(
                              color: !gstinValidation
                                  ? Colors.red
                                  : Colors.black87,
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
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
                          drivingLicenceImagePath.isNotEmpty
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
                                        double fileSizeInKB =
                                            fileSizeInBytes / 1024;
                                        double fileSizeInMB =
                                            fileSizeInKB / 1024;
                                        if (fileSizeInMB <= 7) {
                                          drivingLicenceImagePath = value.path;
                                          setState(() {});

                                        } else {
                                          UtilityFunctions().errorToast(
                                              "Image has large size.");
                                        }
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
                          const Text("PNG or JPG (max 7 MB)")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.028,
                    ),

                    SizedBox(
                      height: size.height * 0.045,
                    ),
                    SizedBox(
                      height: size.height * 0.052,
                      width: size.width * 0.95,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.height * 0.01))),
                              backgroundColor:ThemColors.buttonColor,
                          ),
                          onPressed: () {
                            // Navigator.pushNamed(context, RoutesName.setUpAccountDetail);
                            if(!buttonClicked){
                              if (panController.text.trim().isNotEmpty &&
                                  adharController.text.trim().isNotEmpty &&
                                  panCardImagePath.isNotEmpty &&
                                  adharCardImagePath.isNotEmpty&&
                                  panValidation &&
                                  adharValidation &&
                                  drivingLicenceController.text.trim().isNotEmpty &&
                                  drivingLicenceImagePath.isNotEmpty
                              ) {
                                buttonClicked = true;
                                setState(() {});
                                userRegisterData['panNumber'] =
                                    panController.text.toString();
                                userRegisterData['panCardImage'] =
                                    panCardImagePath.toString();
                                userRegisterData['adharNumber'] =
                                    adharController.text.toString();
                                userRegisterData['adharCardImage'] =
                                    adharCardImagePath.toString();
                                userRegisterData['drivingLicence'] =
                                    drivingLicenceController.text.toString();
                                userRegisterData['drivingLicenceImage'] =
                                    drivingLicenceImagePath.toString();
                                print("User data is  ...$userRegisterData");

                                //Navigator.pushNamedAndRemoveUntil(context, RoutesName.navigationBar, (route) => false);

                                Authentication()
                                    .postDriverDetails()
                                    .then((value) {
                                  if (value == "success") {
                                    buttonClicked = false;
                                    setState(() {

                                    });
                                   Navigator.pushNamed(context, RoutesName.setUpAccountDetail);
                                  }
                                  else {
                                    buttonClicked = false;
                                    UtilityFunctions()
                                        .errorToast(value);

                                    setState(() {});

                                  }
                                });
                              }
                              else {
                                buttonClicked = false;
                                UtilityFunctions().errorToast(
                                    "All details must be required.");

                                setState(() {});
                              }
                            }
                            else{
                              UtilityFunctions().errorToast("Please Wait...");
                            }


                          },
                          child: buttonClicked
                              ? Center(
                            child: SizedBox(
                              height: size.height * 0.03,
                              width: size.height * 0.03,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                              : AutoSizeText("Continue",
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.w500))),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
