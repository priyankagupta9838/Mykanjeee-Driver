import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/utilityfunction.dart';
import '../api/authorisation.dart';
import '../routes/routesname.dart';
import 'constraints.dart';

class SignUpPage2 extends StatefulWidget {

    SignUpPage2({Key? key, required this.data,});
  Map<dynamic,dynamic>data;

  @override
  State<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  TextEditingController password=TextEditingController();
  TextEditingController confirmPassword=TextEditingController();
  bool termsAndConditions=false;
  bool buttonClicked=false;
  bool hide1=true;
  bool hide2=true;
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
                child: Text("Sign Up",
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
                      child: Text("Password",
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
                        controller: password,
                        obscureText: hide2,
                        enableSuggestions: true,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: size.height*0.02,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline,size: size.height*0.022,),
                            suffixIcon:
                            !hide2
                                ?
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    hide2=!hide2;
                                  });
                                },
                                icon: Icon(Icons.remove_red_eye,size: size.height*0.022,))
                                :
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    hide2=!hide2;
                                  });
                                },
                                icon: Icon(Icons.visibility_off,size: size.height*0.022,)),
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
                            hintText: "Password",
                            contentPadding: EdgeInsets.all(size.height*0.01)
                        ),
                        textAlign: TextAlign.start,

                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.025,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: size.width*0.035),
                    child: SizedBox(
                      child: Text("Confirm Password",
                        style: TextStyle(
                            fontSize: size.height*0.017,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(left:size.width*0.035,right:size.width*0.035),
                      child: TextField(
                        controller: confirmPassword,
                        obscureText: hide1,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: size.height*0.02,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline,size: size.height*0.022,),
                            suffixIcon:
                            !hide1
                                ?
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    hide1=!hide1;
                                  });
                                },
                                icon: Icon(Icons.remove_red_eye,size: size.height*0.022,))
                                :
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    hide1=!hide1;
                                  });
                                },
                                icon: Icon(Icons.visibility_off,size: size.height*0.022,)),
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

                            hintText: "Confirm Password",
                            contentPadding: EdgeInsets.all(size.height*0.01)
                        ),
                        textAlign: TextAlign.start,

                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.025,
                  ),
                  SizedBox(
                    height: size.height*0.062,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width*0.038,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              termsAndConditions=!termsAndConditions;
                            });
                          },
                          child: Container(
                            height: size.height*0.024,
                            width: size.width*0.045,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(size.height*0.007)),
                             border: Border.all(
                               color: Colors.black87,
                               style: BorderStyle.solid,
                               width: 1
                             )
                            ),
                            child:
                            termsAndConditions
                            ?
                            Icon(Icons.check,size: size.height*0.020,color: Colors.green,)
                                :
                            const SizedBox()
                            ,
                          ),
                        ),
                        SizedBox(
                          width: size.width*0.029,
                        ),
                        SizedBox(
                          //height: size.height*0.062,
                          width: size.width*0.85,
                          child: Row(
                            children: [
                              AutoSizeText("I agree to the ",
                              style: GoogleFonts.openSans(
                                fontSize: size.height*0.018,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87
                              ),
                              ),
                              GestureDetector(
                                onTap: () {

                                },
                                child: AutoSizeText(" T&C",
                                  style: GoogleFonts.openSans(
                                      fontSize: size.height*0.018,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue
                                  ),
                                ),
                              ),
                              AutoSizeText(" and ",
                                style: GoogleFonts.openSans(
                                    fontSize: size.height*0.018,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87
                                ),
                              ),
                              GestureDetector(
                                onTap: () {

                                },
                                child: AutoSizeText(" privacy & policy",
                                  style: GoogleFonts.openSans(
                                      fontSize: size.height*0.018,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.035,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:size.width*0.035,right:size.width*0.035),
                    child: GestureDetector(
                      onTap: () async {
                       if(!buttonClicked){
                         if(password.text.trim().toString().isNotEmpty && confirmPassword.text.trim().toString().isNotEmpty && termsAndConditions)
                         {
                           buttonClicked=true;
                           setState(() {

                           });
                           await Authentication().signUpNewUser(widget.data["name"],widget.data["email"],password.text).then((value) {
                             if(value=="success"){
                               Navigator.pushNamed(context, RoutesName.signUpOtp,arguments: widget.data["email"]);
                             }else{
                               buttonClicked=false;
                               setState(() {

                               });
                               UtilityFunctions().errorToast(value.toString());
                             }
                           });


                         }
                         else{
                           UtilityFunctions().errorToast("All fields are required");
                         }
                       }else{
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
                            "Continue",
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
                    height: size.height*0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: size.width*0.4,
                        child: Divider(
                          color: Colors.black,
                          height: MediaQuery.of(context).size.height * 0.01,
                          thickness: MediaQuery.of(context).size.height * 0.0028,
                          endIndent: 3,
                          indent: 3,
                        ),
                      ),
                      AutoSizeText("or",style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: size.height*0.015,
                        fontWeight: FontWeight.w800,
                      ),),
                      SizedBox(

                        width: size.width*0.4,
                        child: Divider(
                          color: Colors.black,
                          height: MediaQuery.of(context).size.height * 0.01,
                          thickness: MediaQuery.of(context).size.height * 0.0028,
                          endIndent: 3,
                          indent: 3,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: size.height*0.02,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: size.height*0.017
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, RoutesName.login);
                        },
                        child: Text(
                          "Log In",
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
