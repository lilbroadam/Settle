import 'import_all.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(SettleApp());
}

class SettleApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _SettleAppState state = context.findAncestorStateOfType<_SettleAppState>();
    state.setLocale(locale);
  }

  _SettleAppState createState() => _SettleAppState();
}

class _SettleAppState extends State<SettleApp> {
  Locale _locale;
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
                if (suportedLocale.languageCode == locale.languageCode &&
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

  void _changeLang(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    SettleApp.setLocale(context, _locale);
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

  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final settleButtonMargin = EdgeInsets.all(18.0);
    final miscButtonSize = 30.0;

    return Scaffold(
      backgroundColor: themeChange.darkTheme ? Colors.black : Colors.grey[200],
      appBar: AppBar(
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
                tooltip: AppLocalizations.of(context).translate("tipback"),
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
            margin: EdgeInsets.only(left: 5, right: 5),
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
            margin: EdgeInsets.only(left: 5, right: 5),
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
                            FontAwesome5.moon,
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
                  IconButton(
                    icon: Icon(
                      Linecons.cog,
                      size: 35,
                      color: Colors.lightBlue[400],
                    ),
                    iconSize: miscButtonSize,
                    tooltip: AppLocalizations.of(context).translate("setting"),
                    // onPressed: _settingsPressed,
                    // onPressed: () {
                    //   _changeLang(Language.es);
                    // },
                    onPressed: _settingMenu,
                    // () {
                    //   PopupMenuButton(
                    //     elevation: 3,
                    //     initialValue: Language.languageList().first,
                    //     // onSelected: _select,
                    //     itemBuilder: (BuildContext context) {
                    //       return Language.languageList().map((Language l) {
                    //         return PopupMenuItem(
                    //           value: l,
                    //           child: Text(l.name),
                    //         );
                    //       }).toList();
                    //     },
                    //   );
                    // },
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  void _settingMenu() {
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
              Material(
                child: PopupMenuButton(
                  offset: Offset(1, 0),
                  child: ListTile(
                    leading: Icon(MdiIcons.earth),
                    title: Text("Language"),
                    subtitle: Text("Change the app's language"),
                  ),
                  elevation: 3,
                  initialValue: Language.languageList().first,
                  onSelected: _changeLang,
                  itemBuilder: (BuildContext context) {
                    return Language.languageList().map((Language l) {
                      return PopupMenuItem(
                        value: l,
                        child: Text(l.name),
                      );
                    }).toList();
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("More features..."),
                subtitle: Text("Coming soon..."),
              ),
            ],
          ),
        );
      },
    );
  }
}
