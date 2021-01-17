import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization/lang_constants.dart';

class AppTheme {
  static final DarkThemeProvider themeChange = new DarkThemeProvider();
  static final double boxWidth = 55;
  static final double boxHeight = 50;
  static final settleButtonWidth = 150.0;
  static final settleButtonHeight = 45.0;
  static final settleButtonTextStyle = new TextStyle(
    fontSize: 16.4,
    color: Colors.white,
  );

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      primarySwatch: Colors.blue,
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
      highlightColor: isDarkTheme ? Color(0xff2C949A) : Color(0xff95F0F5),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Color(0xff1E1E1E) : Colors.grey[200],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    );
  }

  static bool isDarkTheme() {
    return DarkThemeProvider().darkTheme;
  }

  static SizedBox button(BuildContext context, String text, Function fun) {
    return SizedBox(
      width: settleButtonWidth,
      height: settleButtonHeight,
      child: RaisedButton(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: Colors.blue,
        onPressed: fun,
        child: Text(
          getText(context, text),
          style: settleButtonTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static SizedBox nextButton(BuildContext context, Function fun) {
    return SizedBox(
        width: boxWidth,
        height: boxHeight,
        child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            color: Colors.blue,
            elevation: 5,
            child: Icon(
              Icons.arrow_forward_outlined,
              color: Colors.white,
            ),
            onPressed: fun));
  }

  static RaisedButton rawButton(BuildContext context, String text, Function fun) {
    return RaisedButton(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      color: Colors.blue,
      child: Text(
        getText(context, text),
        style: TextStyle(color: Colors.white),
      ),
      onPressed: fun,
    );
  }

  static Color buttonColor() {
    return themeChange.darkTheme ? Color(0xff5B5B5B) : Colors.white;
  }

  static Color backgroundColor() {
    return themeChange.darkTheme ? Color(0xff1E1E1E) : Colors.white;
  }

  static String namescreenBackgroundURI() {
    return themeChange.darkTheme ? 'assets/background-dark.png' : 'assets/background.png';
  }
}

class DarkThemePreference {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  static bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}
