import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../location/controller.dart';

class QRScanPopupView extends StatefulWidget {
  const QRScanPopupView({super.key});

  @override
  State<QRScanPopupView> createState() => _QRScanPopupViewState();
}

class _QRScanPopupViewState extends State<QRScanPopupView> {
  final _locationController = Get.put<LocationController>(LocationController());
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      child: SizedBox(
          height: screenHeight * 0.7,
          width: screenWidth * 0.8,
          child: Center(
            child: ElevatedButton(
              child: const Text('Location'),
              onPressed: () {
                print('loc');
                _locationController.getCurrentLocation();
              },
            ),
          )),
    );
  }
}
