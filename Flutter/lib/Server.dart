import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'Settle.dart';

// A class to handle communications with the backend server
class Server {
  static const server_info_file = 'assets/serverInfo.json';
  static const server_create_path = 'createsettle';
  static const server_join_path = 'joinsettle';
  static const server_info_path = 'info';
  static const server_options_path = 'options';
  static const server_state_path = 'state';
  static const server_voting_path = 'voting';
  static const http_default_header = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };
  static const param_host_name = 'hostName';
  static const param_default_option = 'defaultOption';
  static const param_custom_allowed = 'customAllowed';
  static const response_new_settle_code = 'newSettleCode';

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static String settleCode;

  // Ask the server to create a new Settle. Return the Settle code if the server
  // responds with OK (status 200), return null otherwise.
  static Future<Settle> createSettle(
      String hostName, SettleType option, bool customAllowed) async {

    String optionString = option.name;
    String customString = customAllowed ? 'true' : 'false';

    final http.Response response = await http.post(
      await _getUrl(server_create_path),
      headers: http_default_header,
      body: jsonEncode(<String, String>{
        'userName': hostName,
        'userId': await _getUniqueID(),
        'defaultOption': optionString,
        'customAllowed': customString,
      }),
    );

    Settle responseSettle;
    if (response.statusCode == HttpStatus.ok) {
      responseSettle = Settle.fromJson(jsonDecode(response.body));
      settleCode = responseSettle.settleCode;
      print('User created Settle #$settleCode');
    } else {
      // TODO error handling
      print('there was an error trying to create a settle on the server');
    }

    return responseSettle;
  }

  // Given a joinSettleCode, ask the server to join the user to that Settle.
  // TODO how to tell caller when join fails?
  static Future<Settle> joinSettle(String userName, String joinSettleCode) async {
    final http.Response response = await http.post(
      await _getUrl(server_join_path),
      headers: http_default_header,
      body: jsonEncode(<String, String>{
        'userName': userName,
        'userId': await _getUniqueID(),
        'joinSettleCode': joinSettleCode,
      }),
    );

    Settle responseSettle;
    if (response.statusCode == HttpStatus.ok) {
      responseSettle = Settle.fromJson(jsonDecode(response.body));
      settleCode = responseSettle.settleCode;
      print('Joined user to Settle #$settleCode');
      print('Current state of Settle: $responseSettle');
    } else {
      print('${jsonDecode(response.body)['error']}');
    }

    return Future<Settle>.value(responseSettle);
  }

  // If a code parameter is provided, return the Settle object for that code.
  // Otherwrise return the Settle object for the Settle created by the calls 
  // to createSettle() or joinSettle().
  static Future<Settle> getSettle([String code]) async {
    code = code ?? settleCode;

    final http.Response response = await http.get(
      await _getUri(server_info_path, code),
      headers: http_default_header,
    );

    Map<String, dynamic> responseJson = jsonDecode(response.body);
    if (response.statusCode == HttpStatus.ok) {
      return Future<Settle>.value(new Settle.fromJson(responseJson));
    } else {
      print(responseJson['error']);
      return Future<Settle>.value(null);
    }
  }

  // Ask the server to add an Option to the Settle. Return a List of all the 
  // options in the Settle after the request was handled.
  // createSettle() or joinSettle() must have been called before this method.
  static Future<Settle> addOption(String option, [String code]) async {
    code = code ?? settleCode;

    final http.Response response = await http.post(
      await _getUri(server_options_path, code),
      headers: http_default_header,
      body: jsonEncode(<String, String>{
        'addOption': option,
      }),
    );

    Settle responseSettle;
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    if (response.statusCode == HttpStatus.ok) {
      responseSettle = Settle.fromJson(responseJson);
    } else {
      // TODO error handling
      print('ERROR: ${responseJson['error']}');
    }

    return responseSettle;
  }

  static Future<Settle> setState(SettleState state, [String code]) async {
    code = code ?? settleCode;

    final http.Response response = await http.put(
      await _getUri(server_state_path, code),
      headers: http_default_header,
      body: jsonEncode(<String, String>{
        'setState': state.name,
      })
    );

    Settle responseSettle;
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    if (response.statusCode == HttpStatus.ok) {
      responseSettle = Settle.fromJson(responseJson);
    } else {
      // TODO error handling
      print('ERROR: ${responseJson['error']}');
    }

    return responseSettle;
  }

  static Future<Settle> submitVote(String option, [String code]) async {
    code = code ?? settleCode;

    final http.Response response = await http.post(
      await _getUri(server_voting_path, code),
      headers: http_default_header,
      body: jsonEncode(<String, String>{
        'voteOption': option
      })
    );

    Settle responseSettle;
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    if (response.statusCode == HttpStatus.ok) {
      responseSettle = Settle.fromJson(responseJson);
    } else {
      // TODO error handling
      print('ERROR: ${responseJson['error']}');
    }

    return responseSettle;
  }

  // Return a unique hash that this device can be identified by
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

  // Return the URL for the given path
  static Future<String> _getUrl(String path) async {
    return (await _getServerInfoJson())[path];
  }

  // Return the URI for the given path including settleCode and this device's
  // unique ID as query parameters.
  static Future<String> _getUri(String path, String settleCode) async {
    String uri = (await _getUrl(path)) + '?';
    uri += 'settleCode=' + settleCode + '&';
    uri += 'userId=' + await _getUniqueID();
    return Future<String>.value(uri);
  }

  // Read in the server info file
  static Future<Map<String, dynamic>> _getServerInfoJson() async {
    var jsonString = await rootBundle.loadString(server_info_file);
    Map<String, dynamic> serverInfoJson = jsonDecode(jsonString);
    return serverInfoJson;
  }
}
