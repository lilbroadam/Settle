import 'package:flutter/material.dart';
import 'Server.dart';
import 'package:Settle/Animation.dart';


class LobbyScreen extends StatefulWidget {
  final String hostName;
  final bool isHost;
  final bool isCustom;
  final String code;

  const LobbyScreen(this.hostName, this.isHost, this.isCustom, this.code);

  @override
  _LobbyScreen createState() => _LobbyScreen(hostName, isHost, isCustom, code);
}

class _LobbyScreen extends State<LobbyScreen> {
  final String hostName;
  final bool isHost;
  final bool isCustom;
  final String code;

  _LobbyScreen(this.hostName, this.isHost, this.isCustom, this.code);

  @override
  Widget build(BuildContext context) {
    List <String> guests = [];

    Widget customBox = Column(
      children: [
        Container(height: 30),
        Text('Enter your custom options', style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
          controller: TextEditingController(),
        ),
      )]
    );

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
        title: Text('Lobby Code: $code', style: TextStyle(color: Colors.black)),
        leading: Container()
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Welcome', style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
              Text('$hostName', style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
              Container(
                height: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      // height: 250,
                      width: 180,
                      child: scroller(guests, "Guests")
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0), 
                      // height: 250,
                      width: 180,
                      child: scroller(guests, "Options")),
                ],)
              ),
              if (isCustom)
                customBox,
              Container(height: 100),
              isHost ? standardButton('Start Settling', startSettle) : Column(children: [animation(), Container(height: 50), Text('Waiting on Host', style: TextStyle(fontSize: 15), textAlign: TextAlign.center)])]
          ,)
        ),
      )
    );
  }

  void startSettle(){
    print('it works');
  }

  Widget scroller(List<String> l, String name){
    return CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('$name:', style: TextStyle(fontSize: 22)),
            titleSpacing: 0,
            pinned: true,
            toolbarHeight: 30,
            leading: Container()
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue,
                  height: 22,
                  child: Text('${l[index]}', style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
                );
              },
              childCount: l.length,
            ),
          ),
        ],
      );
  }

  Widget standardButton (String text, VoidCallback action){
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

  Widget animation(){
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


