import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CreateSettle.dart';
import 'DarkThemeProvider.dart';
import 'JoinSettle.dart';
import 'app_localizations.dart';

class NameScreen extends StatefulWidget {
  // final bool darkTheme;
  final DarkThemeProvider themeChange;
  final bool newSession;
  final context;
  NameScreen(this.newSession, this.context, this.themeChange);
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _formKey = GlobalKey<FormState>();

  void _navigate(String name) {
    if (widget.newSession) {
      Navigator.push(
        widget.context,
        MaterialPageRoute(
            builder: (context) => CreateSettle(name, widget.themeChange)),
      );
    } else {
      Navigator.push(
        widget.context,
        MaterialPageRoute(builder: (context) => JoinSettle(name)),
      );
    }
  }

  String getImage() {
    setState(() {});
    return widget.themeChange.darkTheme
        ? 'assets/background-dark.png'
        : 'assets/background.png';
  }

  Widget build(BuildContext context) {
    final myControler = TextEditingController();
    final double width = 55;
    final double height = 50;
    final margin = EdgeInsets.all(18);
    final nextButton = SizedBox(
      width: width,
      height: height,
      child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          color: Colors.blue,
          elevation: 5,
          child: Icon(
            Icons.arrow_forward_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _navigate(myControler.text);
            }
          }),
    );

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(getImage()), fit: BoxFit.cover)),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          elevation: 0,
          leading: IconButton(
            padding: EdgeInsets.only(left: 20, top: 15),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
            tooltip: AppLocalizations.of(context).translate("tipback"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate("getname"),
                      style: GoogleFonts.notoSansKR(fontSize: 25)),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      controller: myControler,
                      textAlign: TextAlign.center,
                      validator: (text) {
                        myControler.text = text.trim();
                        text = text.trim();
                        if (text.isEmpty) {
                          return AppLocalizations.of(context)
                              .translate("invalidname");
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(),
                    ),
                  ),
                  Container(
                    margin: margin,
                    child: nextButton,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
