import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller.dart';
import 'attendance_list_view.dart';

class AttendanceChartView extends StatefulWidget {
  const AttendanceChartView(
      {super.key, required this.all, required this.data, required this.status});

  final int all;
  final int data;
  final String status;

  @override
  State<AttendanceChartView> createState() => _AttendanceChartViewState();
}

class _AttendanceChartViewState extends State<AttendanceChartView> {
  final _profileController = Get.find<ProfileController>();

  void goToAttendanceList() async {
    _profileController.getAttendanceForStatus(status: widget.status);
    Get.to(() => AttendanceListView(status: widget.status, data: widget.data));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        goToAttendanceList();
      },
      child: SizedBox(
        height: screenWidth * 0.25,
        width: screenWidth * 0.25,
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: screenWidth * 0.2,
                width: screenWidth * 0.2,
                child: CircularProgressIndicator(
                  value: widget.all == 0 ? 0 : widget.data / widget.all,
                  backgroundColor: const Color(0xFFf0f2f5),
                  strokeWidth: 16,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Center(
                child: Text(
              '${widget.data}/${widget.all}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ))
          ],
        ),
      ),
    );
  }
}
