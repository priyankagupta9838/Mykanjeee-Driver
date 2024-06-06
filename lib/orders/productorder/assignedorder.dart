import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/checkout.dart';
import '../../constrant.dart';
import '../../routes/routesname.dart';
import 'dart:async';

class AssignedOrder extends StatefulWidget {
  const AssignedOrder({super.key});

  @override
  State<AssignedOrder> createState() => _AssignedOrderState();
}

class _AssignedOrderState extends State<AssignedOrder> {
  final ScrollController _scrollController = ScrollController();
  bool loading = true;
  bool _isFetchingData = false;
  List<dynamic> currentItems = [];
  Set<String> addedOrderIds = Set<String>();
  int _currentPage = 1;
  final int _pageSize = 1;
  late StreamController<List<dynamic>> _dataStreamController;

  @override
  void initState() {
    super.initState();
    _dataStreamController = StreamController<List<dynamic>>();
    _fetchPaginatedData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fetchPaginatedData();
      }
    });
  }

  Future<void> _fetchPaginatedData() async {
    if (_isFetchingData) return;
    setState(() {
      _isFetchingData = true;
    });

    try {
      final response = await CheckOut().allDeliveredOrder("PRODUCT", "ASSIGNED", _currentPage, _pageSize);
      if (response.isNotEmpty && response.containsKey("data")) {
        final items = response["data"] as List<dynamic>;
        final newItems = items.where((item) {
          final orderId = item["order_id"].toString();
          if (addedOrderIds.contains(orderId)) {
            return false;
          } else {
            addedOrderIds.add(orderId);
            return true;
          }
        }).toList();
        currentItems.addAll(newItems);
        _dataStreamController.add(currentItems);
        _currentPage++;
      }
    } catch (e) {
      _dataStreamController.addError(e);
    } finally {
      setState(() {
        _isFetchingData = false;
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _dataStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: userModel["is_active"] == 1
          ? SizedBox(
        height: size.height,
        child: loading
            ? Center(
          child: SizedBox(
            height: size.height * 0.03,
            width: size.height * 0.03,
            child: const CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
        )
            : StreamBuilder<List<dynamic>>(
          stream: _dataStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return SizedBox(
                height: size.height,
                width: size.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.2),
                      Container(
                        height: size.height * 0.15,
                        width: size.width * 0.4,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/no_order_found.jpg"),
                              fit: BoxFit.fill),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      AutoSizeText(
                        "No Order found",
                        style: GoogleFonts.cabin(
                            fontSize: size.height * 0.03,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              final items = snapshot.data!;
              return ListView.builder(
                controller: _scrollController,
                itemCount: items.length + 1,
                itemBuilder: (context, index) {
                  if (index == items.length) {
                    return _isFetchingData
                        ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                        : const SizedBox.shrink();
                  }
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RoutesName.assignedOrderDetail,
                          arguments: items[index]);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: size.height * 0.015,
                          right: size.width * 0.02,
                          left: size.width * 0.02),
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
                                SizedBox(width: size.width * 0.03),
                                const Icon(
                                  CupertinoIcons.gift,
                                  color: Colors.black87,
                                ),
                                SizedBox(width: size.width * 0.03),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      "Order_ID-${items[index]["order_id"]}",
                                      style: GoogleFonts.cabin(
                                          color: Colors.black87),
                                    ),
                                    AutoSizeText(
                                      "Order date and time",
                                      style: GoogleFonts.cabin(
                                          color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AutoSizeText(
                                  "${items[index]["delivery_type"]}",
                                  style: GoogleFonts.cabin(
                                      color: Colors.black87),
                                ),
                                SizedBox(width: size.width * 0.03),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      )
          : SizedBox(
        height: size.height,
        child: Center(
          child: AutoSizeText(
            "You are not active",
            style: GoogleFonts.cabin(
                fontWeight: FontWeight.w600, fontSize: size.height * 0.03),
          ),
        ),
      ),
    );
  }
}
