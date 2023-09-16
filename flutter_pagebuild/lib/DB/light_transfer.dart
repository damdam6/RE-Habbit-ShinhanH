import 'package:http/http.dart' as http;
import 'dart:convert';
import 'light_account.dart';
import 'light_api.dart';
import 'light_balance.dart';
import 'light_transaction.dart';
import 'light_transfer.dart';
import 'light_user.dart';
import 'shb_api.dart';

transfer(date, time, from, to, amount, memoFrom, memoTo, type) async {
  if (await getNameOf(from) != null) {
    var balance = await getBalanceOf(from);
    if (balance >= amount) {
      patchTransaction(from, date, time, type, amount, 0, memoFrom, to);
      if (await getNameOf(to) != null) {
        patchTransaction(to, date, time, type, 0, amount, memoTo, from);
      }
    } else {
      print("출금가능금액이 부족합니다!");
    }
  } else {
    patchTransaction(to, date, time, type, 0, amount, memoTo, from);
  }
}
