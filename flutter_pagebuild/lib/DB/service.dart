import 'package:http/http.dart' as http;
import 'dart:convert';

String domain = 'shb-hackton-ad177-default-rtdb.firebaseio.com';

Map dataMap = {
  'user': {
    '_user1': {
      'account': ['_accountNo1', '_accountNo2'],
      'lastChecked': '-time',
      'stamp': {
        'day': '_day',
        'stampCnt': ['_succeedCnt', '_failCnt', '_moneyCnt'],
        'stampList': [
          '_day1',
          '_day2',
          '_day3',
          '_day4',
          '_day5',
          '_day6',
          '_day7',
          '_day8',
          '_day9',
          '_day10',
          '_day11',
          '_day12',
          '_day13',
          '_day14',
          '_day15',
          '_day16',
          '_day17',
          '_day18',
          '_day19',
          '_day20',
          '_day21',
          '_day22',
          '_day23',
          '_day24',
          '_day25',
          '_day26',
          '_day27',
          '_day28',
          '_day29',
          '_day30'
        ],
        '고객명': '_user1'
      }
    }
  }
};

Future getDataMapOf(user) async {
  var path = 'service/user/$user';
  final url = Uri.https(domain, "$path.json");
  final response = await http.get(url);
  return json.decode(response.body);
}

void patchUserData(user, accountNo1, accountNo2, challenge) async {
  var path = 'service/user/$user';
  final url = Uri.https(domain, "$path.json");
  await http.patch(
    url,
    body: json.encode(dataToMap(user, accountNo1, accountNo2, challenge)),
  );
}

Map<String, dynamic> dataToMap(
    String name, String accountNo1, String accountNo2, String challenge) {
  Map<String, dynamic> map = {};
  map['고객명'] = name;
  Map<String, dynamic> account = {};
  account['0'] = accountNo1;
  account['1'] = accountNo2;
  map['account'] = account;
  map['lastChecked'] = 0;
  Map<String, dynamic> stamp = {};
  stamp['day'] = 0;
  List stampCnt = [0, 0, 0];
  stamp['stampCnt'] = stampCnt;
  stamp['stampList'] = List<int>.filled(30, 0);
  map['stamp'] = stamp;
  map['챌린지목표'] = challenge;
  return map;
}

updateLastChecked(String user, int time) async {
  var path = 'service/user/$user';
  final url = Uri.https(domain, "$path.json");
  Map<String, dynamic> map = {};
  map["lastChecked"] = time;
  await http.patch(
    url,
    body: json.encode(map),
  );
}

updateDay(String user, int day) async {
  var path = 'service/user/$user/stamp';
  final url = Uri.https(domain, "$path.json");
  Map<String, dynamic> map = {};
  map["day"] = day;
  await http.patch(
    url,
    body: json.encode(map),
  );
}

updateStampListDayOf(String user, int day, int stamp) async {
  var path = 'service/user/$user/stamp/stampList';
  final url = Uri.https(domain, "$path.json");
  Map<String, dynamic> map = {};
  map[(day - 1).toString()] = stamp;
  await http.patch(
    url,
    body: json.encode(map),
  );
  updateStampCnt(user, day, stamp);
}

updateStampCnt(String user, int day, int stamp) async {
  var path = 'service/user/$user/stamp/stampCnt';
  final url = Uri.https(domain, "$path.json");
  var response = await http.get(url);
  var cnt = json.decode(response.body)[stamp];
  Map<String, dynamic> map = {};
  map[stamp.toString()] = cnt + 1;
  await http.patch(
    url,
    body: json.encode(map),
  );
}

Map<String, String> categoryMap = {
  "스타벅스": "커피",
  "메가커피": "커피",
  "이디야": "커피",
  "투썸플레이스": "커피",
  "배달의민족": "배달음식",
  "요기요": "배달음식",
  "쿠팡이츠": "배달음식",
  "카카오택시": "택시",
  "UT택시": "택시",
  "무신사": "옷",
  "카카오스타일": "옷"
};

categoryOf(String title) {
  return categoryMap[title];
}

// lastMonthSpending(String accountNo, int thisMonth) async {
//   List list = await getTransactionListByAccountNo(accountNo);
//   Map<String, int> categoryCnt = {};
//   for (var item in list) {
//     if (int.parse(item["거래일자"].substring(0, 2)) == ((thisMonth - 2) % 12) + 1) {
//       var expenditure = item["내용"];
//       if (categoryMap.containsKey(expenditure)) {
//         var category = categoryOf(expenditure);
//         if (categoryCnt.containsKey(category)) {
//           categoryCnt[category] = categoryCnt[category]! + 1;
//         } else {
//           categoryCnt[category] = 1;
//         }
//       }
//     }
//   }
//   return (categoryCnt);
// }
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes

void main() async {
  // print(await getDataMapOf("도레미"));
  // print(await getDataMapOf("최쏠"));
  // patchUserData("박리노", "100301", "302581");
  // updateLastChecked("도레미", 5);
  // updateDay("도레미", 5);
  // patchUserData("최몰리", "192102", "181923");
  // updateStampListDayOf("도레미", 2, 1);

  // print(await lastMonthSpending("176662", 9));
}
