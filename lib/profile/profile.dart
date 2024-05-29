import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/Authentication/constraints.dart';
import 'package:mykanjeedriver/Statemanagement/PageBlok.dart';
import 'package:mykanjeedriver/api/useraccount.dart';
import 'package:mykanjeedriver/constrant.dart';
import 'package:mykanjeedriver/routes/routesname.dart';
import 'package:page_transition/page_transition.dart';
import '../Statemanagement/PageEvents.dart';
import '../Statemanagement/PageState.dart';
import '../storagestreame.dart';
import '../utilityfunction.dart';
import 'addProfileimage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.all(size.height * 0.015),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.7, top: size.height * 0.02),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            CupertinoIcons.multiply,
                            size: size.height * 0.04,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.055,
                      ),
                      AddProfilePicture( profilePath: userModel["profile_picture"]==null?"":userModel["profile_picture"].toString(),),
                      // CircleAvatar(
                      //   backgroundColor: Colors.deepPurple,
                      //   radius: size.height * 0.072,
                      //   child: CircleAvatar(
                      //     radius: size.height * 0.07,
                      //   ),
                      // ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Column(
                        children: [
                          AutoSizeText(

                            userModel["email"]!=null
                            ?
                            userModel["email"].toString()
                                :
                            userModel["phone"].toString(),
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: size.height * 0.02,
                              color: Colors.greenAccent,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          AutoSizeText(
                            userModel["name"].toString(),
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: size.height * 0.02,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Card(
                        elevation: 0,
                        color: const Color.fromRGBO(235, 227, 240, 1),
                        child: Padding(
                          padding: EdgeInsets.all(size.width * 0.053),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.black54,
                                    size: size.height * 0.029,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                  AutoSizeText(
                                    "Active",
                                    style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: size.height * 0.02,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              BlocBuilder<ActiveUserBlo,ActiveUserState>(builder: (context, state) {

                                return   Switch(
                                  value: userModel["is_active"]==1?true:false,
                                  onChanged: (bool value) async {
                                    await UserAccount().activeUser(value, "0", "0").then((value1) {
                                      if(value1=="Delivery person activated successfully.")
                                      {

                                        BlocProvider.of<ActiveUserBlo>(context).add(ActiveUserUpdateEvent());
                                        userModel["is_active"]=1;
                                        setState(() {

                                        });
                                      }
                                      else{
                                        BlocProvider.of<ActiveUserBlo>(context).add(ActiveUserUpdateEvent());
                                        userModel["is_active"]=0;
                                        setState(() {

                                        });
                                      }

                                    });

                                  },

                                  activeTrackColor: Colors.purple.shade100,
                                  activeColor: Colors.purple.shade400,
                                );
                              },),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.012,
                      ),
                      InkWell(
                           onTap: (){
                             Navigator.pushNamed(context, RoutesName.updateUserProfile);
                           },
                        child: Card(
                          elevation: 0,
                          color: const Color.fromRGBO(235, 227, 240, 1),
                          child: Padding(
                            padding: EdgeInsets.all(size.width * 0.05),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.profile_circled,
                                  color: Colors.black54,
                                  size: size.height * 0.03,
                                ),
                                SizedBox(
                                  width: size.width * 0.04,
                                ),
                                AutoSizeText(
                                  "Edit Profile",
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.height * 0.02,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.012,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RoutesName.accountSetting);
                        },
                        child: Card(
                          elevation: 0,
                          color: const Color.fromRGBO(235, 227, 240, 1),
                          child: Padding(
                            padding: EdgeInsets.all(size.width * 0.05),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: Colors.black54,
                                  size: size.height * 0.03,
                                ),
                                SizedBox(
                                  width: size.width * 0.04,
                                ),
                                AutoSizeText(
                                  "Account Settings",
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.height * 0.02,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.045,
                      ),
                      InkWell(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:  Text('Do you want to log out?',style: GoogleFonts.cabin(
                                  fontSize: size.height*0.022,
                                  fontWeight: FontWeight.w600
                                ),),
                                actions: <Widget>[
                                  SizedBox(
                                    width: size.width*0.24,
                                    child: ElevatedButton(
                                      style:ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: Colors.grey.shade400
                                      ) ,
                                      onPressed: (){
                                      Navigator.of(context).pop();
                                    }, child:  const Text(

                                      'No',
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.black87),
                                    ),),
                                  ),
                                  SizedBox(
                                    width: size.width*0.24,
                                    child: ElevatedButton(

                                      style:ElevatedButton.styleFrom(
                                        elevation: 0,
                                          backgroundColor: buttonColor
                                      ) ,
                                      onPressed: () async {
                                      bool userResponse=true;
                                        if(userResponse){
                                          var box=GetStorage();
                                          box.remove("UserToken");
                                          box.remove("refreshToken");
                                          userModel.clear();
                                          userRegisterData.clear();
                                          Navigator.pushAndRemoveUntil(context, PageTransition(
                                              type: PageTransitionType.bottomToTop,
                                              duration: const Duration(milliseconds: 0),
                                              childCurrent: const Profile(),
                                              child: const StorageStream()),(route) => false,);
                                          await UserAccount().removeDeviceToken().then((value) {

                                            if(value.toString()=="success"){
                                              print("device token clear.......................................");


                                            }
                                            else{
                                              UtilityFunctions().errorToast("Please try again");
                                            }


                                          });

                                        }

                                    }, child:  const Text(
                                      'Yes',
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.white),
                                    ),),
                                  ),

                                ],
                              );
                            },
                          );
                        }
                        ,
                        child: Card(
                          elevation: 0,
                          color: const Color.fromRGBO(235, 227, 240, 1),
                          child: Padding(
                            padding: EdgeInsets.all(size.width * 0.04),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  "Log Out",
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.height * 0.022,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
