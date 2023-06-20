import 'package:flutter/material.dart';

class AttendanceChartView extends StatefulWidget {
  const AttendanceChartView({super.key, required this.all, required this.data});

  final int all;
  final int data;

  @override
  State<AttendanceChartView> createState() => _AttendanceChartViewState();
}

class _AttendanceChartViewState extends State<AttendanceChartView> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenWidth * 0.25,
      width: screenWidth * 0.25,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              height: screenWidth * 0.2,
              width: screenWidth * 0.2,
              child: CircularProgressIndicator(
                value: widget.data / widget.all,
                backgroundColor: const Color(0xFFf0f2f5),
                strokeWidth: 16,
                color: Colors.deepPurple,
              ),
            ),
          ),
          Center(
              child: Text(
            '${widget.data}/${widget.all}',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.redAccent[100]),
          ))
        ],
      ),
    );
  }
}
