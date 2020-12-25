import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

// A class to handle communications with the backend server
class Server {
  static const serverInfoFile = 'assets/serverInfo.json';
  static const create_settle = 'toycreatesettle';
  static const join_settle = 'toyjoinsettle';

  // Given a joinSettleCode, join that Settle session
  static Future<http.Response> joinSettle(String joinSettleCode) async {
    var joinASettleUrl = await _getJoinASettleUrl();

    return http.post(
      joinASettleUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'joinSettleCode': joinSettleCode,
      }),
    );
  }

  // Get the "join a settle" URL
  static Future<String> _getJoinASettleUrl() async {
    var jsonString = await rootBundle.loadString(serverInfoFile);
    Map<String, dynamic> serverInfoJson = jsonDecode(jsonString);
    return serverInfoJson[join_settle];
  }
}
