import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:settle/config/localization/app_localizations.dart';
import 'package:settle/config/localization/lang_constants.dart';
import 'package:settle/config/themes/app_theme.dart';
import 'package:settle/screens/home_screen.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  // TODO add debug settings that can make the development process easier
  // such as auto-filling a name on the name screen or starting the app on
  // a certain screen.

  // TODO add a splash screen whose background can match the app theme

  runApp(SettleApp());
}

class SettleApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _SettleAppState state = context.findAncestorStateOfType<_SettleAppState>()!;
    state.setLocale(locale);
  }

  _SettleAppState createState() => _SettleAppState();
}

class _SettleAppState extends State<SettleApp> {
  Locale? _locale;
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return MaterialApp(
            locale: _locale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('es', 'SP'),
            ],
            localeResolutionCallback: (locale, suportedLocales) {
              for (var suportedLocale in suportedLocales) {
                if (suportedLocale.languageCode == locale!.languageCode &&
                    suportedLocale.countryCode == locale.countryCode) {
                  return suportedLocale;
                }
              }
              return suportedLocales.first;
            },
            title: 'Settle',
            theme: AppTheme.themeData(themeChangeProvider.darkTheme, context),
            home: SettleHomePage(title: 'Settle'),
          );
        },
      ),
    );
  }
}
