import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/checkout.dart';
import '../../routes/routesname.dart';

class RejectedOrder extends StatefulWidget {
  const RejectedOrder({Key? key}) : super(key: key);

  @override
  State<RejectedOrder> createState() => _RejectedOrderState();
}

class _RejectedOrderState extends State<RejectedOrder> {
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
    final response = await CheckOut().allDeliveredOrder("PRODUCT", "REJECTED", page, 5);
    if (response.isNotEmpty) {
      setState(() {
        orderData.addAll(response["data"]);
        loading = false;
        hasMore = true;
      });
    } else {
      setState(() {
        loading = false;
        hasMore = false;
      });
    }
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
      body: loading
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
                  Navigator.pushNamed(context, RoutesName.rejectedOderDetail,
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
      ),
    );
  }
}
