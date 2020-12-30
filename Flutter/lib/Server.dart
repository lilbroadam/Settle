import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'CreateSettle.dart';

// A class to handle communications with the backend server
class Server {
  static const server_info_file = 'assets/serverInfo.json';
  static const create_settle = 'createsettle';
  static const join_settle = 'toyjoinsettle';
  static const http_default_header = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };
  static const default_option_movies = 'movies';
  static const default_option_restaurants = 'restaurants';
  static const param_host_name = 'hostName';
  static const param_default_option = 'defaultOption';
  static const param_custom_allowed = 'customAllowed';
  static const response_new_settle_code = 'newSettleCode';

  // TODO add support to pass Settle settings to server
  // Ask the server to create a new Settle. Return the Settle code if the server
  // responds with OK (status 200), return null otherwise.
  static Future<String> createSettle(
        String hostName, DefaultOptions option, bool customAllowed) async {
    String optionString;
    if (option == DefaultOptions.movies)
      optionString = default_option_movies;
    else if (option == DefaultOptions.restaurants)
      optionString = default_option_restaurants;
    String customString = customAllowed ? 'true' : 'false';
    
    String createSettleUri = (await _getCreateSettleUrl()) + '?';
    createSettleUri += param_host_name + '=' + hostName + '&';
    createSettleUri += param_default_option + '=' + optionString + '&';
    createSettleUri += param_custom_allowed + '=' + customString;

    http.Response response = await http.get(
      createSettleUri,
      headers: http_default_header,
    );

    String newSettleCode;
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> responseJson = jsonDecode(response.body);
      newSettleCode = responseJson[response_new_settle_code];
    } else {
      // TODO handle
      print('there was an error trying to create a settle on the server');
    }
    
    return Future<String>.value(newSettleCode);
  }

  // Given a joinSettleCode, ask the server to join the user to that Settle.
  static Future<http.Response> joinSettle(String joinSettleCode) async {
    return http.post(
      await _getJoinASettleUrl(),
      headers: http_default_header,
      body: jsonEncode(<String, String>{
        'joinSettleCode': joinSettleCode,
      }),
    );
  }

  // Get the "create a settle" URL
  static Future<String> _getCreateSettleUrl() async {
    // var jsonString = await rootBundle.loadString(serverInfoFile);
    // Map<String, dynamic> serverInfoJson = jsonDecode(jsonString);
    // return serverInfoJson[create_settle];
    return (await getServerInfoJson())[create_settle];
  }

  // Get the "join a settle" URL
  static Future<String> _getJoinASettleUrl() async {
    // var jsonString = await rootBundle.loadString(serverInfoFile);
    // Map<String, dynamic> serverInfoJson = jsonDecode(jsonString);
    // return serverInfoJson[join_settle];
    return (await getServerInfoJson())[join_settle];
  }

  // Read in the server info file
  static Future<Map<String, dynamic>> getServerInfoJson() async {
    var jsonString = await rootBundle.loadString(server_info_file);
    Map<String, dynamic> serverInfoJson = jsonDecode(jsonString);
    return serverInfoJson;
  }  
}
