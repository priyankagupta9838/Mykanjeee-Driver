import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/routes/routesname.dart';
import 'package:mykanjeedriver/utilityfunction.dart';
import '../api/authorisation.dart';
import '../constrant.dart';
import 'constraints.dart';


class LogInWithOtp extends StatefulWidget {
  const LogInWithOtp({Key? key}) : super(key: key);

  @override
  State<LogInWithOtp> createState() => _LogInWithOtpState();
}

class _LogInWithOtpState extends State<LogInWithOtp> {
  TextEditingController phoneNumber=TextEditingController();
  bool buttonClicked=false;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: size.height*1,
        width: size.width*1,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: size.height*0.08,
              ),
              CircleAvatar(
                backgroundColor: Colors.purple,
                radius: size.height*0.04,
                backgroundImage: const AssetImage("assets/logo/download.png"),
              ),
              SizedBox(
                height: size.height*0.03,
              ),
              SizedBox(
                child: Text("Log In",
                  style: TextStyle(
                      fontSize: size.height*0.028,
                      color: Colors.black,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
              SizedBox(
                height: size.height*0.052,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: size.width*0.035),
                    child: SizedBox(
                      child: Text("Phone/Email",
                        style: TextStyle(
                            fontSize: size.height*0.017,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.006,
                  ),
                  SizedBox(
                    child: Padding(
                      padding:  EdgeInsets.only(left:size.width*0.035,right:size.width*0.035),
                      child: TextField(
                        controller: phoneNumber,
                        inputFormatters: [ FilteringTextInputFormatter. allow(emailPassword),],
                        enableSuggestions: true,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: size.height*0.02,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined,size: size.height*0.022,),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                              borderSide: const BorderSide(
                                  color: Colors.black45,
                                  width: 1
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(size.width*0.02)),
                                borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1
                                )
                            ),
                            hintText: "Phone/Email",
                            contentPadding: EdgeInsets.all(size.height*0.01)
                        ),
                        textAlign: TextAlign.start,

                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height*0.055,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:size.width*0.035,right:size.width*0.035),
                    child: InkWell(
                      onTap: () async {

                    if(!buttonClicked){

                      if(phoneNumber.text.trim().toString().isNotEmpty){
                        buttonClicked=true;
                        setState(() {

                        });
                        await Authentication().loginWithOtp(phoneNumber.text).then((value) {
                          if(value=="success"){
                            Navigator.pushReplacementNamed(context, RoutesName.loginWithOtpVerification,arguments:phoneNumber.text.toString() );

                          }
                          else{
                            buttonClicked=false;
                            setState(() {

                            });
                            UtilityFunctions().errorToast(value.toString());
                          }
                        });



                      }
                      else{
                        UtilityFunctions().errorToast("Please provide the phone/Email");
                      }
                    }
                    else{
                      UtilityFunctions().errorToast("Please wait...");
                    }
                          },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(size.width*0.032)),
                            color: buttonColor
                        ),
                        height: size.height*0.051,
                        width: size.width*0.93,
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
                            "Send OTP",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height*0.022,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.033,
                  ),
                  SizedBox(
                    height: size.height*0.004,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: size.height*0.017
                        ),
                      ),
                      TextButton(
                        onPressed: () {

                        Navigator.pushReplacementNamed(context, RoutesName.signUp1);
                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.openSans(
                            color: Colors.blue,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}