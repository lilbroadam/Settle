import 'package:Settle/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'DarkThemeProvider.dart';
import 'Settle.dart';
import 'localization/app_localizations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

List<Color> colors = [
  Colors.blue,
  Colors.yellow,
  Colors.red,
  Colors.orange,
  Colors.pink,
  Colors.amber,
  Colors.cyan,
  Colors.purple,
  Colors.brown,
  Colors.teal,
];

List<Widget> cards = List.generate(
  colors.length,
  (int index) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: colors[index],
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/adamoo.jpg'),
            )),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Card number $index',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700)),
                  Padding(padding: EdgeInsets.only(bottom: 8.0)),
                  Text('A short description.',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white)),
                ],
              )),
        ));
  },
);

class SettleScreen extends StatefulWidget {
  final Settle settle;
  final DarkThemeProvider themeChange;

  const SettleScreen(this.settle, this.themeChange);

  @override
  _SettleScreenState createState() => _SettleScreenState(settle);
}

class _SettleScreenState extends State<SettleScreen> {
  Settle settle;
  TCardController _controller = TCardController();

  _SettleScreenState(this.settle);

  List<Widget> buildCards() {
    List<Widget> cards = new List();

    settle.options.forEach((option) {
      cards.add(
        new Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.black,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '$option',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700),
              ),
            )),
      );
    });

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 140),
            TCard(
              size: Size(360, 480),
              cards: buildCards(),
              controller: _controller,
              onForward: (index, info) {
                print(info.direction);
                setState(() {});
              },
              onBack: (index) {
                setState(() {});
              },
              onEnd: () {
                print('end');
              },
            ),
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                NeumorphicButton(
                  onPressed: _controller.back,
                  style: NeumorphicStyle(
                    depth: 2.7,
                    intensity: 0.35,
                    surfaceIntensity: 0.5,
                    lightSource: LightSource.topLeft,
                    shadowLightColor: widget.themeChange.darkTheme
                        ? Colors.white
                        : Colors.black,
                    shadowDarkColor: Colors.grey[900],
                    color: widget.themeChange.darkTheme
                        ? Color(0xff1E1E1E)
                        : Colors.grey[200],
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 35,
                  ),
                ),
                NeumorphicButton(
                  onPressed: _aboutPressed,
                  style: NeumorphicStyle(
                    depth: 2.7,
                    intensity: 0.35,
                    surfaceIntensity: 0.5,
                    lightSource: LightSource.topLeft,
                    shadowLightColor: widget.themeChange.darkTheme
                        ? Colors.white
                        : Colors.black,
                    shadowDarkColor: Colors.grey[900],
                    color: widget.themeChange.darkTheme
                        ? Color(0xff1E1E1E)
                        : Colors.grey[200],
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: Colors.blue,
                    size: 25,
                  ),
                ),
                NeumorphicButton(
                  // onPressed: _controller.forward,
                  onPressed: () {
                    widget.themeChange.darkTheme =
                        !widget.themeChange.darkTheme;
                  },
                  style: NeumorphicStyle(
                    depth: 2.7,
                    intensity: 0.35,
                    surfaceIntensity: 0.5,
                    lightSource: LightSource.topLeft,
                    shadowLightColor: widget.themeChange.darkTheme
                        ? Colors.white
                        : Colors.black,
                    shadowDarkColor: Colors.grey[900],
                    color: widget.themeChange.darkTheme
                        ? Color(0xff1E1E1E)
                        : Colors.grey[200],
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.green,
                    size: 35,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _aboutPressed() {
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
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                AppLocalizations.of(context).translate("soon"),
                style: TextStyle(fontSize: 15),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
            ],
          ),
        );
      },
    );
  }
}
