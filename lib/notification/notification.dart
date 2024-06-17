import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/utils/theamscolors.dart';

import '../api/notification.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ThemColors.buttonColor,
        centerTitle: true,
        title: AutoSizeText(
          "Notification",
          style: GoogleFonts.cabin(
              color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: size.height*0.03
          ),
        ),
      ),
      body:StreamBuilder(
        stream: NotificationApi().getNotification(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data=jsonDecode(snapshot.data!.body);
            print("data isss $data");
            return snapshot.data?.statusCode==200
                ?
            Padding(
              padding:  EdgeInsets.only(right: size.width*0.02,left: size.width*0.02),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    data["data"].length>0
                    ?
                    SizedBox(
                      height:  size.height*1,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data["data"].length,
                        itemBuilder:(context, index) {

                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Container(
                                  height: size.height*0.15,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.all(Radius.circular(size.height*0.02))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        AutoSizeText(
                                          data['data'][index]["createdAt"].toString().split("T")[0],
                                          style: GoogleFonts.cabin(
                                              color: Colors.black87,
                                              fontSize: size.height*0.018,
                                              fontWeight: FontWeight.w500
                                          ),

                                        ),
                                        AutoSizeText(
                                          "${data["data"][index]["description"].toString()}}",
                                          style: GoogleFonts.cabin(
                                              color: Colors.black87,
                                              fontSize: size.height*0.018
                                          ),

                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(CupertinoIcons.multiply))
                              ],
                            ),
                          );
                        },),
                    )
                        :
                    SizedBox(

                      height: size.height*1,
                      width: size.width ,
                      child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Container(
                            height: size.height * 0.3,
                            width:size.width * 0.7,
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
                    ),
                  ],
                ),
              ),
            )
                :
                const SizedBox();

          }
          else{
            return const Center(child: CircularProgressIndicator(
              color: Colors.blue,
            ));
          }

        },
      ),
    );
  }
}
