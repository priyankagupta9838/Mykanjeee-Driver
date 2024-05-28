import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../api/useraccount.dart';
import '../utilityfunction.dart';

class AccountsSetting extends StatefulWidget {
  const AccountsSetting({Key? key}) : super(key: key);

  @override
  State<AccountsSetting> createState() => _AccountsSettingState();
}

class _AccountsSettingState extends State<AccountsSetting> {
  TextEditingController password=TextEditingController();
  TextEditingController confirmPassword=TextEditingController();
  bool buttonClick=false;
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
              Container(
                color: const Color.fromRGBO(247, 244, 249, 1),
                height: size.height*0.07,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon:  Icon(CupertinoIcons.arrow_left,size: size.width*0.07,color: Colors.black87,
                        ) ),
                    SizedBox(width: size.width*0.1,),
                    AutoSizeText("Reset Your Password",style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: size.height*0.024

                    ),),


                  ],
                ),

              ),
              SizedBox(
                height: size.height*0.052,
              ),
              Padding(
                padding: EdgeInsets.only(left:size.width*0.035,right:size.width*0.035),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text("Password",
                        style: TextStyle(
                            fontSize: size.height*0.017,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.006,
                    ),
                    SizedBox(
                      child: TextField(
                        controller: password,
                        enableSuggestions: true,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: size.height*0.02,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline,size: size.height*0.022,),
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
                            hintText: "New password",
                            contentPadding: EdgeInsets.all(size.height*0.01)
                        ),
                        textAlign: TextAlign.start,

                      ),
                    ),
                    SizedBox(
                      height: size.height*0.025,
                    ),
                    SizedBox(
                      child: Text("Confirm Password",
                        style: TextStyle(
                            fontSize: size.height*0.017,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    SizedBox(
                      child: TextField(
                        controller: confirmPassword,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: size.height*0.02,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline,size: size.height*0.022,),
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

                            hintText: "Confirm password ",
                            contentPadding: EdgeInsets.all(size.height*0.01)
                        ),
                        textAlign: TextAlign.start,

                      ),
                    ),
                    SizedBox(
                      height: size.height*0.05,
                    ),
                    SizedBox(
                      height: size.height*0.052,
                      width: size.width*1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(

                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(size.height*0.01))),
                            backgroundColor: const Color.fromRGBO(174, 144, 194, 1)),
                        onPressed: () async {
                          if(password.text.trim().isNotEmpty && confirmPassword.text.trim().isNotEmpty){
                            if(password.text.toString().trim().length<6 && confirmPassword.text.toString().trim().length<6)
                            {
                              UtilityFunctions().errorToast("Password must be at least 6 character.");
                            }
                            else{
                              if (password.text != confirmPassword.text) {
                                UtilityFunctions().errorToast("Both password must be same");
                              }
                              else{
                                buttonClick=true;
                                setState(() {

                                });
                                await UserAccount().loginAndSecurity(password.text.trim(),confirmPassword.text.trim()).then((value) {
                                  if(value=="success")
                                  {
                                    buttonClick=false;
                                    setState(() {

                                    });
                                    UtilityFunctions().successToast("Password changed successfully");


                                    Navigator.pop(context);
                                  }
                                  else if(value=="Server Error.")
                                  {
                                    UtilityFunctions().errorToast("Server Error.");
                                    buttonClick=false;
                                    setState(() {

                                    });
                                  }

                                  else{
                                    UtilityFunctions().errorToast(value);
                                    buttonClick=false;
                                    setState(() {

                                    });
                                  }

                                });
                              }
                            }
                          }
                          else{
                            UtilityFunctions().errorToast("Please write the password");

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

                            AutoSizeText("Save",
                              style: GoogleFonts.openSans(
                                  fontSize: size.height * 0.024,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white
                              ),),

                          ],
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     // bool userResponse=false;
                    //     // AwesomeDialog(
                    //     //   context: context,
                    //     //   dialogType: DialogType.noHeader,
                    //     //   animType: AnimType.scale,
                    //     //   body:  Padding(
                    //     //     padding: EdgeInsets.symmetric(horizontal: size.width*0.1,vertical: 0),
                    //     //     child: const Center(
                    //     //       child: AutoSizeText(
                    //     //         'Do you want to sent request to delete you account?',
                    //     //         style: TextStyle(fontStyle: FontStyle.italic),
                    //     //       ),
                    //     //     ),
                    //     //   ),
                    //     //   btnCancelOnPress: () {
                    //     //
                    //     //   },
                    //     //   btnCancelText: "No",
                    //     //   btnCancelColor: Colors.grey.shade500,
                    //     //   btnCancelIcon: Icons.close, // You can add an icon if you like
                    //     //   btnOkOnPress: () {
                    //     //     userResponse=true;
                    //     //     print("..true");
                    //     //     // Action when "Yes" button is pressed
                    //     //   },
                    //     //   btnOkText: "Yes",
                    //     //   btnOkColor: Colors.purple.shade200,
                    //     //   btnOkIcon: Icons.check, // You can add an icon if you like
                    //     //   buttonsTextStyle: TextStyle(
                    //     //     fontSize: size.height * 0.02,
                    //     //     color: Colors.white,
                    //     //     fontWeight: FontWeight.w400,
                    //     //   ),
                    //     // ).show().whenComplete(() {
                    //     //
                    //     //   if(userResponse){
                    //     //     Authentication().sentRequestForDeleteAccount().then((value) {
                    //     //       if(value=="success"){
                    //     //         UtilityFunctions().successToast("Request sent successfully");
                    //     //       }
                    //     //       else{
                    //     //         UtilityFunctions().errorToast(value.toString());
                    //     //
                    //     //       }
                    //     //     });
                    //     //   }
                    //
                    //     // });
                    //   },
                    //   child: Padding(
                    //     padding:  EdgeInsets.only(left: size.width*0.3,top: size.height*0.06),
                    //     child: SizedBox(
                    //       child:  AutoSizeText("Delete Account",
                    //         style: GoogleFonts.openSans(
                    //             fontWeight: FontWeight.w700,
                    //             fontSize: size.height*0.02,
                    //             color: Colors.black54
                    //         ),),
                    //     ),
                    //   ),
                    // )

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
