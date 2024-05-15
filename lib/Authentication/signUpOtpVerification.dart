import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/Authentication/timerCountdown.dart';
import 'package:mykanjeedriver/routes/routesname.dart';
import 'package:mykanjeedriver/utilityfunction.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../Statemanagement/PageBlok.dart';
import '../Statemanagement/PageEvents.dart';
import '../Statemanagement/PageState.dart';
import '../api/authorisation.dart';
import '../constrant.dart';
import 'constraints.dart';

class SignUpOtpVerification extends StatefulWidget {
  SignUpOtpVerification(
      {Key? key,
      required this.data,
     })
      : super(key: key);

 Map<dynamic,dynamic>data;


  @override
  State<SignUpOtpVerification> createState() => _SignUpOtpVerificationState();
}

class _SignUpOtpVerificationState extends State<SignUpOtpVerification> {

  TextEditingController userOtp = TextEditingController();
  bool buttonClicked=false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<AddTimerBlo, AddTimerState>(
        builder: (context, state) {
          return SizedBox(
            height: size.height * 1,
            width: size.width * 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: size.height * 0.04,
                    backgroundImage: const AssetImage("assets/logo/download.png"),
                  ),
                  SizedBox(
                    height: size.height * 0.055,
                  ),
                  SizedBox(
                    child: Text(
                      "OTP Verification",
                      style: TextStyle(
                          fontSize: size.height * 0.024,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: size.width * 1,
                      child: Center(
                        child: AutoSizeText(
                          "Otp created and sent to you on ",
                          style: GoogleFonts.openSans(
                              fontSize: size.height * 0.018,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: size.width * 1,
                      child: Center(
                        child: AutoSizeText(
                          widget.data["email"],
                          style: GoogleFonts.openSans(
                              fontSize: size.height * 0.018,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: size.height*0.03,
                      width: size.width*1,
                      child:  const Center(
                          child:
                          CountDownTimer()
                      ),
                    ),
                  ),

                  SizedBox(
                    width: size.width * 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.035,
                        ),
                        SizedBox(
                          height: size.height * 0.07,
                          width: size.width * 0.75,
                          child: PinCodeTextField(
                            controller: userOtp,
                            appContext: context,
                            length: 4,
                            obscureText: false,
                            autoFocus: true,
                            enablePinAutofill: true,
                            animationType: AnimationType.fade,
                            cursorColor: Colors.black,
                            textStyle: GoogleFonts.openSans(color: Colors.black38),
                            pinTheme: PinTheme(
                              activeColor: Colors.black87,
                              selectedColor: Colors.black87,
                              disabledColor: Colors.black87,
                              inactiveColor: Colors.black87,
                              selectedFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 0.016)),
                              fieldHeight: size.height * 0.063,
                              fieldWidth: size.height * 0.063,
                              activeFillColor: Colors.white,
                            ),
                            animationDuration: const Duration(milliseconds: 300),
                            backgroundColor: Colors.white,
                            enableActiveFill: true,
                            beforeTextPaste: (text) {
                              return true;
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't receive ?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: size.height * 0.014),
                            ),
                            BlocBuilder<AddTimerBlo,AddTimerState>(builder: (context, state) {
                              return    TextButton(
                                onPressed: () async {

                                  await Authentication().signUpNewUser(widget.data["name"],widget.data["email"],widget.data["password"]).then((value) {
                                    if(value=="success"){
                                      totalSeconds=80;
                                      BlocProvider.of<AddTimerBlo>(context).add(UpdateTimerEvent());
                                      UtilityFunctions().successToast("Otp Send Successfully please check.");

                                    }else{

                                      UtilityFunctions().errorToast(value.toString());
                                    }
                                  });


                                },
                                child: Text(
                                  "Send Again",
                                  style: GoogleFonts.openSans(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w800,
                                      fontSize: size.height * 0.014),
                                ),
                              );
                            },),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.038,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: size.height * 0.33,
                            width: size.width * 0.75,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/logo/otp-image.png"),
                                    fit: BoxFit.contain)),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.035, right: size.width * 0.035),
                          child: InkWell(
                            onTap: () async {
                              if(!buttonClicked){
                                if(userOtp.text.isNotEmpty && userOtp.text.toString().length==4){
                                  buttonClicked=true;
                                  setState(() {

                                  });
                                  await Authentication().verifyNewUser(userOtp.text).then((value) {

                                    if(value=="success"){
                                      Navigator.pushNamedAndRemoveUntil(context, RoutesName.setupProfile, (route) => false);

                                    }else{
                                      buttonClicked=false;
                                      setState(() {

                                      });
                                      UtilityFunctions().errorToast(value.toString());
                                    }

                                  });


                                }else{
                                  UtilityFunctions().errorToast("All fields are required");
                                }
                              }
                              else{
                                UtilityFunctions().errorToast("Please wait...");
                              }

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 0.032)),
                                  color: buttonColor),
                              height: size.height * 0.051,
                              width: size.width * 0.93,
                              child:
                              buttonClicked
                                  ?
                              Center(
                                child: SizedBox(
                                  height: size.height*0.03,
                                  width: size.height*0.03,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                                  :

                              Center(
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
