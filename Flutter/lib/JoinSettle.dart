import 'package:flutter/material.dart';
import 'package:Settle/LobbyScreen.dart';
import 'Server.dart';

class JoinSettle extends StatefulWidget {
  final String hostName;
  JoinSettle(this.hostName);

  @override
  _JoinSettle createState() => _JoinSettle(hostName);
  // Read the Settle code that the user types and ask the server to join this
  // user to that Settle session

}


class _JoinSettle extends State<JoinSettle> {
  final String hostName;
  final joinCodeController = TextEditingController();

  _JoinSettle(this.hostName);

  void _joinASettlePressed() async {
    var joinSettleCode = joinCodeController.text;

    await Server.joinSettle(joinSettleCode);

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LobbyScreen(hostName, false, false, joinCodeController.text)),
     );
  }

  @override
  Widget build(BuildContext context) {
    final settleButtonWidth = 150.0;
    final settleButtonHeight = 45.0;
    final settleButtonTextStyle = new TextStyle(
      fontSize: 16.4,
    );
    final joinSettleButton = SizedBox(
      width: settleButtonWidth,
      height: settleButtonHeight,
      child: ElevatedButton(
        onPressed: _joinASettlePressed,
        child: Text('Join a Settle', style: settleButtonTextStyle),
      ),
    );
    final settleButtonMargin = EdgeInsets.all(18.0);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter a', style: TextStyle(fontSize: 25)),
            Text('code to join', style: TextStyle(fontSize: 25)),
            Text('a Settle', style: TextStyle(fontSize: 25)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: joinCodeController,
              ),
            ),
            Container(
              margin: settleButtonMargin,
              child: joinSettleButton,
            )
          ],
        ),
      ),
    );
  }
}
