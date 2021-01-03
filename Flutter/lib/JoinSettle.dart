import 'package:flutter/material.dart';
import 'Server.dart';

class JoinSettle extends StatelessWidget {
  final String hostName;
  final joinCodeController = TextEditingController();

  JoinSettle(this.hostName);

  // Read the Settle code that the user types and ask the server to join this
  // user to that Settle session
  void _joinASettlePressed() async {
    var joinSettleCode = joinCodeController.text;

    await Server.joinSettle(joinSettleCode);
  }

  @override
  Widget build(BuildContext context) {
    final settleButtonWidth = 150.0;
    final settleButtonHeight = 45.0;
    final settleButtonTextStyle =
        new TextStyle(fontSize: 16.4, color: Colors.white);
    final joinSettleButton = SizedBox(
      width: settleButtonWidth,
      height: settleButtonHeight,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: Colors.blue,
        onPressed: _joinASettlePressed,
        child: Text('Join a Settle', style: settleButtonTextStyle),
      ),
    );
    final settleButtonMargin = EdgeInsets.all(18.0);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.only(left: 20, top: 15),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
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
