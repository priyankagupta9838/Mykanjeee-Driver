import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../api/authorisation.dart';
import '../routes/routesname.dart';
import '../utilityfunction.dart';
import 'constraints.dart';


class ProvideResetPassword extends StatefulWidget {
  ProvideResetPassword({Key? key, required this.data,})
      : super(key: key);
 Map<dynamic,dynamic>data;

  @override
  State<ProvideResetPassword> createState() => _ProvideResetPasswordState();
}

class _ProvideResetPasswordState extends State<ProvideResetPassword> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool buttonClicked=false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: size.height * 1,
        width: size.width * 1,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
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
                height: size.height * 0.03,
              ),
              SizedBox(
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                      fontSize: size.height * 0.028,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),

              SizedBox(
                height: size.height * 0.07,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.035),
                    child: SizedBox(
                      child: Text(
                        "Password",
                        style: TextStyle(
                            fontSize: size.height * 0.017,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.006,
                  ),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.035, right: size.width * 0.035),
                      child: TextField(
                        controller: password,
                        enableSuggestions: true,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: size.height * 0.02,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: size.height * 0.022,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 0.02)),
                              borderSide: const BorderSide(
                                  color: Colors.black45, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.02)),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1)),
                            hintText: "Password",
                            contentPadding: EdgeInsets.all(size.height * 0.01)),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.035),
                    child: SizedBox(
                      child: Text(
                        "Confirm Password",
                        style: TextStyle(
                            fontSize: size.height * 0.017,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.006,
                  ),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.035, right: size.width * 0.035),
                      child: TextField(
                        controller: confirmPassword,
                        enableSuggestions: true,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: size.height * 0.02,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: size.height * 0.022,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 0.02)),
                              borderSide: const BorderSide(
                                  color: Colors.black45, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.02)),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1)),
                            hintText: "Confirm Password",
                            contentPadding: EdgeInsets.all(size.height * 0.01)),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    width: size.width*1,
                    child: Padding(
                      padding:  EdgeInsets.only(right: size.width*0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false);

                            },
                            child: AutoSizeText(
                              "Try to Login ?",
                              style: TextStyle(
                                  fontSize: size.height * 0.017,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.3,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.035, right: size.width * 0.035),
                    child: InkWell(
                      onTap: () async {
                         if(password.text.toString().isNotEmpty && confirmPassword.text.toString().isNotEmpty){
                           await Authentication().forgotPasswordVerification(widget.data["username"],widget.data["otp"],password.text,confirmPassword.text).then((value) {
                             if(value=="success"){
                               Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false);
                             }
                             else{
                               UtilityFunctions().errorToast(value.toString());
                             }
                           });

                         }
                         else{
                           UtilityFunctions().errorToast("Please Provide hte password");
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
                              "Reset Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.w600),
                            ),
                          )




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
