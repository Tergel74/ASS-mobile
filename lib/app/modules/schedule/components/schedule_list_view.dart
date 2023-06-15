import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                                color: Colors.teal[200]),
                            child: Text(
                              _scheduleController.events[index].name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        );
                      }),
        ),
      ),
    );
  }
}
