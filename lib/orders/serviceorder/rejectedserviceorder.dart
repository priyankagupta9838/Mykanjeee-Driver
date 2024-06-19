import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/checkout.dart';
import '../../constrant.dart';
import '../../routes/routesname.dart';

class RejectedServiceOrder extends StatefulWidget {
  const RejectedServiceOrder({Key? key}) : super(key: key);

  @override
  State<RejectedServiceOrder> createState() => _RejectedServiceOrderState();
}

class _RejectedServiceOrderState extends State<RejectedServiceOrder> {
  final List<dynamic> orderData = [];
  bool loading = true;
  final ScrollController scrollController = ScrollController();
  int page = 1;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && hasMore) {
        setState(() {
          page++;
        });
        fetchOrders();
      }
    });
  }

  Future<void> fetchOrders() async {
    final response = await  CheckOut().allRejectedServiceOrder("QUOTE","REJECTED",page,5);
    setState(() {
      loading = false;
      if (response.isNotEmpty) {
        orderData.addAll(response["data"]);
        if (response["data"].length < 5) {
          hasMore = false;
        }
      } else {
        hasMore = false;
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:
      userModel["is_active"]==1
      ?
      loading
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      )
          : orderData.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/no_order_found.jpg",
              height: size.height * 0.15,
              width: size.width * 0.4,
              fit: BoxFit.fill,
            ),
            SizedBox(height: size.height * 0.02),
            AutoSizeText(
              "No Order found",
              style: GoogleFonts.cabin(
                fontSize: size.height * 0.03,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      )
          : Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: ListView.builder(
          controller: scrollController,
          itemCount: orderData.length + (hasMore ? 1 : 0),
          itemBuilder: (context, index) {

            if (index == orderData.length && hasMore) {

              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            } else if (index == orderData.length && !hasMore) {
              return const SizedBox.shrink();
            } else {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.rejectedServiceOderDetail,
                      arguments: orderData[index]);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
                  child: Container(
                    height: size.height * 0.11,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(size.height * 0.02),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: size.width * 0.03),
                            const Icon(CupertinoIcons.gift, color: Colors.black87),
                            SizedBox(width: size.width * 0.03),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  "Order_ID-${orderData[index]["order_id"]}",
                                  style: GoogleFonts.cabin(
                                    color: Colors.black87,
                                    fontSize: size.height * 0.018,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                AutoSizeText(
                                  "${orderData[index]["createdAt"].toString().split("T")[0]} - ${(orderData[index]["createdAt"].toString().split("T")[1]).split(".")[0]}",
                                  style: GoogleFonts.cabin(
                                    color: Colors.black87,
                                    fontSize: size.height * 0.017,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AutoSizeText(
                              "${orderData[index]["delivery_type"]}",
                              style: GoogleFonts.cabin(
                                color: Colors.black87,
                                fontSize: size.height * 0.018,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: size.width * 0.03),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
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
  }
}
