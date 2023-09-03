import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_pagebuild/Controller_Main.dart';
import 'package:flutter_pagebuild/ScreenPage1.dart';
import 'package:flutter_pagebuild/ScreenPage2.dart';
import 'package:flutter_pagebuild/ScreenPage3.dart';
import 'package:flutter_pagebuild/Controller_Main.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: login(),
      getPages: [
        GetPage(
          name: '/',
          page: () => MyWidget(),
        ),
        GetPage(
          name: '/',
          page: () => ScreenPage1(),
        ),
        GetPage(
          name: '/',
          page: () => ScreenPage2(),
        ),
        GetPage(
          name: '/',
          page: () => ScreenPage3(),
        ),
      ],
    );
  }
}

class login extends StatelessWidget {
  Widget build(BuildContext buildContext) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
          child: Text('메인 진입'),
          onPressed: () {
            Get.off(MyWidget());
          }),
    ));
  }
}

class MyWidget extends StatelessWidget {
  Widget build(BuildContext buildContext) {
    final controller = Get.put(Controller_Main());

    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // ElevatedButton(
          // child: Text('테스트 버튼'),
          // onPressed: () {
          //  "${controller.testS.value}",
          // }),

          GetBuilder<Controller_Main>(builder: (controller) {
            return Text('${controller.testS.value}');
          }),
          ElevatedButton(
              child: Text('테스트 버튼'),
              onPressed: () {
                controller.increment;
              }),

          ElevatedButton(
              child: Text('개인'),
              onPressed: () {
                Get.to(ScreenPage1());
              }),
          ElevatedButton(
              child: Text('스탬프'),
              onPressed: () {
                Get.to(ScreenPage2());
              }),
          ElevatedButton(
              child: Text('랭킹'),
              onPressed: () {
                Get.to(ScreenPage3());
              }),
        ]),
      ),
    );
  }
}
