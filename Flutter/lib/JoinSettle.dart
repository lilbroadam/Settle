import 'package:flutter/material.dart';

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
  final String name;

  JoinSettle(this.name);

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    final settleButtonWidth = 150.0;
    final settleButtonHeight = 45.0;
    final settleButtonTextStyle = new TextStyle(
      fontSize: 16.4,
    );

    final joinSettleButton = SizedBox(
      width: settleButtonWidth,
      height: settleButtonHeight,
      child: ElevatedButton(
        // onPressed: _joinASettlePressed,
        onPressed: () {
          // print for testing purposes
          print(name);
        },
        child: Text('Join a Settle', style: settleButtonTextStyle),
      ),
    );
    // final textField =
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
                  Column(
                    // Settle buttons in the center
                    mainAxisSize: MainAxisSize.min, // Size to only needed space
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Enter a',
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              'code to join',
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              'a Settle',
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: myController,
                        ),
                      ),
                      Container(
                        margin: settleButtonMargin,
                        child: joinSettleButton,
                      )
                    ],
                  ),
                  Align(
                    // Info button in the bottom left
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      icon: Icon(Icons.info),
                      iconSize: miscButtonSize,
                      tooltip: 'Information about Settle',
                      // onPressed: _informationPressed,
                    ),
                  ),
                  Align(
                    // Settings button in the bottom right
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
