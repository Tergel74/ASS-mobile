import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:intl/intl.dart';
import 'components/schedule_list_view.dart';
import 'controller.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  final _scheduleController = Get.put<ScheduleController>(ScheduleController());

  @override
  void initState() {
    _scheduleController.getEventsByDate(
        date: DateFormat('yyyy-MM-dd')
            .format(_scheduleController.selectedDate.value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color(0xFFf0f2f5),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.05, 0, screenWidth * 0.05, 0),
                  height: screenHeight * 0.18,
                  width: screenWidth * 1,
                  child: Obx(
                    () => CalendarTimeline(
                      initialDate: _scheduleController.selectedDate.value,
                      firstDate: DateTime(2023, 6, 1),
                      lastDate: DateTime(2024, 6, 1),
                      onDateSelected: (date) => {
                        _scheduleController.getEventsByDate(
                            date: DateFormat('yyyy-MM-dd').format(date)),
                        _scheduleController.selectedDate.value = date
                      },
                      // monthColor: Colors.blueGrey,
                      // dayColor: Colors.blueGrey[300],
                      dayColor: Colors.black,
                      activeDayColor: Colors.white,
                      activeBackgroundDayColor: Colors.deepPurple,
                      dotsColor: Colors.white,
                    ),
                  )),
              ScheduleListView(
                  date: DateFormat('yyyy-MM-dd')
                      .format(_scheduleController.selectedDate.value))
            ],
          ),
        ));
  }
}
