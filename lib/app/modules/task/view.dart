import 'package:flutter/material.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF474a58),
      body: Center(
        child: Icon(
          Icons.task,
          color: Colors.white,
        ),
      ),
    );
  }
}
