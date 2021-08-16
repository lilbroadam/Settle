import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:settle/config/localization/lang_constants.dart';
import 'package:settle/config/themes/app_theme.dart';
import 'package:settle/protos/settle.dart';
import 'package:settle/screens/result_screen.dart';
import 'package:settle/widgets/settle_card.dart';
import 'package:tcard/tcard.dart';

class SettleScreen extends StatefulWidget {
  final Settle settle;

  const SettleScreen(this.settle);

  @override
  _SettleScreenState createState() => _SettleScreenState(settle);
}

class _SettleScreenState extends State<SettleScreen> {
  Settle settle;
  List<SettleCard> settleCards = List();
  TCardController _controller = TCardController();

  _SettleScreenState(this.settle) {
    settle.options.forEach((option) {
      settleCards.add(SettleCard(option));
    });
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
              cards: settleCards,
              controller: _controller,
              onForward: (index, info) {
                print(info.direction);
                if (info.direction == SwipDirection.Right)
                  settle.submitVote(settleCards[info.cardIndex].title);
                setState(() {});
              },
              onBack: (index) {
                setState(() {});
              },
              onEnd: () {
                // TODO: go to result screen
                print('end');
                settle.userFinished();
                Navigator.push(
                    // Go to results screen
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultScreen(settle)));
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
                    shadowLightColor: AppTheme.isDarkTheme()
                        ? Colors.white
                        : Colors.black,
                    shadowDarkColor: Colors.grey[900],
                    color: AppTheme.isDarkTheme()
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
                    shadowLightColor: AppTheme.isDarkTheme()
                        ? Colors.white
                        : Colors.black,
                    shadowDarkColor: Colors.grey[900],
                    color: AppTheme.isDarkTheme()
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
                  onPressed: () {
                    int index = _controller.index;
                    settle.submitVote(settleCards[index].title);
                    _controller.forward();
                  },
                  style: NeumorphicStyle(
                    depth: 2.7,
                    intensity: 0.35,
                    surfaceIntensity: 0.5,
                    lightSource: LightSource.topLeft,
                    shadowLightColor: AppTheme.isDarkTheme()
                        ? Colors.white
                        : Colors.black,
                    shadowDarkColor: Colors.grey[900],
                    color: AppTheme.isDarkTheme()
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
                getText(context, "soon"),
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
