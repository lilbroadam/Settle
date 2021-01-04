import 'package:flutter/foundation.dart';
import 'Server.dart';

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
  
  final String settleCode;
  final SettleType settleType;
  final bool customAllowed;
  SettleState _settleState;
  List<String> _users = new List<String>();
  List<String> _options = new List<String>();

  Settle.fromJson(Map<String, dynamic> json) :
    this.settleCode = json['settleCode'],
    this.settleType = SettleTypeExt.toSettleType(json['settleType']),
    this.customAllowed = json['customAllowed'],
    this._settleState = SettleStateExt.toSettleState(json['settleState']),
    this._users = json['users'].cast<String>(),
    this._options = json['options'].cast<String>();

  static Future<Settle> fromCode(String code) {
    return Server.getSettle(code);
  }

  SettleState get settleState => _settleState;
  List<String> get users => _users;
  List<String> get options => _options;

  // TODO make option it's own object
  // TODO make this method not async so caller doesn't have to await
  // Add an option to this Settle.
  Future<Settle> addOption(String option) async {
    Settle settle = await Server.addOption(option, settleCode);
    // TODO update this settle
    return settle;
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
