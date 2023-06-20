import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import '../auth/controller.dart';
import 'controller.dart';
import 'components/attendance_chart_view.dart';
import '../../../widgets/loading_view.dart';

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

    return Scaffold(
      backgroundColor: const Color(0xFFf0f2f5),
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.05,
        titleTextStyle: const TextStyle(fontSize: 20),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.black),
        ),
        actionsIconTheme: const IconThemeData(color: Colors.black),
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
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList();
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
            color: Colors.black,
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
                  color: Colors.white,
                  borderRadius: const BorderRadiusDirectional.vertical(
                      bottom: Radius.circular(40))),
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.05, bottom: 15),
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
                              image:
                                  NetworkImage(authController.user.value!.pfp!),
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
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              authController.user.value!.lastName!,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
              () => _profileController.profileStatus.value ==
                      ProfileStatus.loading
                  ? const LoadingAnimation()
                  : Container(
                      width: screenWidth * 0.85,
                      height: screenHeight * 0.45,
                      margin: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Attendance',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  Text(
                                      'Unregistered: ${_profileController.attendance.value!.unregistered!}')
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
                                        all: _profileController
                                            .attendance.value!.all!,
                                        data: _profileController
                                            .attendance.value!.present!),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Present',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    AttendanceChartView(
                                        all: _profileController
                                            .attendance.value!.all!,
                                        data: _profileController
                                            .attendance.value!.late!),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Late',
                                      style: TextStyle(
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
                                        all: _profileController
                                            .attendance.value!.all!,
                                        data: _profileController
                                            .attendance.value!.absent!),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Absent',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    AttendanceChartView(
                                        all: _profileController
                                            .attendance.value!.all!,
                                        data: _profileController
                                            .attendance.value!.excused!),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Excused',
                                      style: TextStyle(
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
      ),
    );
  }
}
