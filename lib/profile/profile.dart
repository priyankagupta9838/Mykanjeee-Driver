import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [

            SizedBox(

              child:
              Padding(
                padding:  EdgeInsets.all(size.height*0.015),
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: size.width*0.7,top: size.height*0.02),
                      child: IconButton(onPressed: () {
                               Navigator.pop(context);
                      }, icon: Icon(CupertinoIcons.multiply,size: size.height*0.04,)),
                    ),
                    SizedBox(
                      height: size.height*0.055,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      radius:size.height*0.072 ,
                      child: CircleAvatar(
                        radius:size.height*0.07 ,
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    Column(
                      children: [
                        AutoSizeText("email_id",style: GoogleFonts.openSans(
                            fontWeight:FontWeight.w600,
                            fontSize: size.height*0.02,
                            color: Colors.greenAccent
                        ),),
                        SizedBox(
                          height: size.height*0.01,
                        ),
                        AutoSizeText("User_name",style: GoogleFonts.openSans(
                            fontWeight:FontWeight.w600,
                            fontSize: size.height*0.02,
                            color: Colors.greenAccent
                        ),)

                      ],
                    ),
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    Card(
                      elevation: 0,
                      color: const Color.fromRGBO(235, 227, 240,1),
                      child:
                      Padding(
                        padding: EdgeInsets.all(size.width*0.053),
                        child: Row(
                          children: [
                            Icon(Icons.logout,color: Colors.black54,size: size.height*0.029,),
                            SizedBox(
                              width: size.width*0.04,
                            ),
                            AutoSizeText("Active",style: GoogleFonts.openSans(
                                fontWeight:FontWeight.w600,
                                fontSize: size.height*0.02,
                                color: Colors.black54
                            ),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.012,
                    ),
                    Card(
                      elevation: 0,
                      color: const Color.fromRGBO(235, 227, 240,1),
                      child:
                      Padding(
                        padding: EdgeInsets.all(size.width*0.05),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(CupertinoIcons.profile_circled,color: Colors.black54,size: size.height*0.03,),
                            SizedBox(
                              width: size.width*0.04,
                            ),
                            AutoSizeText("Edit Profile",style: GoogleFonts.openSans(
                                fontWeight:FontWeight.w600,
                                fontSize: size.height*0.02,
                                color: Colors.black54
                            ),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.012,
                    ),

                    Card(
                      elevation: 0,
                      color: const Color.fromRGBO(235, 227, 240,1),
                      child:
                      Padding(
                        padding: EdgeInsets.all(size.width*0.05),
                        child: Row(
                          children: [
                            Icon(Icons.settings,color: Colors.black54,size: size.height*0.03,),
                            SizedBox(
                              width: size.width*0.04,
                            ),
                            AutoSizeText("Account Settings",style: GoogleFonts.openSans(
                                fontWeight:FontWeight.w600,
                                fontSize: size.height*0.02,
                                color: Colors.black54
                            ),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.045,
                    ),

                    Card(
                      elevation: 0,
                      color: const Color.fromRGBO(235, 227, 240,1),
                      child:
                      Padding(
                        padding: EdgeInsets.all(size.width*0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            AutoSizeText("Log Out",style: GoogleFonts.openSans(
                                fontWeight:FontWeight.w600,
                                fontSize: size.height*0.022,
                                color: Colors.black54
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );

  }
}
