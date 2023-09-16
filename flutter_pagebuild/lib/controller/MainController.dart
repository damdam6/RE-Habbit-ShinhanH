import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_pagebuild/controller/RegisController.dart';
import 'package:flutter_pagebuild/view/DetailView.dart';
import 'package:flutter_pagebuild/view/MainView.dart';
import 'package:flutter_pagebuild/view/RankView.dart';
import 'package:flutter_pagebuild/view/StampView.dart';
import 'package:get/get.dart';

//Detail과 Stamp, Main 데이터는 하나 MainModel에 규합
import 'package:flutter_pagebuild/model/MainModel.dart';
import 'package:flutter_pagebuild/model/RankModel.dart';

import 'package:flutter_pagebuild/controller/DetailController.dart';
import 'package:flutter_pagebuild/controller/RankController.dart';
import 'package:flutter_pagebuild/controller/StampController.dart';

import 'package:flutter_pagebuild/DB/service.dart';

class resetMainModel with ChangeNotifier {
  //싱글턴
  static final resetMainModel _inst = resetMainModel._internal();
  static final MainModel mainmodel = MainModel.inst;

  resetMainModel._internal() {
    MainModel.inst.PieChartMap['챌린지 성공'] = MainModel.inst.sucRate;
    MainModel.inst.PieChartMap['적금 성공'] = MainModel.inst.savinRate;
    MainModel.inst.PieChartMap['실패'] = MainModel.inst.failRate;
  }

  factory resetMainModel() {
    return _inst;
  }

//MainController에서 바꿔야 할 내용
//1. 사용자 명
//2. 챌린지 명
//3. 그래프 % 실시간 계산

  Future<String> get getUser async {
    User userlogin = User.getUserlogin;
    Map<String, dynamic> getUserinfoMap = await getDataMapOf('도레미');
    userlogin.username = getUserinfoMap['고객명'];
    userlogin.challengeName = getUserinfoMap['챌린지목표'];
    userlogin.chkAccount = getUserinfoMap['account'][0];
    userlogin.savings = getUserinfoMap['account'][1];

    mainmodel.challenge = 30;

    mainmodel.stampCnt = getUserinfoMap['stamp']['day'];
    mainmodel.challengeSuc = getUserinfoMap['stamp']['stampCnt'][0];
    mainmodel.challengefail = getUserinfoMap['stamp']['stampCnt'][1];
    mainmodel.savingSuc = getUserinfoMap['stamp']['stampCnt'][2];
    mainmodel.stampList = await getStampListOf('도레미');
    return userlogin.username;
  }

  Future<void> get resetUser async {
    Map<String, dynamic> getUserinfoMap = await getDataMapOf('도레미');
    mainmodel.challenge = 30;
    mainmodel.stampCnt = getUserinfoMap['stamp']['day'];
    mainmodel.challengeSuc = getUserinfoMap['stamp']['stampCnt'][0];
    mainmodel.challengefail = getUserinfoMap['stamp']['stampCnt'][1];
    mainmodel.savingSuc = getUserinfoMap['stamp']['stampCnt'][2];

    mainmodel.stampList = await getStampListOf('도레미');
  }

//원형 그래프
  void setPieChartMap() async {
    await getUser;
    //챌린지 달성률 업데이트
    MainModel.inst.sucRate =
        MainModel.inst.challengeSuc / MainModel.inst.dayCnt * 100;
    MainModel.inst.failRate =
        MainModel.inst.challengefail / MainModel.inst.dayCnt * 100;
    MainModel.inst.savinRate =
        MainModel.inst.savingSuc / MainModel.inst.dayCnt * 100;
//파이 차트에 필요한 내용만 업데이트
    MainModel.inst.PieChartMap['챌린지 성공'] = MainModel.inst.sucRate;
    MainModel.inst.PieChartMap['적금 성공'] = MainModel.inst.savinRate;
    MainModel.inst.PieChartMap['실패'] = MainModel.inst.failRate;
    notifyListeners();
  }

  void resetPieChartMap() async {
    await getUser;
    //챌린지 달성률 업데이트
    MainModel.inst.sucRate =
        MainModel.inst.challengeSuc / MainModel.inst.dayCnt * 100;
    MainModel.inst.failRate =
        MainModel.inst.challengefail / MainModel.inst.dayCnt * 100;
    MainModel.inst.savinRate =
        MainModel.inst.savingSuc / MainModel.inst.dayCnt * 100;
//파이 차트에 필요한 내용만 업데이트
    MainModel.inst.PieChartMap['챌린지 성공'] = MainModel.inst.sucRate;
    MainModel.inst.PieChartMap['적금 성공'] = MainModel.inst.savinRate;
    MainModel.inst.PieChartMap['실패'] = MainModel.inst.failRate;

//Listener
    notifyListeners();
  }
  //파이 차트에서 필요한 재료는?

//PieChartMap get
  Map<String, double> get getPieChartMap {
    //변동 사항 없으면 그대로 반환
    return MainModel.inst.PieChartMap;
  }

//성공
  String get getSucSavRate {
    //소수점 자리 수
    return MainModel.inst.sucRate.toStringAsFixed(1);
  }

  String get getSucRate {
    //소수점 자리 수
    return MainModel.inst.sucRate.toStringAsFixed(1);
  }

//실패
  String get getFailRate {
    //소수점 자리 수
    return MainModel.inst.failRate.toStringAsFixed(1);
  }

//적금으로 성공
  String get getsavinRate {
    //소수점 자리 수
    return MainModel.inst.savinRate.toStringAsFixed(1);
  }

  bool get getThreadCon {
    return mainmodel.threadcontroll;
  }
}

class MainController extends GetxController {
  //reset 모델 - 싱글턴 생성자
  resetMainModel reset = resetMainModel();
  MainModel mainmodel = MainModel.inst;

  //하단부는 페이지 관리
  void getController() {
    Get.lazyPut<DetailController>(() => DetailController());
    Get.lazyPut<RankController>(() => RankController());
    Get.lazyPut<StampController>(() => StampController());
  }

//장면 보여주는 뷰

//하단부 -  컨트롤러들
  void goToRank() {
    Get.find<RankController>();
    Get.to(() => RankView());
  }

  void goToDetail() {
    Get.find<DetailController>();
    // Get.to(() => DetailView());
  }

  void goToStamp() {
    Get.find<StampController>();
    Get.to(() => StampView());
  }
}
