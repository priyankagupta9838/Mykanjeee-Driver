import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/orders/productorder/productorder.dart';
import 'package:mykanjeedriver/orders/serviceorder/serviceorder.dart';

import '../utils/theamscolors.dart';


class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  int index = 0;
  PageController pageController=PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {

    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemColors.buttonColor,
        centerTitle: true,
        title: AutoSizeText(
          "All Orders",
          style: GoogleFonts.cabin(
              color: Colors.white
          ),

        ),

      ),
      body:  SizedBox(
        height: size.height*1,
        width: size.width*1,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: size.height * 0.06,
            // ),
            // Container(
            //   color: const Color.fromRGBO(247, 235, 249, 1),
            //   height: size.height * 0.06,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       AutoSizeText(
            //         "All orders",
            //         style: GoogleFonts.openSans(
            //             color: Colors.black,
            //             fontSize: size.height * 0.024,
            //             fontWeight: FontWeight.w600
            //         ),
            //       ),
            //
            //     ],
            //   ),
            // ),


            Container(
              width: size.width*1,
              height: size.height*0.07,
              color: Colors.grey.shade200,

              child: Padding(
                padding:  EdgeInsets.only(left: size.height*0.08,right: size.height*0.08,top: size.height*0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.linear);

                      },
                      child: Column(
                        children: [
                          AutoSizeText("Service order",style: GoogleFonts.openSans(
                              fontSize: size.height*0.018,
                              fontWeight: FontWeight.w700,
                              color:
                              index==0
                                  ?
                              Colors.purple
                                  :
                              Colors.black54
                          ),
                          ),

                          SizedBox(
                            height: size.height*0.01,
                          ),
                          index==0
                              ?
                          Container(
                            width: size.width*0.2,
                            height: size.height*0.005,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(size.height*0.005),topLeft: Radius.circular(size.height*0.005)),
                            ),
                          )
                              :
                          const SizedBox()
                        ],
                      ),
                    ),
                    SizedBox(

                      width: size.width*0.1,
                    ),
                    InkWell(
                      onTap: (){
                        pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.linear);
                      },
                      child: Column(
                        children: [
                          AutoSizeText("Product order",style: GoogleFonts.openSans(
                              fontSize: size.height*0.018,
                              fontWeight: FontWeight.w700,
                              color:
                              index==1
                                  ?
                              Colors.purple
                                  :
                              Colors.black54
                          ),),
                          SizedBox(
                            height: size.height*0.01,
                          ),
                          index==1
                              ?
                          Container(
                            width: size.width*0.2,
                            height: size.height*0.005,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(size.height*0.005),topLeft: Radius.circular(size.height*0.005)),
                            ),
                          )
                              :
                          const SizedBox()
                        ],
                      ),
                    )
                  ],
                ),
              ),

            ),

            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (value) {

                  index=value;

                  setState(() {

                  });
                },
                children:  const [
                  ServiceOrder(),
                  ProductOrder(),
                ],
              ),
            )

          ],

        ),
      ),
    );
  }
}
