import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'CreateSettle.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

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
  static const default_option_custom = 'custom';
  static const param_host_name = 'hostName';
  static const param_default_option = 'defaultOption';
  static const param_custom_allowed = 'customAllowed';
  static const response_new_settle_code = 'newSettleCode';

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  // Ask the server to create a new Settle. Return the Settle code if the server
  // responds with OK (status 200), return null otherwise.
  static Future<String> createSettle(
      String hostName, DefaultOptions option, bool customAllowed) async {
    // TODO Change to String optionString = theDay.toString().split('.').last;
    String optionString;
    if (option == DefaultOptions.movies)
      optionString = default_option_movies;
    else if (option == DefaultOptions.restaurants)
      optionString = default_option_restaurants;
    else if (option == DefaultOptions.custom)
      optionString = default_option_custom;
    else {
      // TODO
    }
    String customString = customAllowed ? 'true' : 'false';

    final http.Response response = await http.post(
      await _getCreateSettleUrl(),
      headers: http_default_header,
      body: jsonEncode(<String, String>{
        'hostName': hostName,
        'hostId': await _getUniqueID(),
        'defaultOption': optionString,
        'customAllowed': customString,
      }),
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
  // TODO not sure if this method should return something or not
  static Future<String> joinSettle(String joinSettleCode) async {
    final http.Response response = await http.post(
      await _getJoinASettleUrl(),
      headers: http_default_header,
      body: jsonEncode(<String, String>{
        'joinSettleCode': joinSettleCode,
      }),
    );

    if (response.statusCode == 200) {
      print('it worked');
      print(response.body);
    } else {
      print('it didn\'t work');
      print(response.body);
    }

    return Future<String>.value(null);
  }

  static Future<String> _getUniqueID() async {
    String deviceName;
    String deviceVersion;
    String identifier;

    try {
      if (Platform.isAndroid) {
        var device = await deviceInfoPlugin.androidInfo;
        deviceName = device.model;
        deviceVersion = device.version.toString();
        identifier = device.androidId;
      } else if (Platform.isIOS) {
        var device = await deviceInfoPlugin.iosInfo;
        deviceName = device.name;
        deviceVersion = device.systemVersion;
        identifier = device.identifierForVendor;
      }
    } on PlatformException {
      print("Error getting device info");
    }

    String id = deviceName + "-" + deviceVersion + "-" + identifier;
    return id.hashCode.toString();
  }

  // Get the "create a settle" URL
  static Future<String> _getCreateSettleUrl() async {
    return (await getServerInfoJson())[create_settle];
  }

  // Get the "join a settle" URL
  static Future<String> _getJoinASettleUrl() async {
    return (await getServerInfoJson())[join_settle];
  }

  // Read in the server info file
  static Future<Map<String, dynamic>> getServerInfoJson() async {
    var jsonString = await rootBundle.loadString(server_info_file);
    Map<String, dynamic> serverInfoJson = jsonDecode(jsonString);
    return serverInfoJson;
  }
}
