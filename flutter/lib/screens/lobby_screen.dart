import 'package:flutter/material.dart';
import 'package:settle/config/localization/lang_constants.dart';
import 'package:settle/config/themes/app_theme.dart';
import 'package:settle/protos/settle.dart';
import 'package:settle/screens/settle_screen.dart';
import 'package:settle/widgets/animation.dart';

class LobbyScreen extends StatefulWidget {
  final Settle? settle;
  final String userName;
  final bool isHost;
  // final DarkThemeProvider themeChange = new DarkThemeProvider();

  const LobbyScreen(this.settle, this.userName, this.isHost);

  @override
  _LobbyScreen createState() => _LobbyScreen(settle!, userName, isHost);
}

class _LobbyScreen extends State<LobbyScreen> {
  final String hostName;
  final bool isHost;
  final bool? isCustom;
  final String? code;
  final Settle settle;
  final String userName;
  var myControler = TextEditingController();
  bool _validate = false;

  _LobbyScreen(this.settle, this.userName, this.isHost)
      : this.hostName = settle.users!.first,
        this.isCustom = settle.customAllowed,
        this.code = settle.settleCode;

  // Call this function when 'Start Settle' is pressed
  void startSettlePressed() async {
    if (isHost) {
      await settle.setState(SettleState.settling);
      print('User started the Settle');
    }

    // Go to the Settle screen
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SettleScreen(settle)
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget customBox = Column(children: [
      Container(height: 30),
      Text(getText(context, "entercustom")!,
          style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextField(
          controller: myControler,
          decoration: InputDecoration(
            errorText: _validate ? getText(context, "invalidcustom") : null,
          ),
        ),
      ),
      AppTheme.button(context, "addoption", () async {
        if (myControler.text.isEmpty) {
          _validate = true;
        } else {
          await settle.addOption(myControler.text);
          // setState(() {});
          myControler = TextEditingController();
          _validate = false;
        }
        setState(() {});
      }),
    ]);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            getText(context, "lobbycode")! + " $code",
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () async {
                  await settle.update();
                  setState(() {});
                  if (settle.settleState == SettleState.settling)
                    startSettlePressed();
                })
          ],
          leading: IconButton(
            padding: EdgeInsets.only(left: 15),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(getText(context, "welcome")!,
                  style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
              Text(
                '$userName',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Column(
                      children: [
                        Text(getText(context, "lobbyguests")!,
                            style: TextStyle(fontSize: 20)),
                        Padding(padding: EdgeInsets.all(3)),
                        Expanded(
                            child: ListView.builder(
                                itemCount: settle.users!.length,
                                itemBuilder: (context, index) {
                                  return _CardsItem(
                                      AppTheme.isDarkTheme(),
                                      str: settle
                                          .users![index % settle.users!.length]);
                                }))
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(3),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Column(
                      children: [
                        Text(
                          getText(context, "lobbyoptions")!,
                          style: TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.all(3),
                        ),
                        Expanded(
                            child: ListView.builder(
                                itemCount: settle.options!.length,
                                itemBuilder: (context, index) {
                                  return _CardsItem(
                                      AppTheme.isDarkTheme(),
                                      str: settle.options![
                                          index % settle.options!.length]);
                                }))
                      ],
                    ),
                  ),
                ],
              ),
              if (settle.customAllowed!) customBox,
              Container(height: 75),
              if (isHost)
                startButton()
              else
                Column(children: [
                  animation(),
                  Container(height: 80),
                  Text(getText(context, "waithost")!,
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center)
                ])
            ],
          )),
        ));
  }

  Widget startButton() {
    return AppTheme.button(context, "startsettle", () {
      startSettlePressed();
    });
  }

  Widget scroller(List<String> l, String name) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            title: Text('$name:', style: TextStyle(fontSize: 22)),
            titleSpacing: 0,
            pinned: true,
            toolbarHeight: 30,
            leading: Container()),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue,
                height: 22,
                child: Text('${l[index]}',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center),
              );
            },
            childCount: l.length,
          ),
        ),
      ],
    );
  }

  Widget standardButton(String text, VoidCallback action) {
    final settleButtonWidth = 150.0;
    final settleButtonHeight = 45.0;
    final settleButtonTextStyle = new TextStyle(
      fontSize: 16.4,
    );
    final settleButton = SizedBox(
      width: settleButtonWidth,
      height: settleButtonHeight,
      child: ElevatedButton(
        onPressed: action,
        child: Text(text, style: settleButtonTextStyle),
      ),
    );
    final settleButtonMargin = EdgeInsets.all(25.0);
    return Container(
      margin: settleButtonMargin,
      child: settleButton,
    );
  }

  Widget animation() {
    return Container(
      width: 10,
      height: 10,
      alignment: Alignment.center,
      child: AutomatedAnimator(
        animateToggle: true,
        doRepeatAnimation: true,
        duration: Duration(seconds: 10),
        buildWidget: (double animationPosition) {
          return WaveLoadingBubble(
            foregroundWaveColor: Color(0xFF6AA0E1),
            backgroundWaveColor: Color(0xFF4D90DF),
            loadingWheelColor: Color(0xFF77AAEE),
            period: animationPosition,
            backgroundWaveVerticalOffset: 90 - animationPosition * 200,
            foregroundWaveVerticalOffset: 90 +
                reversingSplitParameters(
                  position: animationPosition,
                  numberBreaks: 6,
                  parameterBase: 8.0,
                  parameterVariation: 8.0,
                  reversalPoint: 0.75,
                ) -
                animationPosition * 200,
            waveHeight: reversingSplitParameters(
              position: animationPosition,
              numberBreaks: 5,
              parameterBase: 12,
              parameterVariation: 8,
              reversalPoint: 0.75,
            ),
          );
        },
      ),
    );
  }
}

class _CardsItem extends StatelessWidget {
  final String? str;
  final bool isDark;
  const _CardsItem(this.isDark, {Key? key, this.str}) : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
            color: isDark ? Colors.grey[850] : Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: isDark ? Colors.grey[900]! : Colors.grey[500]!,
                  offset: Offset(2, 2),
                  blurRadius: 5,
                  spreadRadius: 1),
              BoxShadow(
                  color: isDark ? Colors.grey[800]! : Colors.white70,
                  offset: Offset(-2, -2),
                  blurRadius: 5,
                  spreadRadius: 1),
            ]),
        child: Text(
          str!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(top: 5),
      ),
    );
  }
}
