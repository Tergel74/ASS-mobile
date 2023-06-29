import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../controller.dart';
import '../../../../widgets/loading_view.dart';
import '../../qr/view.dart';

class ScheduleListView extends StatefulWidget {
  const ScheduleListView({Key? key, required this.date}) : super(key: key);
  final String date;

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
      'unregistered': MdiIcons.dotsHorizontal,
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
                          child: InkWell(
                            onTap: () {
                              _scheduleController
                                          .events[index].attendanceStatus ==
                                      'unregistered'
                                  ? showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          QRScanPopupView(
                                            eventId: _scheduleController
                                                .events[index].id,
                                            date: widget.date,
                                            startTime: _scheduleController
                                                .events[index].startTime,
                                            registerType: _scheduleController
                                                .events[index].registerType,
                                          ))
                                  : print(_scheduleController
                                      .events[index].attendanceStatus);
                            },
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _scheduleController
                                              .events[index].startTime,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.deepPurple),
                                        ),
                                        Text(
                                          _scheduleController
                                              .events[index].endTime,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.deepPurple),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _scheduleController
                                              .events[index].lesson,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          _scheduleController
                                              .events[index].name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(flex: 3),
                                  Tooltip(
                                    message: _scheduleController
                                        .events[index].attendanceStatus,
                                    child: Icon(
                                        attendanceStatusIcons[
                                            _scheduleController.events[index]
                                                .attendanceStatus],
                                        color: Colors.deepPurple,
                                        size: screenWidth * 0.08),
                                  ),
                                  const Spacer()
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
        ),
      ),
    );
  }
}
