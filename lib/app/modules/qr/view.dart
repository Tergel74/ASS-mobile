import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../location/controller.dart';
import 'controller.dart';
import '../../../widgets/success_view.dart';
import '../../../widgets/loading_view.dart';

class QRScanPopupView extends StatefulWidget {
  const QRScanPopupView(
      {super.key,
      required this.eventId,
      required this.date,
      required this.startTime});

  final String eventId;
  final String date;
  final String startTime;

  @override
  State<QRScanPopupView> createState() => _QRScanPopupViewState();
}

class _QRScanPopupViewState extends State<QRScanPopupView> {
  final _locationController = Get.put<LocationController>(LocationController());
  final _qrController = Get.put<QrController>(QrController());
  MobileScannerController cameraController = MobileScannerController();

  @override
  void initState() {
    cameraController.switchCamera();
    _qrController.qrStatus.value = QrStatus.scanning;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      child: SizedBox(
          height: screenHeight * 0.45,
          width: screenWidth * 0.8,
          child: Obx(
            () => _qrController.qrStatus.value == QrStatus.completed
                ? const SuccessView()
                : _qrController.qrStatus.value == QrStatus.detected
                    ? const LoadingAnimation()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenWidth * 0.75,
                              width: screenWidth * 0.75,
                              child: MobileScanner(
                                  controller: cameraController,
                                  onDetect: _foundBarcode),
                            ),
                            ElevatedButton(
                              child: const Text('Close'),
                              onPressed: () {
                                Get.back();
                              },
                            )
                          ],
                        ),
                      ),
          )),
    );
  }

  void _foundBarcode(BarcodeCapture barcode) async {
    _qrController.qrStatus.value = QrStatus.detected;
    await _locationController.getCurrentLocation();
    if (_locationController.inZoneStatus.value == InZoneStatus.inside) {
      final String code = barcode.barcodes[0].rawValue ?? '---';
      final eventDate = DateTime.parse('${widget.date} ${widget.startTime}:00');
      final currentDate = DateTime.now();
      final timeDifference = currentDate.difference(eventDate).inMinutes;
      _qrController.checkInAttendanceQr(
          qrString: code,
          eventId: widget.eventId,
          date: widget.date,
          timeDifference: timeDifference);
    } else {
      Get.snackbar('Location',
          'Device is not in ${LocationController.checkRadius} radius of the school!');
      Get.back();
    }
  }
}
