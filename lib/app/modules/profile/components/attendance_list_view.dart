import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller.dart';
import '../../../../widgets/loading_view.dart';
import '../../../utils/string_capitalize.dart';

// extension StringExtensions on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${this.substring(1)}";
//   }
// }

class AttendanceListView extends StatefulWidget {
  const AttendanceListView(
      {super.key, required this.status, required this.data});

  final String status;
  final int data;

  @override
  State<AttendanceListView> createState() => _AttendanceListViewState();
}

class _AttendanceListViewState extends State<AttendanceListView> {
  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('${capitalize(widget.status)}: ${widget.data}'),
        backgroundColor: Colors.deepPurple,
        toolbarHeight: screenHeight * 0.1,
      ),
      backgroundColor: const Color(0xFFf0f2f5),
      body: Obx(() => _profileController.attendanceListStatus.value ==
              AttendanceListStatus.loading
          ? const LoadingAnimation()
          : _profileController.attendanceListStatus.value ==
                  AttendanceListStatus.empty
              ? const Center(
                  child: Text(
                  "Empty",
                  style: TextStyle(fontSize: 20),
                ))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: _profileController.attendanceList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                              screenWidth * 0.01,
                              screenHeight * 0.005,
                              screenWidth * 0.01,
                              screenHeight * 0.005),
                          child: Container(
                            alignment: Alignment.center,
                            width: screenWidth * 0.8,
                            height: screenHeight * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      screenWidth * 0.05,
                                      screenHeight * 0.01,
                                      screenWidth * 0.06,
                                      screenHeight * 0.01),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _profileController
                                            .attendanceList[index].startTime,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.deepPurple),
                                      ),
                                      Text(
                                        _profileController
                                            .attendanceList[index].endTime,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.deepPurple),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.44,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _profileController
                                            .attendanceList[index].lesson,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        _profileController
                                            .attendanceList[index].eventName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(flex: 3),
                                Text(
                                  _profileController.attendanceList[index].date,
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer()
                              ],
                            ),
                          ),
                        );
                      }),
                )),
    );
  }
}
