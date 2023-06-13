import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/pages.dart';

void main() async {
  runApp(GetMaterialApp(
    title: 'Upro',
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
    debugShowCheckedModeBanner: false,
  ));
}
