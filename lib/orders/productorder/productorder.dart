import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mykanjeedriver/orders/productorder/rejectedorder.dart';
import 'acceptedorders.dart';
import 'assignedorder.dart';
import 'deliveredorder.dart';

class ProductOrder extends StatefulWidget {
  const ProductOrder({super.key});

  @override
  State<ProductOrder> createState() => _ProductOrderState();
}

class _ProductOrderState extends State<ProductOrder> {
  var currIndex = 0;
  PageController pageController = PageController();
  List<String> statusOptions = [
    "Assigned",
    "Accepted",
    "Rejected",
    "Delivered"
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
              itemCount: 4,
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
                        pageController.jumpToPage(index);
                      });
                    },
                    child: Container(
                      height: size.height * 0.047,
                      width: statusOptions[index].length < 4
                          ? size.width * 0.22
                          : size.width * 0.3,
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
                            overflow: TextOverflow.ellipsis,
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
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  currIndex = value;
                });
              },
              children: const [
                AssignedOrder(),
                Accepted(),
                RejectedOrder(),
                DeliveredOrder(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
