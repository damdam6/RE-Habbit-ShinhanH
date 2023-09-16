import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_pagebuild/view/MainView.dart';
import 'package:get/get.dart';
import 'package:flutter_pagebuild/model/MainModel.dart';
import 'package:flutter_pagebuild/controller/MainController.dart';
import 'package:flutter_pagebuild/view/RankView.dart';

class RankController extends GetxController {
  // var mainDB = MainModel("RegisControllerTest").obs;

  // void work(String str) {
  //   mainDB.value.detailTest = str;
  //   mainDB.refresh();
  // }

  void goToMain() {
    Get.to(MainView());
  }

  void showRank() {
    Get.to(RankView());
  }
}
