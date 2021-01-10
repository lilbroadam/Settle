import 'package:flutter/material.dart';
import 'package:Settle/LobbyScreen.dart';
import 'DarkThemeProvider.dart';
import 'Server.dart';
import 'Settle.dart';
import 'AppTheme.dart';
import 'app_localizations.dart';

class JoinSettle extends StatefulWidget {
  final String hostName;
  final DarkThemeProvider themeChange;
  JoinSettle(this.hostName, this.themeChange);

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
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LobbyScreen(settle, userName, false, widget.themeChange)),
      );
    } else {
      // TODO popup that the user couldn't be joined
      print('Could not join the user to $joinSettleCode');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final settleButtonWidth = 150.0;
    // final settleButtonHeight = 45.0;
    // final settleButtonTextStyle =
    //     new TextStyle(fontSize: 16.4, color: Colors.white);
    // // final joinSettleButton =
    // // SizedBox(
    // //   width: settleButtonWidth,
    // //   height: settleButtonHeight,
    // //   child: RaisedButton(
    // //     shape: RoundedRectangleBorder(
    // //       borderRadius: BorderRadius.circular(25),
    // //     ),
    // //     color: Colors.blue,
    // //     onPressed: _joinASettlePressed,
    // //     child: Text(AppLocalizations.of(context).translate("joinasettle"),
    // //         style: settleButtonTextStyle),
    // //   ),
    // // );
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
              AppLocalizations.of(context).translate("entercode"),
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
