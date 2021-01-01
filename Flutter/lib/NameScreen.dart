import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CreateSettle.dart';
import 'JoinSettle.dart';

class NameScreen extends StatelessWidget {
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
          color: Colors.white,),
        onPressed: () => _navigate(myControler.text)),
    );    

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Enter your name', 
                    style: GoogleFonts.notoSansKR(fontSize: 25)
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: myControler,
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