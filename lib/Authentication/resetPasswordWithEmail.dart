
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../constrant.dart';
import '../routes/routesname.dart';
import 'SignUP-1.dart';
import 'constraints.dart';

class ResetPasswordWithEmail extends StatefulWidget {
  const ResetPasswordWithEmail({Key? key}) : super(key: key);

  @override
  State<ResetPasswordWithEmail> createState() => _ResetPasswordWithEmailState();
}

class _ResetPasswordWithEmailState extends State<ResetPasswordWithEmail> {
  TextEditingController phoneNumber=TextEditingController();
  bool buttonClicked=false;
  final pattern = r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$|^[0-9]{10}$';

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
                child: Text("Reset Password",
                  style: TextStyle(
                      fontSize: size.height*0.028,
                      color: Colors.black,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
              SizedBox(
                height: size.height*0.045,
              ),
              SizedBox(
                width: size.width*0.7,
                child:Center(
                  child: AutoSizeText("Enter your registered email or phone number to reset password. ",style: GoogleFonts.openSans(
                    fontSize: size.height*0.014,
                  ),),
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
                      child: Text("username",
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

                            hintStyle: GoogleFonts.openSans(
                                fontWeight: FontWeight.w500,
                                fontSize: size.height*0.018
                            ),
                            contentPadding: EdgeInsets.all(size.height*0.01)
                        ),
                        textAlign: TextAlign.start,

                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.025,
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
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: const SignUpPage1(),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 350),
                              childCurrent: const ResetPasswordWithEmail(),
                            ),
                          );
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
                  ),
                  SizedBox(
                    height: size.height*0.36,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:size.width*0.035,right:size.width*0.035),
                    child: InkWell(
                      onTap: () async {

                        Navigator.pushNamed(context, RoutesName.resetPasswordWithEmailOtpVerification);

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
                            "Reset Password",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height*0.02,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
