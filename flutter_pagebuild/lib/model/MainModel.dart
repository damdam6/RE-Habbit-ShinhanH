import 'dart:ffi';

import 'package:get/get.dart';

class User {
  User.privateConstructor();
  static final User _instUser = User.privateConstructor();

  static get getUserlogin {
    return _instUser;
  }

  //사용자명
  String username = 'test';

  //챌린지명
  String challengeName = '';

  //챌린지 명 -> 챌린지에서 걸러낼 단어 목록
  //카페, 커피, 스타벅스...등
  //주기적으로 갱신 필요

  //계좌 정보 - 출금 & 적금
  String chkAccount = '1234';
  String savings = '1234';
}

class MainModel {
  //Model도 싱글턴으로 구현
  MainModel.privateConstructor();

  bool threadcontroll = false;

  //MainModel.inst로 구현
  static final MainModel _inst = MainModel.privateConstructor();
  static MainModel get inst => _inst;
  //-- 여기가 싱글턴 패턴 구현 파트

//사용자 정보 객체
  User user = User.getUserlogin;
  //데이터 종류

  //성공율

  DateTime lastChecked = DateTime.now();
  //현재까지 진행된 스탬프 갯수
  int challenge = 30;
  int stampCnt = 0;

  //case 종류
  // challengeSuc = 커피 x
  // savingSuc = 커피 o 적금 o
  // fail = 커피 o 적금 x
  // savingBonus = 커피 x 적금 o

  // 0 - 커피x [성공]
  // 1 - 커피o / 적금 x [실패]
  // 2 - 커피o / 적금 o [성공]

  //성공 판에서 성공여부 체크 하는 map = 스탬프 화면에 올릴 정보들
  // key = 몇일차인지 : value = 성공여부
  Map<int, int> check = {1: -1, 2: -1, 3: 0, 4: 0};
  List<int> stampList = [];

  int challengeSuc = 10;
  int savingSuc = 10;
  int challengefail = 10;
  int savingBonus = 3;

  // 현황 나타내는 문장
  String status = '앗! 야생의 토끼가 나타났어요!\n당근을 지키러 가볼까요?';

//PieChart reset시 갱신해야하는 데이터들
  Map<String, double> PieChartMap = {};
  double sucRate = -1;
  double failRate = -1;
  double savinRate = -1;

  int dayCnt = 30;
}
