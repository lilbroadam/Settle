import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CreateSettle.dart';
import 'JoinSettle.dart';

class NameScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final bool newSession;
  final context;
  NameScreen(this.newSession, this.context);

  void _navigate(String name) {
    if (newSession) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreateSettle(name)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JoinSettle(name)),
      );
    }
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(color: Colors.white)),
          color: Colors.blue,
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
              image: AssetImage('assets/background.png'), fit: BoxFit.cover)),
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
            tooltip: "Back",
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
                  Text('Enter your name',
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
                          return "Please enter a valid name";
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
