import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../controller.dart';
import '../../initial/components/loading_view.dart';

class ScheduleListView extends StatefulWidget {
  const ScheduleListView({Key? key}) : super(key: key);

  @override
  State<ScheduleListView> createState() => _ScheduleListViewState();
}

class _ScheduleListViewState extends State<ScheduleListView> {
  final _scheduleController = Get.find<ScheduleController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final attendanceStatusIcons = {
      'present': MdiIcons.checkCircle,
      'late': MdiIcons.clockAlertOutline,
      'excused': MdiIcons.bookClockOutline,
      'absent': MdiIcons.exclamationThick,
      'unregistered': MdiIcons.dotsHorizontal
    };

    return Expanded(
      child: Container(
        margin:
            EdgeInsets.fromLTRB(screenWidth * 0.05, 0, screenWidth * 0.05, 0),
        child: Obx(
          () => _scheduleController.eventsStatus.value == EventsStatus.loading
              ? const LoadingAnimation()
              : _scheduleController.eventsStatus.value == EventsStatus.empty
                  ? const Center(child: Text("There aren't any events."))
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _scheduleController.events.length,
                      itemBuilder: (BuildContext context, int index) {
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
                                color: Colors.redAccent[100]),
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
                                        _scheduleController
                                            .events[index].startTime,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        _scheduleController
                                            .events[index].endTime,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _scheduleController.events[index].lesson,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 41, 46, 56)),
                                    ),
                                    Text(
                                      _scheduleController.events[index].name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color:
                                              Color.fromARGB(255, 41, 46, 56)),
                                    ),
                                  ],
                                ),
                                const Spacer(flex: 3),
                                Icon(
                                    attendanceStatusIcons[_scheduleController
                                        .events[index].attendanceStatus],
                                    color: Colors.white,
                                    size: screenWidth * 0.08),
                                const Spacer()
                              ],
                            ),
                          ),
                        );
                      }),
        ),
      ),
    );
  }
}
