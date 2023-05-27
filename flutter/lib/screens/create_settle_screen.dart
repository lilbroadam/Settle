import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:settle/cloud/settle_server/settle_server.dart';
import 'package:settle/config/localization/lang_constants.dart';
import 'package:settle/config/themes/app_theme.dart';
import 'package:settle/protos/settle.dart';
import 'package:settle/screens/lobby_screen.dart';
import 'package:share/share.dart';

typedef void SettleTypePressedCallback();
typedef void CustomOptionsPressedCallback(bool customOptionsAllowed);

class CreateSettleScreen extends StatefulWidget {
  final String hostName;

  CreateSettleScreen(this.hostName);

  @override
  _CreateSettleScreen createState() => _CreateSettleScreen(hostName);
}

class _CreateSettleScreen extends State<CreateSettleScreen> {
  final String hostName;
  bool gotCode = false;
  Settle? settle;
  late SettleTypeMenu settleTypeMenu;

  _CreateSettleScreen(this.hostName) {
    settleTypeMenu = SettleTypeMenu(_onSettleTypePressed);
  }

  // Callback function to call when a Settle Type is clicked in SettleTypeMenu.
  // Mainly for calling setState() so the Create Settle Button can be updated
  // based on the menu selection.
  void _onSettleTypePressed() {
    setState(() {});
  }

  // Call this function when the "Create this Settle" button is pressed.
  // This function will ask the server to create a new Settle.
  Future<Settle?> _onCreateSettlePressed() async {
    // TODO make sure a Settle type is selected, else pop up notification

    settle = await Server.createSettle(hostName,
        settleTypeMenu.selectedSettleType, settleTypeMenu.customOptionsAllowed);

    if (settle == null) {
      // TODO error handling
      return Future<Settle>.value(null);
    }

    return settle;
  }

  Future<void> showPopup() async {
    Widget popupTitleText = Text(getText(context, "getcode")!);
    Widget goToLobbyButton = AppTheme.rawButton(context, "golobby", () {
      if (gotCode) {
        // TODO update Navigator stack so that when user backs out of the
        // lobby, they go back to the home screen instead of this screen
        return Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LobbyScreen(settle, hostName, true)));
      } else {
        return null;
      }
    });
    // TODO build button from theme
    Widget shareSettleCodeButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        backgroundColor: AppTheme.buttonColor(),
      ),
      child: Text(
        getText(context, "sharecopy")!,
      ),
      onPressed: () {
        if (gotCode) {
          Clipboard.setData(ClipboardData(text: settle!.settleCode!));
          Share.share(settle!.settleCode!);
        } else {
          return null;
        }
      },
    );
    Widget settleCodeText = FutureBuilder(
      future: _onCreateSettlePressed(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          settle = snapshot.data as Settle?;
          gotCode = true;
          // TODO get TextStyle from theme
          return Text(settle!.settleCode!, style: TextStyle(fontSize: 19));
        } else {
          return SpinKitDualRing(
            color: Colors.blue, // TODO get color from theme
            size: 30,
            lineWidth: 3,
          );
        }
      },
    );

    // TODO animated_dialog_box is dart3 incompatible. Replace commented code
    // await animated_dialog_box.showScaleAlertBox(
    //   title: Center(child: popupTitleText),
    //   context: context,
    //   firstButton: goToLobbyButton,
    //   secondButton: shareSettleCodeButton,
    //   icon: Icon(
    //     Icons.check,
    //     color: Colors.green,
    //   ),
    //   yourWidget: settleCodeText,
    // );
  }

  @override
  Widget build(BuildContext context) {
    // TODO get AppBar from theme
    Widget createSettleScreenAppBar = AppBar(
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
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
    Widget createSettlePromptText = Text(
      getText(context, "createsettle-prompt")!,
      style: TextStyle(fontSize: 25),
      textAlign: TextAlign.center,
    );
    // TODO build Create Settle Button from theme
    Widget createSettleButton = Container(
      margin: EdgeInsets.all(18.0),
      child: SizedBox(
        width: 180.0,
        height: 45.0,
        child: AppTheme.button(
            context,
            "createthissettle",
            !settleTypeMenu.isSettleTypeSelected
                ? null
                : () async {
                    await showPopup();
                  }),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: createSettleScreenAppBar as PreferredSizeWidget?,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                createSettlePromptText,
                settleTypeMenu,
                createSettleButton,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettleTypeMenu extends StatefulWidget {
  late _SettleTypeMenu _settleTypeMenu;
  final SettleTypePressedCallback _callback;

  SettleTypeMenu(this._callback, {Key? key}) : super(key: key) {
    _settleTypeMenu = _SettleTypeMenu(_callback);
  }

  get isSettleTypeSelected => _settleTypeMenu.isSettleTypeSelected;
  get customOptionsAllowed => _settleTypeMenu.customOptionsAllowed;
  get selectedSettleType => _settleTypeMenu.selectedSettleType;

  @override
  _SettleTypeMenu createState() => _settleTypeMenu;
}

class _SettleTypeMenu extends State<SettleTypeMenu> {
  final SettleTypePressedCallback _callback;
  SettleType? _currentSettleType;
  bool? _customOptionsAllowed = false;

  _SettleTypeMenu(this._callback);

  get isSettleTypeSelected => _currentSettleType != null;
  get customOptionsAllowed => _customOptionsAllowed;
  get selectedSettleType => _currentSettleType;

  // Call when a [ListTile] is clicked to change the Settle type
  void onSettleTypeChanged(SettleType? settleType) {
    // If a custom Settle is selected, enable Allow Custom Options button
    if (settleType == SettleType.custom) {
      _customOptionsAllowed = true;
    }

    setState(() => _currentSettleType = settleType);
    _callback();
  }

  // Call when the [CheckboxListTile] for allowing custom options is clicked
  void onCustomOptionsAllowedChanged(bool? value) {
    setState(() => _customOptionsAllowed = value);
    _callback();
  }

  ListTile makeSettleTypeRadioButton(String text, SettleType settleType) {
    return ListTile(
      title: Text(getText(context, text)!),
      leading: Radio(
        value: settleType,
        groupValue: _currentSettleType,
        // activeColor: ___, // TODO get from theme
        onChanged: (dynamic settleType) => onSettleTypeChanged(settleType),
      ),
    );
  }

  CheckboxListTile makeSettleTypeCheckBox(String text) {
    return CheckboxListTile(
      title: Text(getText(context, text)!),
      controlAffinity: ListTileControlAffinity.leading,
      value: _customOptionsAllowed,
      onChanged: (value) => onCustomOptionsAllowedChanged(value),
      activeColor: Colors.blue, // TODO get from theme
      checkColor: Colors.black, // TODO get from theme
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        makeSettleTypeRadioButton("settletype-movies", SettleType.movies),
        makeSettleTypeRadioButton(
            "settletype-restaurants", SettleType.restaurants),
        makeSettleTypeRadioButton("settletype-customonly", SettleType.custom),
        makeSettleTypeCheckBox("settletype-allowcustom"),
      ],
    );
  }
}
