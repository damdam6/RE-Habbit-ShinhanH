import 'package:http/http.dart' as http;
import 'dart:convert';
import 'light_account.dart';
import 'light_api.dart';
import 'light_balance.dart';
import 'light_transaction.dart';
import 'light_transfer.dart';
import 'light_user.dart';
import 'shb_api.dart';

Map<String, dynamic> reference = {
  'user': 'account',
  'transactionCnt': 'transaction',
  'balance': 'balance',
  'type': 'account',
  'title': 'account'
};

Map<String, dynamic> accountKeyMap = {
  'user': '고객명',
  'transactionCnt': '거래내역반복횟수',
  'balance': '잔액',
  'type': '구분',
  'title': '상품명'
};

Map<String, dynamic> accountToMap(String name, String accountNo, String type,
    String title, int balance, int transactionCnt) {
  Map<String, dynamic> map = {};
  map['고객명'] = name;
  map['계좌번호'] = accountNo;
  map['구분'] = type;
  map['상품명'] = title;
  map['잔액'] = balance;
  map['거래내역반복횟수'] = transactionCnt;
  return map;
}

void initAccount(Map account) {
  patchToFirebase('account', account);
  initBalance(account["계좌번호"], account["잔액"]);
  initTransactionList(account["계좌번호"]);
  patchUserByAccount(account);
}

void patchDiffBankAccount(accountNo, name) {
  patchToFirebase('account', {'고객명': name, '계좌번호': accountNo});
}

// 계좌번호 입력하면 계좌 정보 반환
getAccountInfo(accountNo) async {
  var path = 'v$version/account';
  final url = Uri.https(domain, "${"$path/" + accountNo}.json");
  final response = await http.get(url);
  var result = json.decode(response.body);
  return result;
}

// 이름 입력하면 계좌 목록 반환
getAccountListOf(String name) async {
  var loadedData = await loadData('user');
  if (loadedData != null) {
    for (var item in loadedData) {
      if (item.key == name) {
        return (item.value["계좌목록"]);
      }
    }
  } else {
    print("존재하지 않는 사용자입니다.");
  }
}

// 이름 입력하면 입출금계좌 리스트 출력
getCheckingAccountListOf(String name) async {
  List<dynamic> list = [];
  var loadedData = await loadData('user');
  for (var item in loadedData) {
    if (item.key == name) {
      for (var account in item.value["계좌목록"]) {
        if (account["구분"] == "입출금계좌") {
          list.add(account);
        }
      }
      return list;
    }
  }
}

// 이름 입력하면 적금계좌 리스트 출력
getSavingAccountListOf(String name) async {
  List<dynamic> list = [];
  var loadedData = await loadData('user');
  for (var item in loadedData) {
    if (item.key == name) {
      for (var account in item.value["계좌목록"]) {
        if (account["구분"] == "자유적금") {
          list.add(account);
        }
      }
      return list;
    }
  }
}

getInfoValueOf(accountNo, key) async {
  var accountList = await loadData(reference[key]);
  for (var item in accountList) {
    if (item.key == accountNo) {
      return item.value[accountKeyMap[key]];
    }
  }
}

addAccount(String user, String accountNo, String type, String title) async {
  var path = 'v$version/user/$user/계좌목록';
  final url = Uri.https(domain, "$path.json");
  var response = await http.get(url);
  var cnt = json.decode(response.body).length;
  Map<String, dynamic> account = accountToMap(user, accountNo, type, title, 0, 0);
  Map<String, dynamic> map = {};
  map[cnt.toString()] = account;
  await http.patch(
    url,
    body: json.encode(map),
  );
  initBalance(accountNo, 0);
  initTransactionList(accountNo);
  patchToFirebase('account', account);
}

String createAccountNo() {
  return (random.nextInt(100000) + 100000).toString();
}

Map<String, dynamic> api3 = {
  'account': {
    'path': 'account',
  },
  'transaction': {
    'path': 'transaction',
  },
  'balance': {
    'path': 'balance',
  },
  'user': {
    'path': 'user',
  }
};

Map<String, dynamic> keyMap3 = {
  'user': '고객명',
  'account': '계좌번호',
  'balance': '계좌번호',
  'transaction': '계좌번호',
  'notificatoin': '고객명'
};

//계좌 받아오는 로직 true-적금 false-입출금

//

