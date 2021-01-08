import 'package:flutter/material.dart';

import 'app_localizations.dart';

class AppTheme {
  static final settleButtonWidth = 150.0;
  static final settleButtonHeight = 45.0;
  static final settleButtonTextStyle = new TextStyle(
    fontSize: 16.4,
    color: Colors.white,
  );

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: isDarkTheme ? Color(0xff444444) : Colors.white,
      backgroundColor: isDarkTheme ? Color(0xff444444) : Color(0xffF1F5FB),
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
      highlightColor: isDarkTheme ? Color(0xff2C949A) : Color(0xff95F0F5),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Color(0xff1E1E1E) : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    );
  }

  static SizedBox button(BuildContext context, String text, Function fun) {
    return SizedBox(
      width: settleButtonWidth,
      height: settleButtonHeight,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: Colors.blue,
        onPressed: fun,
        child: Text(AppLocalizations.of(context).translate(text),
            style: settleButtonTextStyle),
      ),
    );
  }

  static RaisedButton nextButton(BuildContext context, Function fun) {
    return RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        color: Colors.blue,
        elevation: 5,
        child: Icon(
          Icons.arrow_forward_outlined,
          color: Colors.white,
        ),
        onPressed: fun);
  }
}
