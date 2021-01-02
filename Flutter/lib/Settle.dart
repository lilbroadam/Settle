import 'package:flutter/foundation.dart';

enum SettleState { lobby, settling, complete }
extension SettleStateExt on SettleState {
  String get name => describeEnum(this);
}

class Settle {
  
  SettleState state;
  List<String> users = new List<String>();
  List<String> options = new List<String>();

  Settle.fromJson(Map json) {
    var state = json['state'];
    if (state == 'lobby')
      this.state = SettleState.lobby;
    else if (state == 'settling')
      this.state = SettleState.settling;
    else if (state == 'complete')
      this.state = SettleState.complete;
    else {
      // TODO error handling
    }

    json['users'].forEach((user) {
      this.users.add(user);
    });

    json['optionPool'].forEach((option) {
      this.options.add(option);
    });

    print(this);
  }

  @override
  String toString() {
    var stringBuffer = StringBuffer();

    stringBuffer.write('users:[');
    users.forEach((user) {
      stringBuffer.write(user + ', ');
    });
    stringBuffer.write('], ');

    stringBuffer.write('options:[');
    options.forEach((option) {
      stringBuffer.write(option + ', ');
    });
    stringBuffer.write(']');

    return '['
      + 'state:' + state.name + ', '
      + stringBuffer.toString() + ']';
  }
}
