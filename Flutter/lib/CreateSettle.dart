import 'package:Settle/AppTheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_dialog_box/animated_dialog_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'DarkThemeProvider.dart';
import 'LobbyScreen.dart';
import 'Server.dart';
import 'Settle.dart';
import 'app_localizations.dart';

typedef void SettleTypePressedCallback(SettleType settleType);
typedef void CustomOptionsPressedCallback(bool customOptionsAllowed);

class CreateSettle extends StatefulWidget {
  final String hostName;
  final DarkThemeProvider themeChange;
  CreateSettle(this.hostName, this.themeChange);

  @override
  _CreateSettle createState() => _CreateSettle(hostName, themeChange);
}

class _CreateSettle extends State<CreateSettle> {
  final String hostName;
  final DarkThemeProvider themeChange;
  SettleType _settleType;
  bool _customOptionsAllowed = false;
  bool gotCode = false;
  Settle settle;

  _CreateSettle(this.hostName, this.themeChange);

  // Call this function when a Settle type is pressed.
  void _settleTypePressed(SettleType settleType) {
    _settleType = settleType;

    if (settleType == SettleType.custom) {
      // TODO make checkbox checked if 'Custom choices only' is clicked
    }

    setState(() {});
  }

  // Call this function when the "custom options allowed" checkbox is pressed.
  void _customOptionsPressed(bool customOptionsAllowed) {
    _customOptionsAllowed = customOptionsAllowed;
    setState(() {});
  }

  // Call this function when the "Create this Settle" button is pressed.
  // This function will ask the server to create a new Settle.
  Future<Settle> _createSettleButtonPressed() async {
    settle =
        await Server.createSettle(hostName, _settleType, _customOptionsAllowed);

    if (settle == null) {
      // TODO error handling
      return Future<Settle>.value(null);
    }

    return settle;
  }

  // Return true if at least one option has been selected.
  bool _isAnOptionSelected() {
    return (_settleType != null) || _customOptionsAllowed;
  }

  Future<void> showPopup() async {
    await animated_dialog_box.showScaleAlertBox(
        title: Center(
            child: Text(AppLocalizations.of(context).translate("getcode"))),
        context: context,
        firstButton: AppTheme.rawButton(context, "golobby", () {
          if (gotCode) {
            return Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LobbyScreen(settle, hostName, true)),
            );
          } else {
            return null;
          }
        }),
        secondButton: RaisedButton(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          color: themeChange.darkTheme ? Color(0xff5B5B5B) : Colors.white,
          child: Text(
            AppLocalizations.of(context).translate("sharecopy"),
            style: TextStyle(
                color: themeChange.darkTheme ? Colors.white : Colors.black),
          ),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: settle.settleCode));
            Share.share(settle.settleCode);
          },
        ),
        icon: Icon(
          Icons.check,
          color: Colors.green,
        ),
        yourWidget: Container(
          child: FutureBuilder(
            future: _createSettleButtonPressed(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                settle = snapshot.data;
                gotCode = true;
                return Text(settle.settleCode,
                    style: GoogleFonts.notoSansKR(fontSize: 19));
              } else {
                return SpinKitDualRing(
                  color: Colors.blue,
                  size: 30,
                  lineWidth: 3,
                );
              }
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final settleButtonWidth = 180.0;
    final settleButtonHeight = 45.0;
    final createSettleButton = SizedBox(
      width: settleButtonWidth,
      height: settleButtonHeight,
      child: AppTheme.button(
          context,
          "createthissettle",
          !_isAnOptionSelected()
              ? null
              : () async {
                  await showPopup();
                }),
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
            Column(
              mainAxisSize: MainAxisSize.min, // Size to only needed space
              children: <Widget>[
                Text('What is your', style: TextStyle(fontSize: 25)),
                Text('group Settling?', style: TextStyle(fontSize: 25)),
                RadioButton(_settleTypePressed),
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
      controlAffinity: ListTileControlAffinity.leading,
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
  final SettleTypePressedCallback callback;
  RadioButton(this.callback, {Key key}) : super(key: key);

  @override
  _RadioButton createState() => _RadioButton(callback);
}

class _RadioButton extends State<RadioButton> {
  final SettleTypePressedCallback callback;
  SettleType _currentOption;

  _RadioButton(this.callback);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(AppLocalizations.of(context).translate("movies")),
          leading: Radio(
            value: SettleType.movies,
            groupValue: _currentOption,
            onChanged: (SettleType value) {
              setState(() => _currentOption = value);
              callback(value);
            },
          ),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).translate("rest")),
          leading: Radio(
            value: SettleType.restaurants,
            groupValue: _currentOption,
            onChanged: (SettleType value) {
              setState(() => _currentOption = value);
              callback(value);
            },
          ),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).translate("customonly")),
          leading: Radio(
              value: SettleType.custom,
              groupValue: _currentOption,
              onChanged: (SettleType value) {
                setState(() => _currentOption = value);
                callback(value);
              }),
        ),
      ],
    );
  }
}
