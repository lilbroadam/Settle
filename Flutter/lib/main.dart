import 'package:Settle/AppTheme.dart';
// import 'package:Settle/SettleScreen.dart';
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
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

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
                if (suportedLocale.languageCode == locale.languageCode &&
                    suportedLocale.countryCode == locale.countryCode) {
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
            theme: AppTheme.themeData(themeChangeProvider.darkTheme, context),
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
      MaterialPageRoute(builder: (context) {
        final themeChange = Provider.of<DarkThemeProvider>(context);
        return NameScreen(true, context, themeChange);
      }),
    );
  }

  // Called when 'Join a Settle' button is pressed
  void _joinASettlePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        final themeChange = Provider.of<DarkThemeProvider>(context);
        return NameScreen(false, context, themeChange);
      }),
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
                    AppLocalizations.of(context).translate("version") + " 1.0"),
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
                    onTap: () {}),
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
    final settleButtonMargin = EdgeInsets.all(18.0);
    final miscButtonSize = 30.0;

    return Scaffold(
      appBar: AppBar(
        // title: Align(
        //   alignment: Alignment.center,
        //   child: Text(
        //     "Home",
        //     textAlign: TextAlign.center,
        //   ),
        // ),
        actions: [
          Row(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Home",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(63),
              ),
              IconButton(
                icon: Icon(
                  FontAwesome5.share_alt,
                  color: themeChange.darkTheme ? Colors.blue : Colors.black,
                  size: 20,
                ),
                // tooltip: AppLocalizations.of(context).translate("tipback"),
                onPressed: () {},
              )
            ],
          )
        ],
        backgroundColor: themeChange.darkTheme ? Colors.black : Colors.white,
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Container(
            decoration: BoxDecoration(
                color: themeChange.darkTheme ? Color(0xff1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(25)),
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Column(
                          // Settle buttons in the center
                          mainAxisSize:
                              MainAxisSize.min, // Size to only needed space
                          children: <Widget>[
                            Container(
                              margin: settleButtonMargin,
                              child: AppTheme.button(context, "createsettle",
                                  _createASettlePressed),
                            ),
                            Container(
                              margin: settleButtonMargin,
                              child: AppTheme.button(
                                  context, "joinsettle", _joinASettlePressed),
                            ),
                            // AppTheme.neumorphicButton2(
                            // 70, 70, Colors.grey[300], _createASettlePressed),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Container(
            decoration: BoxDecoration(
                color: themeChange.darkTheme ? Color(0xff1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(25)),
            child: SizedBox(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      Typicons.info,
                      size: 33,
                      color: Colors.lightBlue[400],
                    ),
                    iconSize: miscButtonSize,
                    tooltip:
                        AppLocalizations.of(context).translate("settleinfo"),
                    onPressed: _informationPressed,
                  ),
                  IconButton(
                    icon: themeChange.darkTheme
                        ? Icon(
                            Icons.brightness_3,
                            color: themeChange.darkTheme
                                ? Colors.lightBlue[400]
                                : Colors.grey[850],
                            size: 30,
                          )
                        : Icon(
                            FontAwesome5.lightbulb,
                            color: themeChange.darkTheme
                                ? Colors.lightBlue[400]
                                : Colors.yellow[800],
                          ),
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        themeChange.darkTheme = !themeChange.darkTheme;
                      });
                    },
                  ),
                  // Settings button in the bottom right
                  IconButton(
                    icon: Icon(
                      Linecons.cog,
                      size: 35,
                      color: Colors.lightBlue[400],
                    ),
                    iconSize: miscButtonSize,
                    tooltip: AppLocalizations.of(context).translate("setting"),
                    onPressed: _settingsPressed,
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
