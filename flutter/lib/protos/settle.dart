import 'package:flutter/foundation.dart';
import 'package:settle/cloud/settle_server/settle_server.dart';

enum SettleType { custom, movies, restaurants }

extension SettleTypeExt on SettleType {
  String get name => describeEnum(this);

  static SettleType toSettleType(String? settleType) {
    if (settleType == 'custom') return SettleType.custom;
    if (settleType == 'movies') return SettleType.movies;
    if (settleType == 'restaurants') return SettleType.restaurants;
    throw FormatException('Could not match \'$settleType\' to a SettleType enum');
  }
}

enum SettleState { lobby, settling, complete }

extension SettleStateExt on SettleState {
  String get name => describeEnum(this);

  static SettleState toSettleState(String? settleState) {
    if (settleState == 'lobby') return SettleState.lobby;
    if (settleState == 'settling') return SettleState.settling;
    if (settleState == 'complete') return SettleState.complete;
    throw FormatException('Could not match \'$settleState\' to a SettleState enum');
  }
}

class Settle {
  final String? settleCode;
  final SettleType settleType;
  final bool? customAllowed;
  SettleState _settleState;
  List<String>? _users = <String>[];
  List<String>? _options = <String>[];
  String? _result;

  Settle.fromJson(Map<String, dynamic> json)
      : this.settleCode = json['settleCode'],
        this.settleType = SettleTypeExt.toSettleType(json['settleType']),
        this.customAllowed = json['customAllowed'],
        this._settleState = SettleStateExt.toSettleState(json['settleState']),
        this._users = json['users'].cast<String>(),
        this._options = json['options'].cast<String>(),
        this._result = json['result'].isEmpty ? null : json['result'];

  static Future<Settle> fromCode(String code) {
    return Server.getSettle(code);
  }

  SettleState get settleState => _settleState;
  List<String>? get users => _users;
  String get hostUser => _users!.first;
  List<String>? get options => _options;
  String? get result => _result;

  // TODO make option it's own object
  // TODO make this method not async so caller doesn't have to await
  // Add an option to this Settle.
  Future<Settle> addOption(String option) async {
    Settle settle = (await Server.addOption(option, settleCode))!;
    _update(settle);
    return settle;
  }

  // TODO make this method not async so caller doesn't have to await
  Future<Settle> setState(SettleState state) async {
    Settle settle = (await Server.setState(state, settleCode))!;
    _update(settle);
    return settle;
  }

  // TODO make this method not async so caller doesn't have to await
  Future<Settle> submitVote(String option) async {
    Settle settle = (await Server.submitVote(option, false, settleCode))!;
    _update(settle);
    return settle;
  }

  Future<Settle> userFinished() async {
    Settle settle = (await Server.submitVote("null", true, settleCode))!;
    _update(settle);
    return settle;
  } 

  // Update this Settle with the server's Settle object.
  // TODO make this method not async so caller doesn't have to await
  Future<void> update() async {
    _update(await Server.getSettle(settleCode));
  }

  // Set all of the properties in this Settle to match those in the given Settle.
  // This method should only be called on Settles that are the same Settle (i.e.
  // have the same Settle code).
  void _update(Settle settle) {
    this._settleState = settle.settleState;
    this._users = settle.users;
    this._options = settle.options;
    this._result = settle.result;
  }

  @override
  String toString() {
    return '['
      + 'settleCode:$settleCode, settleType:${settleType.name}, '
      + 'customAllowed:$customAllowed, settleState:${settleState.name}, '
      + 'users:${users.toString()}, options:${options.toString()}, '
      + 'result:${_result ?? 'null'}'
      + ']';
  }
}
