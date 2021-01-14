import 'package:flutter/material.dart';
import 'localization/app_localizations.dart';

class AppTheme {
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
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
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
          AppLocalizations.of(context).translate(text),
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

  static RaisedButton rawButton(
      BuildContext context, String text, Function fun) {
    return RaisedButton(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      color: Colors.blue,
      child: Text(
        AppLocalizations.of(context).translate(text),
        style: TextStyle(color: Colors.white),
      ),
      onPressed: fun,
    );
  }

  static SizedBox neumorphicButton() {
    return SizedBox(
      child: Container(
          width: 100,
          height: 100,
          child: Icon(
            Icons.android,
            size: 80,
          ),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[500],
                    offset: Offset(5, 5),
                    blurRadius: 15,
                    spreadRadius: 1),
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, -5),
                    blurRadius: 5,
                    spreadRadius: 1),
              ])),
    );
  }

  static SizedBox neumorphicButton2(
    double width,
    double height,
    double size,
    Color c,
    Function fun,
    bool isDark,
  ) {
    return SizedBox(
      child: Container(
          width: width,
          height: height,
          child: IconButton(
            icon: Icon(
              Icons.favorite,
              color: c,
              size: size,
            ),
            onPressed: fun,
          ),
          decoration: BoxDecoration(
              color: isDark ? Colors.grey[850] : Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: isDark ? Colors.grey[900] : Colors.grey[500],
                    offset: Offset(5, 5),
                    blurRadius: 15,
                    spreadRadius: 1),
                BoxShadow(
                    color: isDark ? Colors.grey[900] : Colors.white,
                    offset: Offset(-5, -5),
                    blurRadius: 5,
                    spreadRadius: 1),
              ])),
    );
  }
}
