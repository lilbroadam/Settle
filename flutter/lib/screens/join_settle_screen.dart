import 'package:flutter/material.dart';
import 'package:settle/cloud/settle_server/settle_server.dart';
import 'package:settle/config/localization/lang_constants.dart';
import 'package:settle/config/themes/app_theme.dart';
import 'package:settle/protos/settle.dart';
import 'package:settle/screens/lobby_screen.dart';

class JoinSettle extends StatefulWidget {
  final String hostName;

  JoinSettle(this.hostName);

  @override
  _JoinSettle createState() => _JoinSettle(hostName);
}

class _JoinSettle extends State<JoinSettle> {
  final String userName;
  final joinCodeController = TextEditingController();

  _JoinSettle(this.userName);

  void _joinASettlePressed() async {
    var joinSettleCode = joinCodeController.text;

    Settle settle = await Server.joinSettle(userName, joinSettleCode);
    if (settle != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LobbyScreen(settle, userName, false)));
    } else {
      // TODO popup that the user couldn't be joined
      print('Could not join the user to $joinSettleCode');
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Text(
              getText(context, "entercode"),
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: joinCodeController,
              ),
            ),
            Container(
              margin: settleButtonMargin,
              child:
                  AppTheme.button(context, "joinasettle", _joinASettlePressed),
            )
          ],
        ),
      ),
    );
  }
}
