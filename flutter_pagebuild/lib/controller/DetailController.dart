import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pagebuild/model/MainModel.dart';
import 'package:flutter_pagebuild/controller/MainController.dart';

import 'package:flutter_pagebuild/view/MainView.dart';
import 'package:flutter_pagebuild/view/DetailView.dart';

class DetailController extends GetxController {
  //var mainDB = MainModel("DetailControllerTest").obs;

  //void work(String str) {
  //mainDB.value.test = str;
  //mainDB.refresh();
  //}

  void goToMain() {
    Get.to(const MainView());
  }

  void showDetail() {
    // Get.to(DetailView());
  }
}
