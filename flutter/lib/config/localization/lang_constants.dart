import 'package:flutter/material.dart';
import 'package:settle/config/localization/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

// TODO change key from strings into a LocalizedText enum or something similar
// so we can get autocomplete and compilers for keys to prevent typos.
// Ex: getText(contex, LocalizedText.CREATESETTLE_PROMPT);
String? getText(BuildContext context, String key) {
  return AppLocalizations.of(context)!.translate(key);
}
