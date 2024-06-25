
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../Statemanagement/PageBlok.dart';
import '../Statemanagement/PageEvents.dart';
import '../Statemanagement/PageState.dart';
import '../api/notification.dart';
import '../utilityfunction.dart';
import '../utils/theamscolors.dart';





class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}
const textColor =  Color.fromRGBO(28, 28, 30, 1);

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(


      appBar: AppBar(
        backgroundColor: ThemColors.buttonColor,
        centerTitle: true,
        title:  AutoSizeText("Notifications",style: GoogleFonts.cabin(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: size.height*0.03

        ),),
      ),
      body: SizedBox(
        height: size.height*1,
        width: size.width*1,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              BlocBuilder<NotificationBlo,NotificationState>(builder: (context, state) {
                return   StreamBuilder(
                  stream: NotificationApi().getNotification(),

                  builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {

                    if(snapshot.hasData){
                      var data=jsonDecode(snapshot.data!.body);
                      return snapshot.data?.statusCode==200
                          ?
                      data["data"].length>0
                          ?
                      Column(
                        children: [
                          SizedBox(
                            height: size.height*0.9,
                            width: size.width*1,
                            child: Padding(
                              padding:  EdgeInsets.only(bottom: size.height*0.11),
                              child: ListView.builder(
                                padding:  EdgeInsets.all(size.height*0.01),
                                itemCount: data["data"].length,
                                itemBuilder: (context, index) {
                                  DateTime createdAt = DateTime.parse(data["data"][index]["createdAt"]);
                                  DateTime now = DateTime.now();
                                  String formattedDate;

                                  if (createdAt.year == now.year && createdAt.month == now.month && createdAt.day == now.day) {
                                    formattedDate = "Today";
                                  } else {
                                    formattedDate = DateFormat('EEEE, MMM d, yyyy h:mm a').format(createdAt);
                                  }
                                  return Stack(
                                    children: [
                                      Card(
                                        color: Colors.white54,
                                        child: Padding(
                                          padding:  EdgeInsets.all(size.height*0.016),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  AutoSizeText(formattedDate,style: GoogleFonts.openSans(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: size.height*0.018
                                                  ),),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              AutoSizeText("${data["data"][index]["description"]}",style: GoogleFonts.openSans(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: size.height*0.02
                                              ),)

                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await NotificationApi().deleteNotification(data["data"][index]["id"].toString()).then((value) {
                                            if(value=="success"){
                                              BlocProvider.of<NotificationBlo>(context).add(UpdateNotificationEvent());
                                            }
                                            else{
                                              UtilityFunctions().successToast(value.toString());

                                            }
                                          });

                                        },
                                        child: const Align(
                                            alignment: Alignment.topRight,
                                            child: Icon(CupertinoIcons.multiply)),
                                      )
                                    ],
                                  );
                                },),
                            ),
                          ),
                        ],
                      )
                          :
                      SizedBox(
                        height: size.height*0.8,
                        width: size.width ,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height * 0.1),
                            Container(
                              height: size.height * 0.3,
                              width: size.width * 0.7,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/notification.jpg"),
                                    fit: BoxFit.fill),
                              ),
                            ),

                            AutoSizeText(
                              "No Notification Found",
                              style: GoogleFonts.cabin(
                                  fontSize: size.height * 0.03,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                          :
                      const SizedBox()
                      ;


                    }
                    else{
                      return const Center(child: CircularProgressIndicator(
                        color: Colors.blue,
                      ));
                    }
                  },

                );
              },),

            ],
          ),
        ),
      ),
    );
  }
}