import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_localizations.dart';

const String LAGUAGE_CODE = 'languageCode';
const String ENGLISH = 'en';
const String SPANISH = 'es';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, 'US');
    case SPANISH:
      return Locale(SPANISH, "SP");
    default:
      return Locale(ENGLISH, 'US');
  }
}

String getText(BuildContext context, String key) {
  return AppLocalizations.of(context).translate(key);
}
