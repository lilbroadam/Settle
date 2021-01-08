import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';
import 'DarkThemeProvider.dart';
import 'NameScreen.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(SettleApp());
}

class SettleApp extends StatefulWidget {
  _SettleAppState createState() => _SettleAppState();
}

class _SettleAppState extends State<SettleApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  // This widget is the root of the app.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            localizationsDelegates: [
              // ... app-specific localization delegate[s] here
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''), // English, no country code
              const Locale('es', ''), // Arabic, no country code
            ],
            localeResolutionCallback: (locale, suportedLocales) {
              for (var suportedLocale in suportedLocales) {
                if (suportedLocale.languageCode == locale.languageCode
                      && suportedLocale.countryCode == locale.countryCode) {
                  return suportedLocale;
                }
              }
              // Change to:
              // index 0 == English
              // index 1 == Spanish
              // We'll later add buttons to chnage language from the app
              return suportedLocales.elementAt(0);
            },
            title: 'Settle',
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: SettleHomePage(title: 'Settle'),
          );
        },
      ),
    );
  }
}

class SettleHomePage extends StatefulWidget {
  SettleHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettleHomePageState createState() => _SettleHomePageState();
}

class _SettleHomePageState extends State<SettleHomePage> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
      await themeChangeProvider.darkThemePreference.getTheme();
  }

  // Called when 'Create a Settle' button is pressed
  void _createASettlePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          final themeChange = Provider.of<DarkThemeProvider>(context);
          return NameScreen(true, context, themeChange);
        }
      ),
    );
  }

  // Called when 'Join a Settle' button is pressed
  void _joinASettlePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          final themeChange = Provider.of<DarkThemeProvider>(context);
          return NameScreen(false, context, themeChange);
        }
      ),
    );
  }

  // Called when the information button is pressed
  void _informationPressed() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (builder) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ModalDrawerHandle(
                  handleColor: Colors.black38,
                  handleWidth: 35,
                ),
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("Settle"),
                subtitle: Text(
                  AppLocalizations.of(context).translate("version") + " 1.0"
                ),
              ),
              Material(
                child: ListTile(
                  leading: Icon(MdiIcons.github),
                  title: Text(AppLocalizations.of(context).translate("git")),
                  subtitle:
                      Text(AppLocalizations.of(context).translate("gitsub")),
                  onTap: () async {
                    const url = "https://github.com/lilbroadam/Settle";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              ),
              Material(
                child: ListTile(
                  leading: Icon(MdiIcons.email),
                  title:
                    Text(AppLocalizations.of(context).translate("contact")),
                  subtitle: Text(
                    AppLocalizations.of(context).translate("contactsub")),
                  onTap: () async {
                    const emailAdrees = "settleitapplication@gmail.com";
                    const subject = "Client Request";
                    const url = 'mailto:$emailAdrees?subject=$subject';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              ),
              Material(
                child: ListTile(
                  leading: Icon(
                    MdiIcons.currencyUsd,
                    size: 25,
                  ),
                  title:
                    Text(AppLocalizations.of(context).translate("support")),
                  subtitle: Text(
                    AppLocalizations.of(context).translate("supportsub")),
                  onTap: () {}
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // Called when the settings button is pressed
  void _settingsPressed() {
    // TODO
  }

  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final settleButtonWidth = 150.0;
    final settleButtonHeight = 45.0;
    final settleButtonTextStyle = new TextStyle(
      fontSize: 16.4,
      color: Colors.white,
    );
    final createSettleButton = SizedBox(
      width: settleButtonWidth,
      height: settleButtonHeight,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: Colors.blue,
        onPressed: _createASettlePressed,
        child: Text(AppLocalizations.of(context).translate("createsettle"),
            style: settleButtonTextStyle),
      ),
    );
    final joinSettleButton = SizedBox(
      width: settleButtonWidth,
      height: settleButtonHeight,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: Colors.blue,
        onPressed: _joinASettlePressed,
        child: Text(AppLocalizations.of(context).translate("joinsettle"),
            style: settleButtonTextStyle),
      ),
    );
    final settleButtonMargin = EdgeInsets.all(18.0);
    final miscButtonSize = 30.0;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: themeChange.darkTheme
                        ? Icon(
                            Icons.brightness_3,
                            color: themeChange.darkTheme
                              ? Colors.blueAccent
                              : Colors.grey[850],
                          )
                        : Icon(
                            Icons.wb_sunny,
                            color: themeChange.darkTheme
                              ? Colors.blueAccent
                              : Colors.grey[850],
                          ),
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          themeChange.darkTheme = !themeChange.darkTheme;
                        });
                      },
                    ),
                  ),
                  Column(
                    // Settle buttons in the center
                    mainAxisSize: MainAxisSize.min, // Size to only needed space
                    children: <Widget>[
                      Container(
                        margin: settleButtonMargin,
                        child: createSettleButton,
                      ),
                      Container(
                        margin: settleButtonMargin,
                        child: joinSettleButton,
                      ),
                    ],
                  ),
                  Align(
                    // Info button in the bottom left
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      icon: Icon(Icons.info),
                      iconSize: miscButtonSize,
                      tooltip:
                        AppLocalizations.of(context).translate("settleinfo"),
                      onPressed: _informationPressed,
                    ),
                  ),
                  Align(
                    // Settings button in the bottom right
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.settings),
                      iconSize: miscButtonSize,
                      tooltip:
                        AppLocalizations.of(context).translate("setting"),
                      onPressed: _settingsPressed,
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

class Styles {
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
}
