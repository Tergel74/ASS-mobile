import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ErrorFormView extends StatefulWidget {
  const ErrorFormView({super.key});

  @override
  State<ErrorFormView> createState() => _ErrorFormViewState();
}

Color themeColor = Colors.redAccent;

class _ErrorFormViewState extends State<ErrorFormView> {
  @override
  void initState() {
    startTime();
    super.initState();
  }

  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Get.toNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                height: screenWidth * 0.4,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(35),
                decoration: BoxDecoration(
                  color: themeColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  IconlyBold.tick_square,
                  color: Colors.white,
                  size: screenWidth * 0.25,
                )),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Error",
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            const Text(
              "Something went wrong!",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
