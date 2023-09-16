import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_pagebuild/model/MainModel.dart';
import 'package:flutter_pagebuild/view/MainView.dart';
import 'package:get/get.dart';
import 'package:flutter_pagebuild/model/RegisModel.dart';
import 'package:flutter_pagebuild/controller/MainController.dart';

import 'package:flutter_pagebuild/DB/light_account.dart';
import 'package:flutter_pagebuild/DB/service.dart';

// 1. 계좌번호&이름 입력
// 2. 계좌번호를 통한 본인인증
// 3. 해당 사용자 확인 (페이지 추가 필요) - 데이터 불러오기
// 4. 지출 확인할 계좌
// 5. 소비 항목 (주요 키워드)
// --> 이 부분 정리해야 될 것 같음
// 6. 적금 계좌 연결

//계좌 인스턴스 생성
class Account {
  Account(this.accName, this.accNum);
  String accName;
  String accNum;

  bool selected = false;
}

//계좌 리스트 관리 클래스
class AccountList with ChangeNotifier {
  static final AccountList _inst = AccountList._internal();
  AccountList._internal();
  factory AccountList() {
    return _inst;
  }

//RegisModel - 싱글턴
  RegisModel regisModel = RegisModel();
  CheckModel checkInfo = CheckModel();

  dataToAccount(account, bool saving) {
    if (saving) {
      if (account["구분"]?.contains("적금")) {
        String accName = account["상품명"];
        String accNum = account["계좌번호"];
        return Account(accName, accNum);
      }
    } else {
      if (account["구분"]?.contains("입출금")) {
        String accName = account["상품명"];
        String accNum = account["계좌번호"];
        return Account(accName, accNum);
      }
    }
  }

  Future<List<dynamic>> setAccountList(bool saving) async {
    List<dynamic> tmplist =
        await getAccountListOf(checkInfo.registName); //Map을 담은 리스트

    int idx = 0;
    regisModel.accountList.clear();
    while (idx < tmplist.length) {
      dynamic tmp = dataToAccount(tmplist[idx], saving);
      if (tmp != null) {
        regisModel.accountList.add(tmp);
      }

      idx++;
    }

    return regisModel.accountList;
  }

//사용자가 고른 계좌 정보 등록
  void setaccountConsum(int? selecRow) async {
    if (selecRow == null) return;
    regisModel.accountConsum = regisModel.accountList[selecRow];
  }

  void setaccountSaving(int? selecRow) async {
    if (selecRow == null) return;
    regisModel.accountSaving = regisModel.accountList[selecRow];
  }

  Account? get getaccountConsum {
    return regisModel.accountConsum;
  }

  Account? get getaccountSaving {
    return regisModel.accountSaving;
  }
}

class pickChallenge {
  // 챌린지 고르는 클래스
  static final pickChallenge _inst = pickChallenge._internal();
  pickChallenge._internal();
  factory pickChallenge() {
    return _inst;
  }

  RegisModel regisModel = RegisModel();

  get getconsumList {
    //소비내역 반환
    return regisModel.consumList;
  }

  List get getconsumLabel {
    return regisModel.consumLabel;
  }

  void setSavingAmount(int amount) {
    regisModel.savingAmount = amount;
  }

  get getSavingAmount {
    return regisModel.savingAmount;
  }
}

class RegisController extends GetxController {
  //싱글톤 코드가 이것도 있대요....
  static final RegisController _inst = RegisController._internal();
  RegisController._internal();
  factory RegisController() {
    return _inst;
  }

//자료 Model 인스턴스 받아오기
  RegisModel regisModel = RegisModel();

//CheckModel -> 본인 인증 모델
  CheckModel checkInfo = CheckModel();

//MainController불러오기
  resetMainModel resetMainM = resetMainModel();

//이름 받아오는 파트
  static TextEditingController inputName = TextEditingController();
  bool setUser(String user, String bankname, String account) {
    if (user == '' || account == '') {
      return false;
    }
    //사용자 이름 받아오기 user  -> 사용자 이름임
    checkInfo.registName = user;
    checkInfo.checkBank = bankname;
    checkInfo.checkAccount = account;

    return true;
  }

  bool verif(String str) {
    //본인인증 정답
    String rightVeri = '0000';

    if (str != rightVeri) return false;

    return true;
  }

//메인 화면 연결
  void goToMain() {
    //사용자 정보 업로드
    //이름, 입출금, 적금,
    patchUserData(checkInfo.registName, regisModel.accountConsum!.accNum,
        regisModel.accountSaving!.accNum, '커피 안 마시기', 10000);

    User userlogin = User.getUserlogin;
    userlogin.username = checkInfo.registName;
    userlogin.challengeName = '커피 안 마시기';
    userlogin.chkAccount = regisModel.accountConsum!.accNum;
    userlogin.savings = regisModel.accountSaving!.accNum;

    Get.put(MainController());
    //getController 필요할 때 만들 클래스들 저장
    Get.find<MainController>().getController();
    Get.offAll(() => MainView());
  }

  void goToMainTest() {
    Get.put(MainController());
    //getController 필요할 때 만들 클래스들 저장
    Get.find<MainController>().getController();
    Get.offAll(() => MainView());
  }
}
