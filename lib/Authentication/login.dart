import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/routes/routesname.dart';
import 'package:mykanjeedriver/utilityfunction.dart';
import '../api/authorisation.dart';
import '../constrant.dart';
import 'constraints.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  bool hide=true;
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
                height: size.height*0.07,
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
                        controller: email,
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
                    height: size.height*0.02,
                  ),
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
                    height: size.height*0.01,
                  ),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(left:size.width*0.035,right:size.width*0.035),
                      child: TextField(
                        controller: password,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: size.height*0.02,
                        ),
                        obscureText: hide,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline,size: size.height*0.022,),
                            suffixIcon:
                            !hide
                                ?
                            IconButton(
                              onPressed: () {
                               setState(() {
                                 hide=!hide;
                               });
                              },
                                icon: Icon(Icons.remove_red_eye,size: size.height*0.022,))
                            :
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    hide=!hide;
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

                            hintText: "Password",
                            contentPadding: EdgeInsets.all(size.height*0.01)
                        ),
                        textAlign: TextAlign.start,

                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.017,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: size.width*0.035),
                    child: InkWell(
                      onTap: (){
                       Navigator.pushNamed(context, RoutesName.loginWithOtp,);
                      },
                      child: SizedBox(
                        child: Text("Login in with OTP",
                          style: TextStyle(
                              fontSize: size.height*0.017,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:size.width*0.035,right:size.width*0.035),
                    child: InkWell(
                      onTap: () async {

                            if(!buttonClicked){

                              if(email.text.trim().toString().isNotEmpty && password.text.trim().isNotEmpty){
                                buttonClicked=true;
                                setState(() {

                                });
                                await Authentication().loginUser(email.text,password.text).then((value) async {
                                  if(value=="success")
                                  {

                                    Navigator.pushNamedAndRemoveUntil(context, RoutesName.navigationBar, (route) => false);


                                  }
                                  else if(value=="Server Error.")
                                  {
                                    buttonClicked=false;
                                    setState(() {

                                    });
                                    UtilityFunctions().errorToast( "Some server error occurred");
                                  }

                                  else{
                                    buttonClicked=false;
                                    setState(() {

                                    });
                                    UtilityFunctions().errorToast( value.toString());
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
                            "Log In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.height*0.025,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, RoutesName.forgotPassword);

                        },
                        child: AutoSizeText("Forgot Your Password ?",
                          style:TextStyle(
                            fontSize: size.height*0.017,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                          ) ,),
                      )
                    ],
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
                    height: size.height*0.035,
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
