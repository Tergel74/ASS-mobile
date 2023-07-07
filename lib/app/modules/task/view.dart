import '../../../widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'package:flutter_html/flutter_html.dart';

class TaskView extends StatefulWidget {
  TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final _taskController = Get.put<TaskController>(TaskController());

  @override
  void initState() {
    _taskController.getForm();
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
            bottom: true,
            child:
                Obx(() => _taskController.taskStatus.value == TaskStatus.loading
                    ? const LoadingAnimation()
                    : Center(
                        child: Container(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.3,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Html(
                                  data: _taskController.form.value.description),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: screenHeight * 0.04,
                                  width: screenWidth * 0.25,
                                  child: Obx(() =>
                                      _taskController.taskStatus.value ==
                                              TaskStatus.disabled
                                          ? ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.grey),
                                              child: const Text('Start'),
                                            )
                                          : ElevatedButton(
                                              onPressed: () {
                                                // if (_taskController.form.)
                                                Get.toNamed('/dailyForm');
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.deepPurple),
                                              child: const Text('Start'),
                                            )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))));
  }
}
