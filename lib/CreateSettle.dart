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

class CreateSettle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    final settleButtonWidth = 180.0;
    final settleButtonHeight = 45.0;
    final settleButtonTextStyle = new TextStyle(fontSize: 16.4,);

    final joinSettleButton = SizedBox(
      width: settleButtonWidth,
      height: settleButtonHeight,
      child: ElevatedButton(
        // onPressed: _joinASettlePressed,
        child: Text('Create this Settle',
          style: settleButtonTextStyle),
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
                  Column( // Settle buttons in the center
                    mainAxisSize: MainAxisSize.min, // Size to only needed space
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text('What are y\'all', style: TextStyle(fontSize: 25),),
                            Text('Settling ?', style: TextStyle(fontSize: 25),),
                          ],
                        ),
                      ),
                      Container(
                        child: RadioButton(),
                      ),
                      Container(
                        child: CheckBox(),
                      ),
                      // CheckboxListTile(
                      //   title: Text("Movies"),
                      //   controlAffinity:
                      //     ListTileControlAffinity.leading,
                      //   value: _customOption,
                      //   onChanged: (bool value) {
                      //     setState(() {
                      //       _customOption = value;
                      //     });
                      //   },
                      //   activeColor: Colors.black,
                      //   checkColor: Colors.grey,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: TextField(
                      //     controller: myController,
                      //   ),
                      // ),
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

/// This is the stateful widget that the main application instantiates.
class CheckBox extends StatefulWidget {
  CheckBox({Key key}) : super(key: key);

  @override
  _CheckBox createState() => _CheckBox();
}

/// This is the private State class that goes with MyStatefulWidget.
class _CheckBox extends State<CheckBox> {
  bool _customOption = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text("Custom"),
      controlAffinity:
        ListTileControlAffinity.leading,
      value: _customOption,
      onChanged: (bool value) {
        setState(() {
          _customOption = value;
        });
      },
      activeColor: Colors.blue,
      checkColor: Colors.black,
    );
  }
}

enum Options { movies, restaurants, alcohol }

/// This is the stateful widget that the main application instantiates.
class RadioButton extends StatefulWidget {
  RadioButton({Key key}) : super(key: key);

  @override
  _RadioButton createState() => _RadioButton();
}

/// This is the private State class that goes with MyStatefulWidget.
class _RadioButton extends State<RadioButton> {
  Options _currentOption = null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Movies'),
          leading: Radio(
            value: Options.movies,
            groupValue: _currentOption,
            onChanged: (Options value) {
              setState(() {
                _currentOption = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Restaurants'),
          leading: Radio(
            value: Options.restaurants,
            groupValue: _currentOption,
            onChanged: (Options value) {
              setState(() {
                _currentOption = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Alcohol'),
          leading: Radio(
            value: Options.alcohol,
            groupValue: _currentOption,
            onChanged: (Options value) {
              setState(() {
                _currentOption = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
