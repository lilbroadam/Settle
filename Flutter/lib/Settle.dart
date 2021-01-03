import 'package:flutter/foundation.dart';

enum SettleType { custom, movies, restaurants } // TODO delete DefaultOptions
extension SettleTypeExt on SettleType {
  String get name => describeEnum(this);

  static SettleType toSettleType(String settleType) {
    if (settleType == 'custom') return SettleType.custom;
    if (settleType == 'movies') return SettleType.movies;
    if (settleType == 'restaurants') return SettleType.restaurants;
    throw FormatException('Could not match the string to a SettleType enum');
  }
}
enum SettleState { lobby, settling, complete }
extension SettleStateExt on SettleState {
  String get name => describeEnum(this);

  static SettleState toSettleState(String settleState) {
    if (settleState == 'lobby') return SettleState.lobby;
    if (settleState == 'settling') return SettleState.settling;
    if (settleState == 'complete') return SettleState.complete;
    throw FormatException('Could not match the string to a SettleState enum');
  }
}

class Settle {
  
  String settleCode;
  SettleType settleType;
  bool customAllowed;
  SettleState settleState;
  List<String> users = new List<String>();
  List<String> options = new List<String>();

  Settle.fromJson(Map json) {
    this.settleCode = json['settleCode'];
    this.settleType = SettleTypeExt.toSettleType(json['settleType']);
    this.customAllowed = json['customAllowed'];
    this.settleState = SettleStateExt.toSettleState(json['settleState']);
    this.users = json['users'].cast<String>();
    this.options = json['options'].cast<String>();
  }

  @override
  String toString() {
    return '['
      + 'settleCode:\'$settleCode\', settleType:${settleType.name}, '
      + 'customAllowed:$customAllowed, settleState:${settleState.name}, '
      + 'users:${users.toString()}, options:${options.toString()}'
      + ']';
  }
}
