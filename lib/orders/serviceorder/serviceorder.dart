import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/orders/serviceorder/pickuporder.dart';
import 'package:mykanjeedriver/orders/serviceorder/rejectedserviceorder.dart';
import '../../constrant.dart';
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
  ScrollController serviceOrderTabController=ScrollController();

  List<String> statusOptions = [
    "Assigned",
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
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          SizedBox(
            height: size.height * 0.047,
            width: size.width,
            child: ListView.builder(
              itemCount: statusOptions.length,
         controller: serviceOrderTabController,

              padding: EdgeInsets.only(
                  right: size.width * 0.01, left: size.width * 0.0035),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: size.width * 0.0223),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currIndex = index;
                        serviceOrderPageController.jumpToPage(index);
                        // serviceOrderTabController.jumpTo(double.parse("$currIndex"));
                      });
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
                      child: Center(
                        child: AutoSizeText(
                          statusOptions[index],
                        overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              color: const Color.fromRGBO(29, 25, 43, 1),
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w500),
                        ),
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
          Expanded(
            child: PageView(
              controller: serviceOrderPageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  currIndex = value;
                });
              },
              children: const [
                AssignedServiceOrder(),
                PickUpOrder(),
                DropOffOrder(),
                DeliveredServiceOrder(),
                RejectedServiceOrder(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
