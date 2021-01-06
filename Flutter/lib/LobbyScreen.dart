import 'package:flutter/material.dart';
import 'package:Settle/Animation.dart';
import 'Settle.dart';
import 'app_localizations.dart';

class LobbyScreen extends StatefulWidget {
  final Settle settle;
  final String userName;
  final bool isHost;

  const LobbyScreen(this.settle, this.userName, this.isHost);

  @override
  _LobbyScreen createState() => _LobbyScreen(settle, userName, isHost);
}

class _LobbyScreen extends State<LobbyScreen> {
  final String hostName;
  final bool isHost;
  final bool isCustom;
  final String code;
  final Settle settle;
  final String userName;

  _LobbyScreen(this.settle, this.userName, this.isHost)
      : this.hostName = settle.users.first,
        this.isCustom = settle.customAllowed,
        this.code = settle.settleCode;

  @override
  Widget build(BuildContext context) {
    List<String> guests = [];

    Widget customBox = Column(children: [
      Container(height: 30),
      Text(AppLocalizations.of(context).translate("entercustom"),
          style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: TextEditingController(),
        ),
      )
    ]);

    guests.add('Alejandro');
    guests.add('Rodrigo');
    guests.add('Adam');
    guests.add('Ali');
    guests.add('Alejandro');
    guests.add('Rodrigo');
    guests.add('Adam');
    guests.add('Ali');
    guests.add('Alejandro');
    guests.add('Rodrigo');
    guests.add('Adam');
    guests.add('Ali');
    guests.add('Alejandro');
    guests.add('Rodrigo');
    guests.add('Adam');
    guests.add('Ali');
    guests.add('Alejandro');
    guests.add('Rodrigo');
    guests.add('Adam');
    guests.add('Ali');
    guests.add('Alejandro');
    guests.add('Rodrigo');
    guests.add('Adam');
    guests.add('Ali');

    return Scaffold(
        appBar: new AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0.0,
            title: Text(
                AppLocalizations.of(context).translate("lobbycode") + " $code",
                style: TextStyle(color: Colors.black))),
        body: Center(
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(AppLocalizations.of(context).translate("welcome"),
                  style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
              Text(
                '$userName',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              Container(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.all(10.0),
                            child: scroller(
                                guests,
                                AppLocalizations.of(context)
                                    .translate("lobbyguests"))),
                      ),
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.all(10.0),
                            child: scroller(
                                guests,
                                AppLocalizations.of(context)
                                    .translate("lobbyoptions"))),
                      ),
                    ],
                  )),
              if (settle.customAllowed) customBox,
              Container(height: 75),
              isHost
                  ? standardButton(
                      AppLocalizations.of(context).translate("startsettle"),
                      startSettle)
                  : Column(children: [
                      animation(),
                      Container(height: 50),
                      Text(AppLocalizations.of(context).translate("waithost"),
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center)
                    ])
            ],
          )),
        ));
  }

  void startSettle() {
    print('it works');
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
