import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:settle/config/localization/app_localizations.dart';
import 'package:settle/config/localization/lang_constants.dart';
import 'package:settle/config/localization/language.dart';
import 'package:settle/config/themes/app_theme.dart';
import 'package:settle/protos/settle.dart';
import 'package:settle/screens/name_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SettleHomePage extends StatefulWidget {
  SettleHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

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
    // Locale _locale = await setLocale(language.languageCode);
    // SettleApp.setLocale(context, _locale);

    setLocale(language.languageCode);
  }

  // Called when 'Create a Settle' button is pressed
  void _createASettlePressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NameScreen(true, context),
      ),
    );
  }

  // Called when 'Join a Settle' button is pressed
  void _joinASettlePressed() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => NameScreen(false, context)));
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
                subtitle: Text(getText(context, "version")! + " 1.0"),
              ),
              ListTile(
                leading: Icon(MdiIcons.github),
                title: Text(getText(context, "git")!),
                subtitle: Text(getText(context, "gitsub")!),
                onTap: () async {
                  var url = 'https://github.com/lilbroadam/Settle';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
              ListTile(
                leading: Icon(MdiIcons.email),
                title: Text(getText(context, "contact")!),
                subtitle: Text(getText(context, "contactsub")!),
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
              ListTile(
                  leading: Icon(
                    MdiIcons.currencyUsd,
                    size: 25,
                  ),
                  title: Text(getText(context, "support")!),
                  subtitle: Text(getText(context, "supportsub")!),
                  onTap: () {}),
            ],
          ),
        );
      },
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
                    title: Text(getText(context, "lang")!),
                    subtitle: Text(getText(context, "langsub")!),
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

  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settle'),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 30,
          fontFamily: 'Open Sans',
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple, //change color
      ),
      drawer: Drawer(
          child: Container(
        color: Colors.deepPurpleAccent, //change color
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(child: Text('PUT SETTLE LOGO HERE')),
            ),
            ListTile(
              leading: Icon(Linecons.cog),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                _settingMenu();
              },
            ),
            ListTile(
              leading: Icon(Typicons.info),
              title: Text(
                'Info',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                _informationPressed();
              },
            )
          ],
        ),
      )),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //styling for quote
          Text(
            'Tired of Indecision?',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Pacifico', // Custom font family
              color: Colors.purple, // Text color
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          SizedBox(height: 60), // Add some vertical spacing between the buttons
          ElevatedButton(
            onPressed: () {
              _createASettlePressed();
            },
            //styling for first button
            child: Text('Create a Settle'),
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(fontSize: 24),
              ),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.deepPurple),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          SizedBox(height: 30), // Add some vertical spacing between the buttons
          ElevatedButton(
            onPressed: () {
              _joinASettlePressed();
            },
            //styling for second button
            child: Text('Join a Settle'),
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(fontSize: 24),
              ),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.deepPurple),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
