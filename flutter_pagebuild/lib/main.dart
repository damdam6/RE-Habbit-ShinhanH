import 'package:flutter/material.dart';
import 'package:flutter_pagebuild/controller/RegisController.dart';
import 'package:flutter_pagebuild/view/RegisView.dart';
import 'package:get/get.dart';
import 'package:flutter_pagebuild/controller/thread.dart';

void main() {
  //myTask;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the UserController
    Get.lazyPut<RegisController>(() => RegisController());
    return GetMaterialApp(
      title: 'GetX MVC Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: '아리따-돋움',
      ),
      home: const RegisView(),
    );
  }
}
