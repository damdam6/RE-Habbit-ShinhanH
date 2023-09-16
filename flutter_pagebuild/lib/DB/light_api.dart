import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'light_account.dart';
import 'light_api.dart';
import 'light_balance.dart';
import 'light_transaction.dart';
import 'light_transfer.dart';
import 'light_user.dart';
import 'shb_api.dart';

Random random = Random();
String domain = 'shb-hackton-ad177-default-rtdb.firebaseio.com';
String version = '3';

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

void patchToFirebase(action, map) async {
  var path = 'v$version/' + api3[action]['path'];
  var keyName = keyMap3[action];
  final url = Uri.https(domain, "$path.json");
  Map<String, dynamic> temp = {};
  temp[map[keyName]] = map;
  await http.patch(
    url,
    body: json.encode(temp),
  );
}

Future<List> loadData(action) async {
  var path = 'v$version/' + api3[action]['path'];
  final url = Uri.https(domain, "$path.json");
  final response = await http.get(url);
  final Map<String, dynamic> listData = json.decode(response.body);
  final List<Object> loadedData = [];
  for (final item in listData.entries) {
    loadedData.add(item);
  }
  return loadedData;
}

// 1원 인증 request 메서드
request1transfer() async {
  var path = 'v1/auth/1transfer';
  var dataBody = {
    "입금은행코드": "088",
    "입금계좌번호": "110222999999",
    "입금통장메모": "1234 SSAFY"
  };
  final url = Uri.https('shbhack.shinhan.com', path);
  Map<String, dynamic> map = {};
  map["dataHeader"] = {"apikey": "2023_Shinhan_SSAFY_Hackathon"};
  map["dataBody"] = dataBody;
  final response = await http.post(
    url,
    headers: {},
    body: json.encode(map),
  );
  return response;
}

// 유효한 계좌인지 체크하는 메서드
validAccountCheck() async {
  var response = await request1transfer();
  return json.decode(response.body)["dataHeader"]["successCode"] == "0";
}

// 1원이체 실명인증 메서드
// 현재 1원이체 메시지가 1234로 고정되어 있기 때문에, 1234입력하면 인증 성공, 다른 값 입력하면 인증 실패
auth1transfer(String input) {
  return input == "1234";
}

getList(action) async {
  var path = 'v$version/' + api3[action]['path'];
  final url = Uri.https(domain, "$path.json");
  var response = await http.get(url);
  var list = response.body;
  return list;
}

// timestampToDateTime(int timestamp) {
//   List list = [];
//   list.add("09${(timestamp ~/ 24 + 1).toString().padLeft(2, '0')}");
//   list.add("${(timestamp % 24).toString().padLeft(2, '0')}00");
//   return list;
// }

// timeToString(int time) {
//   return time.toString().padLeft(2, '0') + "00";
// }

timestamp(String date, String time) {
  int year = 2023;
  int month = int.parse(date.substring(0, 2));
  int day = int.parse(date.substring(2));
  int hour = int.parse(time.substring(0, 2));
  int minute = int.parse(time.substring(2));
  DateTime dateTime = DateTime(year, month, day, hour, minute);
  return dateTime.millisecondsSinceEpoch;
}

void main() async {
  // initUser("도레미");
  // initUser("쏠");
  // patchAccount("슈", (random.nextInt(100000) + 100000).toString(), "입출금계좌",
  //     "쏠편한입출금통장", 100000, 0);
  // patchBalance("197104", 95000);
  // getAccountListOf("도레미");

  // List list = await loadData('user');
  // print(list);

  // var cnt = await getTransactionCnt("197104");
  // print(cnt);

  // patchBalance("121735", 5000, 0);

  // transfer("0913", 185, "105039", "165169", 7500, "보낸사람 메모", "받는사람 메모", "신한체크");
  // var response = await request1transfer();
  // var check = await validAccountcheck();
  // getSavingAccountListOf("도레미");

  // for (var userEntry in userData.entries) {
  //   var username = userEntry.key;
  //   var user = userEntry.value;

  //   Map<String, dynamic> accountList = user['accountList'];
  //   // for (var accountEntry in accountList.entries)
  //   print(accountList);
  // }
  // for (var item in .entries) {
  //   print(item.value);

  // var accountList = await
  // final url = Uri.https(domain, path + ".json");
  // Map<String, dynamic> map = new Map();
  // map["거래내역반복횟수"] = transactionCnt + 1;
  // await http.patch(
  //   url,
  //   body: json.encode(map),
  // );
  test();
}

void test() async {
  String user1 = "도레미";
  String user2 = "쏠";
  // initUser(user1);
  // initUser(user2);
  var user1Account = await getCheckingAccountListOf(user1);
  var user2Account = await getCheckingAccountListOf(user2);
  var user1AccountNo = user1Account["계좌번호"];
  var user2AccountNo = user2Account["계좌번호"];
  int time = 365;
  // String date = timeToDate(time);
  // transfer(
  //     date, time, user1AccountNo, user2AccountNo, 5000, "스타벅스", user1, "신한체크");
}
