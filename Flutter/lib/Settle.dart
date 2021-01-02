
enum SettleState { lobby, settling, complete }

class Settle {
  
  var users = new List<String>();
  SettleState state;

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

  }
}
