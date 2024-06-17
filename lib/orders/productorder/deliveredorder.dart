import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/checkout.dart';
import '../../constrant.dart';
import '../../routes/routesname.dart';

class DeliveredOrder extends StatefulWidget {
  const DeliveredOrder({Key? key}) : super(key: key);

  @override
  _DeliveredOrderState createState() => _DeliveredOrderState();
}

class _DeliveredOrderState extends State<DeliveredOrder> {
  final List<dynamic> _orderData = [];
  bool _loading = true;
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMoreData = false;
  int _page = 1;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchOrders();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoadingMoreData && _hasMore) {
        setState(() {
          _isLoadingMoreData = true;
          _page++;
        });
        _fetchOrders();
      }
    });
  }

  Future<void> _fetchOrders() async {
    final response = await CheckOut().allDeliveredOrder("PRODUCT", "DELIVERED", _page, 5);
    if (response.isNotEmpty) {
      setState(() {
        _orderData.addAll(response["data"]);
        _loading = false;
        _isLoadingMoreData = false;
        _hasMore = true;
      });
    } else {
      setState(() {
        _hasMore = false;
        _loading = false;
        _isLoadingMoreData = false;
        _hasMore = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _loading
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      )
          : _orderData.isEmpty
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
          controller: _scrollController,
          itemCount: _orderData.length + (_hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _orderData.length && _hasMore) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            } else {
              final order = _orderData[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.deliveredOderDetail, arguments: order);
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
                                  "Order_ID-${order["order_id"]}",
                                  style: GoogleFonts.cabin(
                                    color: Colors.black87,
                                    fontSize: size.height * 0.018,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                AutoSizeText(
                                  "${order["createdAt"].toString().split("T")[0]} - ${(order["createdAt"].toString().split("T")[1]).split(".")[0]}",
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
                              "${order["delivery_type"]}",
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
