import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/orders/serviceorder/pickuporder.dart';
import 'package:mykanjeedriver/orders/serviceorder/rejectedserviceorder.dart';
import 'acceptedServiceOrder.dart';
import 'assiendServiceorder.dart';
import 'deliveredSerivceOrder.dart';
import 'dropOfforder.dart';




class ServiceOrder extends StatefulWidget {
  const ServiceOrder({super.key});

  @override
  State<ServiceOrder> createState() => _ServiceOrderState();
}

class _ServiceOrderState extends State<ServiceOrder> {
  var currIndex = 0;
  PageController pageController = PageController();
  List<String> statusOptions = [
    "Assigned",
    "Accepted",
    "Pickup",
    "Drop off",
    "Delivered",
    "Rejected",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.01,
            ),
            SizedBox(
              height: size.height * 0.047,
              width: size.width,
              child: ListView.builder(
                itemCount: 6,
                padding: EdgeInsets.only(
                    right: size.width * 0.01, left: size.width * 0.0035),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: size.width * 0.0223),
                    child: GestureDetector(
                      onTap: () {
                        currIndex = index;
                        pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.linear);
                        setState(() {});
                      },
                      child: Container(
                        height: size.height * 0.047,
                        width: size.width * 0.3,
                        decoration: BoxDecoration(
                          color: currIndex == index
                              ? const Color.fromRGBO(230, 220, 240, 1)
                              : const Color.fromRGBO(254, 247, 255, 1),
                          borderRadius:
                          BorderRadius.all(Radius.circular(size.width * 0.02)),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              statusOptions[index],
                              style: GoogleFonts.roboto(
                                  color: const Color.fromRGBO(29, 25, 43, 1),
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            SizedBox(
              height: size.height * 0.77,
              width: size.width * 1,
              child: PageView(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    currIndex = value;
                    setState(() {});
                  },
                  allowImplicitScrolling: true,
                  children: const [
                    AssignedServiceOrder(),
                    AcceptedServiceOrder(),
                    PickUpOrder(),
                    DropOffOrder(),
                    DeliveredServiceOrder(),
                    RejectedServiceOrder(),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}