import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'acceptedorders.dart';


class ProductOrder extends StatefulWidget {
  const ProductOrder({super.key});

  @override
  State<ProductOrder> createState() => _ProductOrderState();
}

class _ProductOrderState extends State<ProductOrder> {


  var currIndex=0;
  PageController pageController=PageController();
  List<String>statusOptions=[
    "Assigned",
    "Accepted",
    "Rejected",
    "Delivered"
  ];
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return    SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: size.height*0.01,
            ),
            SizedBox(
              height: size.height*0.047,
              width: size.width,
              child: ListView.builder(
                itemCount: 4,
                padding: EdgeInsets.only(right:size.width*0.01,left:size.width*0.0035),
                scrollDirection: Axis.horizontal,
                itemBuilder:(context, index) {
                  return Padding(
                    padding:  EdgeInsets.only(left: size.width*0.0223),
                    child: GestureDetector(
                      onTap: () {
                        currIndex=index;
                        pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.linear);
                        setState(() {

                        });
                      },
                      child: Container(
                        height: size.height*0.047,
                        width: statusOptions[index].length<4
                            ?size.width*0.22
                            :
                        size.width*0.3,
                        decoration: BoxDecoration(
                          color: currIndex==index
                              ?
                          const Color.fromRGBO(236, 230, 240, 1)
                              :
                          const Color.fromRGBO(254, 247, 255,1),
                          borderRadius:BorderRadius.all( Radius.circular(size.width*0.02)),
                          border: Border.all(
                              color: Colors.black,
                              width: 1
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          currIndex==index
                              ?
                          MainAxisAlignment.spaceEvenly
                              :
                          MainAxisAlignment.center,
                          children: [
                            currIndex==index
                                ?
                            Icon(Icons.check,color: Colors.black,size: size.height*0.025,)
                                :
                            const SizedBox(),

                            AutoSizeText(statusOptions[index],
                              style: GoogleFonts.roboto(
                                  color: const Color.fromRGBO(29, 25, 43, 1),
                                  fontSize: size.height*0.02,
                                  fontWeight: FontWeight.w500
                              ),)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

            ),
            SizedBox(
              height: size.height*0.015,
            ),
            SizedBox(
              height: size.height*0.77,
              width: size.width*1,
              child: PageView(
                  controller:pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    currIndex=value;
                    setState(() {

                    });
                  },
                  allowImplicitScrolling: true,
                  children:   const [
                    SizedBox(),
                    Accepted(),
                    SizedBox(),
                    SizedBox(),

                  ]
              ),
            )
          ],
        ),
      ),
    );

  }
}
