import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home/home.dart';
import 'notification/notification.dart';
import 'orders/ordermainPage.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  PageController pageController = PageController();
  Color activeColor = const Color.fromRGBO(174, 144, 194, 1);
  Color inactiveColor = Colors.black54;
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currIndex = index;
          });
        },
        children: const [
          HomePage(),
          MyOrders(),
          NotificationPage(),
        ],
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.075,
        decoration: const BoxDecoration(
          color: Colors.white70,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavBarItem(Icons.home_outlined, "Home", 0),
            buildNavBarItem(Icons.directions_bike_outlined, "Orders", 1),
            buildNavBarItem(Icons.notifications, "Updates", 2),
          ],
        ),
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          currIndex = index;
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: currIndex == index ? activeColor : inactiveColor,
            size: MediaQuery.of(context).size.height * 0.03,
          ),
          AutoSizeText(
            label,
            style: GoogleFonts.openSans(
              fontSize: MediaQuery.of(context).size.height * 0.01,
              color: currIndex == index ? activeColor : inactiveColor,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
