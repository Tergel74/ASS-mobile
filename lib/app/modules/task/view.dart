import 'package:flutter/material.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFf0f2f5),
      body: Center(
        child: Icon(Icons.task),
      ),
    );
  }
}
