import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constrant.dart';


class CountDownTimer extends StatefulWidget {
  const CountDownTimer({Key? key}) : super(key: key);

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  late Timer _timer;
  // 1 minute and 20 seconds

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (totalSeconds<= 0) {
        timer.cancel();
      } else {
        setState(() {
          totalSeconds--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    return Scaffold(
      body: Center(
        child: AutoSizeText(
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
          style: GoogleFonts.openSans(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: size.height * 0.02,
          ),
        ),
      )
    );
  }
}