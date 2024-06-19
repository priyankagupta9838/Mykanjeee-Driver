import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/routes/routesname.dart';
import 'package:mykanjeedriver/utils/theamscolors.dart';
import '../Statemanagement/PageBlok.dart';
import '../Statemanagement/PageState.dart';
import '../api/checkout.dart';
import '../constrant.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  bool loading=true;
  List<dynamic>data=[];
  final scrollController=ScrollController();
  bool isLoadingMoreData=false;
  int page=1;


  @override
  void initState() {
    // TODO: implement initState
    CheckOut().recentActivity().then((value) {
      if(value.isNotEmpty){
        data=data+value["data"];
        loading=false;
        setState(() {
        });
      }

    });
    scrollController.addListener(pagination);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: ThemColors.buttonColor,
          title: AutoSizeText(
            "Hi ${userModel["name"].toString()}",
            style: GoogleFonts.cabin(
              color: Colors.white,
              fontSize: size.height * 0.03,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            // IconButton(
            //   onPressed: () async {
            //     await NotificationServices().getToken().then((value) {
            //       print(value.toString());
            //       NotificationServices().sendPushMessage( value.toString(),"Hello World","testing");
            //
            //     });
            //
            //   },
            //   icon: const Icon(Icons.notifications_none, color: Colors.white),
            // ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.userProfile);
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ))
          ],
        ),
        body:BlocBuilder<ActiveUserBlo,ActiveUserState>(
            builder: (context, state) {
              return SizedBox(
                child:  userModel["is_active"]==1
                    ?
                SizedBox(
                  height: size.height*1,
                  child:   loading
                      ?
                  Center(
                    child: SizedBox(
                      height: size.height*0.03,
                      width: size.height*0.03,
                      child: const CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                  )
                      :
                  data.isNotEmpty
                      ?
                  Padding(
                    padding: EdgeInsets.only(
                        right: size.width * 0.02, left: size.width * 0.02),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.13,
                            width: size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Card(
                                color: ThemColors.buttonColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      "4",
                                      style: GoogleFonts.cabin(color: Colors.white),
                                    ),
                                    AutoSizeText(
                                      "Delivery Waiting",
                                      style: GoogleFonts.cabin(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          AutoSizeText(
                            "Recent Activity",
                            style: GoogleFonts.cabin(
                                color: Colors.black87,
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          SizedBox(
                            height: size.height * 0.13 * 5,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:  data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: size.height * 0.11,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.height * 0.02))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                          children: [
                                            SizedBox(
                                              width: size.width * 0.03,
                                            ),
                                            const Icon(
                                              CupertinoIcons.gift,
                                              color: Colors.black87,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.03,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.4,
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                    "Order_Id-${ data[index]["order_id"]}",
                                                    style: GoogleFonts.cabin(
                                                        color: Colors.black87,
                                                    fontSize: size.height*0.016
                                                    ),
                                                  ),
                                                  AutoSizeText(
                                                    "Order date and time",
                                                    style: GoogleFonts.cabin(
                                                        color: Colors.black87,
                                                        fontSize: size.height*0.016
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: size.width * 0.33,
                                          child: Center(
                                            child: AutoSizeText(
                                              "${data[index]["order_status"]}",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.cabin(
                                                  color: Colors.black87,

                                                  fontSize: size.height*0.016
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                      :
                  Padding(
                    padding: EdgeInsets.only(
                        right: size.width * 0.02, left: size.width * 0.02),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.13,
                            width: size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Card(
                                color: ThemColors.buttonColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      "0",
                                      style: GoogleFonts.cabin(color: Colors.white),
                                    ),
                                    AutoSizeText(
                                      "Delivery Waiting",
                                      style: GoogleFonts.cabin(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          AutoSizeText(
                            "Recent Activity",
                            style: GoogleFonts.cabin(
                                color: Colors.black87,
                                fontSize: size.height * 0.021,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: size.height * 0.012,
                          ),
                          SizedBox(
                            height: size.height*0.5,
                            width: size.width,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height*0.15,
                                  ),
                                  Container(
                                    height: size.height*0.15,
                                    width: size.width*0.4,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("assets/images/no_order_found.jpg"),
                                          fit: BoxFit.fill
                                      ),

                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height*0.02,
                                  ),
                                  AutoSizeText(
                                    "No Activity found",
                                    style: GoogleFonts.cabin(
                                        fontSize: size.height*0.025,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                    :
                SizedBox(
                  height: size.height*1,
                  child: Center(
                    child: AutoSizeText("You are Not Active",style: GoogleFonts.cabin(
                        fontWeight: FontWeight.w600,
                        fontSize: size.height*0.03
                    ),),
                  ),
                ),
              );
            })
    );
  }


  void pagination() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (!isLoadingMoreData) {
        page++;
        setState(() {
          isLoadingMoreData = true;
        });
        CheckOut().recentActivity().then((value) {
          if(value.isNotEmpty){
            data=data+value["data"];
            loading=false;
            setState(() {
            });
          }
          else{
            loading=true;
            setState(() {
            });
          }
        });


      }
    }
  }
}
