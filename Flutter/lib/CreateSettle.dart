import 'package:flutter/material.dart';
import 'Server.dart';

class CreateSettle extends StatelessWidget {

  void _createSettleButtonPressed() async {
    var settleCode = await Server.createSettle();
    if (settleCode != null) {
      print('got settle code: ' + settleCode);
    } else {
      // TODO handle
      print('There was an error creating a Settle');
    }
  }

  @override
  Widget build(BuildContext context) {
    final settleButtonWidth = 180.0;
    final settleButtonHeight = 45.0;
    final settleButtonTextStyle = new TextStyle(fontSize: 16.4,);

    final createSettleButton = SizedBox(
      width: settleButtonWidth,
      height: settleButtonHeight,
      child: ElevatedButton(
        onPressed: _createSettleButtonPressed,
        child: Text('Create this Settle',
          style: settleButtonTextStyle
        ),
      ),
    );


    final settleButtonMargin = EdgeInsets.all(18.0);
    final miscButtonSize = 30.0;

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
                            Text('What is your', style: TextStyle(fontSize: 25),),
                            Text('group Settling?', style: TextStyle(fontSize: 25),),
                          ],
                        ),
                      ),
                      Container(
                        child: RadioButton(),
                      ),
                      Container(
                        child: CheckBox(),
                      ),
                      Container(
                        margin: settleButtonMargin,
                        child: createSettleButton,
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

enum Options { movies, restaurants }

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
      ],
    );
  }
}
