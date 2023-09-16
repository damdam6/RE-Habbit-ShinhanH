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
    Get.to(MainView());
  }

  void showDetail() {
<<<<<<< HEAD
    // Get.to(DetailView());
=======
    //Get.to(DetailView());
>>>>>>> e7d2776f018e3b15cb448b5d690cfe6fa615e84b
  }
}
