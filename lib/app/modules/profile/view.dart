import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import '../auth/controller.dart';
import 'controller.dart';
import 'components/attendance_chart_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final authController = Get.find<AuthController>();
  final _profileController = Get.put<ProfileController>(ProfileController());

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        authController.signOut();
      case 'Settings':
        break;
    }
  }

  _refreshData() async {
    await _profileController.getAttendance();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var all = _profileController.attendance.value!.all!.obs;
    var unregistered = _profileController.attendance.value!.unregistered!.obs;
    var present = _profileController.attendance.value!.present!.obs;
    var late = _profileController.attendance.value!.late!.obs;
    var absent = _profileController.attendance.value!.absent!.obs;
    var excused = _profileController.attendance.value!.excused!.obs;

    return Scaffold(
        backgroundColor: const Color(0xFF474a58),
        appBar: AppBar(
          toolbarHeight: screenHeight * 0.05,
          titleTextStyle: const TextStyle(fontSize: 20),
          elevation: 0,
          backgroundColor: Colors.redAccent[100],
          centerTitle: true,
          title: const Text('My Profile'),
          actions: [
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    height: 30,
                    value: choice,
                    child: Text(
                      choice,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 41, 46, 56), fontSize: 14),
                    ),
                  );
                }).toList();
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _refreshData,
            )
          ],
        ),
        body: SafeArea(
          top: false,
          bottom: true,
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.15,
                decoration: BoxDecoration(
                    color: Colors.redAccent[100],
                    borderRadius: const BorderRadiusDirectional.vertical(
                        bottom: Radius.circular(40))),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: screenWidth * 0.05, bottom: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      // CachedNetworkImage(
                      //     imageUrl: authController.user.value!.pfp!,
                      //     imageBuilder: (context, imageProvider) => Container(
                      //           width: screenWidth * 0.3,
                      //           height: screenWidth * 0.3,
                      //           decoration: BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               image: DecorationImage(
                      //                   image: imageProvider, fit: BoxFit.cover)),
                      //         ))

                      Container(
                        width: screenWidth * 0.25,
                        height: screenWidth * 0.25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    authController.user.value!.pfp!),
                                fit: BoxFit.cover)),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                authController.user.value!.firstName!,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 41, 46, 56),
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                authController.user.value!.lastName!,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(authController.user.value!.email!)
                        ],
                      ),
                      const Spacer(
                        flex: 2,
                      )
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 100),
              // CircularProgressIndicator(
              //   value: 0.6,
              //   strokeWidth: 10,

              // )
              Obx(
                () => Container(
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.45,
                  margin: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 101, 104, 121),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Attendance',
                                style: TextStyle(
                                    color: Colors.teal[200], fontSize: 22),
                              ),
                              Text(
                                'Unregistered: ${unregistered.value}',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 40, 45, 56)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                AttendanceChartView(
                                    all: all.value, data: present.value),
                                const SizedBox(height: 6),
                                Text(
                                  'Present',
                                  style: TextStyle(
                                      color: Colors.redAccent[100],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                AttendanceChartView(
                                    all: all.value, data: late.value),
                                const SizedBox(height: 6),
                                Text(
                                  'Late',
                                  style: TextStyle(
                                      color: Colors.redAccent[100],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                AttendanceChartView(
                                    all: all.value, data: absent.value),
                                const SizedBox(height: 6),
                                Text(
                                  'Absent',
                                  style: TextStyle(
                                      color: Colors.redAccent[100],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                AttendanceChartView(
                                    all: all.value, data: excused.value),
                                const SizedBox(height: 6),
                                Text(
                                  'Excused',
                                  style: TextStyle(
                                      color: Colors.redAccent[100],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
