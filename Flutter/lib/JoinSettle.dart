import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'Server.dart';

class SettleApp extends StatelessWidget {
  // This widget is the root of the app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class JoinSettle extends StatelessWidget {
  final joinCodeController = TextEditingController();

  // Read the Settle code that the user types and ask the server to join this
  // user to that Settle session
  void _joinASettlePressed() async {
    var joinSettleCode = joinCodeController.text;

    final http.Response response = await Server.joinSettle(joinSettleCode);
    if (response.statusCode == 200) {
      print('it worked');
    } else {
      print('it didn\'t work');
    }
  }

  @override
  Widget build(BuildContext context) {
    final settleButtonWidth = 150.0;
    final settleButtonHeight = 45.0;
    final settleButtonTextStyle = new TextStyle(fontSize: 16.4,);

    final joinSettleButton = SizedBox(
      width: settleButtonWidth,
      height: settleButtonHeight,
      child: ElevatedButton(
        onPressed: _joinASettlePressed,
<<<<<<< Updated upstream
        child: Text('Join a Settle',
          style: settleButtonTextStyle),
=======
        child: Text('Join a Settle', style: settleButtonTextStyle),
>>>>>>> Stashed changes
      ),
    );
    final settleButtonMargin = EdgeInsets.all(18.0);
    final miscButtonSize = 30.0;

    /**
     * The home screen is made of an expanded stack that takes up the entire
     * screen and draws widgets in the center of the screen by default. The
     * Settle buttons are drawn in a column in the center of the stack/screen,
     * the info button is drawn in the bottom left of the stack/screen, and the
     * settings button is drawn in the bottom right of the stack/screen.
     */
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Column( // Settle buttons in the center
                    mainAxisSize: MainAxisSize.min, // Size to only needed space
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text('Enter a'),
                            Text('code to join'),
                            Text('a Settle'),
                          ],
                        ),
                      ),
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
                  Align( // Info button in the bottom left
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      icon: Icon(Icons.info),
                      iconSize: miscButtonSize,
                      tooltip: 'Information about Settle',
                      // onPressed: _informationPressed,
                    ),
                  ),
                  Align( // Settings button in the bottom right
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.settings),
                      iconSize: miscButtonSize,
                      tooltip: 'Settle settings',
                      // onPressed: _settingsPressed,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
