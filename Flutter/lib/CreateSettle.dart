import 'package:flutter/material.dart';
import 'Server.dart';

enum DefaultOptions { movies, restaurants }
typedef void DefaultOptionPressedCallback(DefaultOptions defaultOption);
typedef void CustomOptionsPressedCallback(bool customOptionsAllowed);


class CreateSettle extends StatefulWidget {
  @override
  _CreateSettle createState() => _CreateSettle();
}

class _CreateSettle extends State<CreateSettle> {

  DefaultOptions _defaultOption;
  bool _customOptionsAllowed = false;

  // Call this function when a default option is pressed.
  void _defaultOptionPressed(DefaultOptions defaultOption) {
    _defaultOption = defaultOption;
    setState((){});
  }

  // Call this function when the "custom options allowed" checkbox is pressed.
  void _customOptionsPressed(bool customOptionsAllowed) {
    _customOptionsAllowed = customOptionsAllowed;
    setState((){});
  }

  // Call this function when the "Create this Settle" button is pressed.
  // This function will ask the server to create a new Settle.
  void _createSettleButtonPressed() async {
    var settleCode = await Server.createSettle();
    if (settleCode != null) {
      print('got settle code: ' + settleCode);
    } else {
      // TODO handle
      print('There was an error creating a Settle');
    }
  }

  // Return true if at least one option has been selected.
  bool _isAnOptionSelected() {
    return (_defaultOption != null) || _customOptionsAllowed;
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
        // Only enable this button when at least 1 option has been selected
        onPressed: _isAnOptionSelected() ? _createSettleButtonPressed : null,
        child: Text('Create this Settle', style: settleButtonTextStyle),
      ),
    );
    final settleButtonMargin = EdgeInsets.all(18.0);

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
                      Text('What is your', style: TextStyle(fontSize: 25)),
                      Text('group Settling?', style: TextStyle(fontSize: 25)),
                      RadioButton(_defaultOptionPressed),
                      CheckBox('Allow custom choices', _customOptionsPressed),
                      Container(
                        margin: settleButtonMargin,
                        child: createSettleButton,
                      )
                    ],
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


class CheckBox extends StatefulWidget {
  final String buttonTitle;
  final CustomOptionsPressedCallback callback;
  
  CheckBox(this.buttonTitle, this.callback, {Key key}) : super(key: key);

  @override
  _CheckBox createState() => _CheckBox(buttonTitle, callback);
}

class _CheckBox extends State<CheckBox> {
  final String buttonTitle;
  final CustomOptionsPressedCallback callback;
  bool _customOption = false;
  
  _CheckBox(this.buttonTitle, this.callback);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(buttonTitle),
      controlAffinity:
        ListTileControlAffinity.leading,
      value: _customOption,
      onChanged: (bool value) {
        setState(() => _customOption = value);
        callback(value);
      },
      activeColor: Colors.blue,
      checkColor: Colors.black,
    );
  }
}


class RadioButton extends StatefulWidget {
  final DefaultOptionPressedCallback callback;
  RadioButton(this.callback, {Key key}) : super(key: key);

  @override
  _RadioButton createState() => _RadioButton(callback);
}

class _RadioButton extends State<RadioButton> {
  final DefaultOptionPressedCallback callback;
  DefaultOptions _currentOption;

  _RadioButton(this.callback);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Movies'),
          leading: Radio(
            value: DefaultOptions.movies,
            groupValue: _currentOption,
            onChanged: (DefaultOptions value) {
              setState(() => _currentOption = value);
              callback(value);
            },
          ),
        ),
        ListTile(
          title: const Text('Restaurants'),
          leading: Radio(
            value: DefaultOptions.restaurants,
            groupValue: _currentOption,
            onChanged: (DefaultOptions value) {
              setState(() => _currentOption = value);
              callback(value);
            },
          ),
        ),
      ],
    );
  }
}
