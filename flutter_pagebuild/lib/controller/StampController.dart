import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pagebuild/model/MainModel.dart';
import 'package:flutter_pagebuild/controller/MainController.dart';

import 'package:flutter_pagebuild/view/MainView.dart';

import 'package:flutter_pagebuild/view/StampView.dart';

class resetStamp with ChangeNotifier {
  //싱글턴
  static final resetStamp _inst = resetStamp._internal();
  resetStamp._internal();
  factory resetStamp() {
    return _inst;
  }

  MainModel mainmodel = MainModel.inst;
  get setStamp {}

  get getStampList {
    notifyListeners();
    return mainmodel.stampList;
  }

  get getStampCnt {
    return mainmodel.stampCnt;
  }

  get getchallengeSuc {
    return mainmodel.challengeSuc;
  }
  // 메서드들
  // MainModel 에 있는 변수 사용하기!!

  // 당근 수 가져오기

  // 스탬프 화면 위쪽에 현재 상태 문장으로 표현하는 부분
  // 변수 = status

  // 소비 x 인 경우
  // '\n🥕챌린지 현황🥕\n\n잘하고 있어요! 남은 오늘도 화이팅!\n',
  // 소비 o 인 경우
  // '\n🥕챌린지 현황🥕\n\n앗! 야생의 토끼가 나타났어요! \n당근을 지키러 가볼까요?\n',

  // check 리스트에 있는 값 받아서 도장으로 치환

  // 일단 일자마다 성공 or 실패 or 적금을 매핑해야 함(숫자로)
}

class StampController extends GetxController {
  //reset 모델 - 싱글턴 생성자
  resetStamp reset = resetStamp();

//장면 보여주는 뷰

//하단부 - 컨트롤러들
  void goToMain() async {
    await Get.off(MainView());
  }
}
