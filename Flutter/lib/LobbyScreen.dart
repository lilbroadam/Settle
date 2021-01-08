import 'package:flutter/material.dart';
import 'app_localizations.dart';
import 'Animation.dart';
import 'SettleScreen.dart';
import 'Settle.dart';

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
  var myControler = TextEditingController();
  bool _validate = false;

  _LobbyScreen(this.settle, this.userName, this.isHost)
    : this.hostName = settle.users.first,
      this.isCustom = settle.customAllowed,
      this.code = settle.settleCode;

  // Call this function when 'Start Settle' is pressed
  void startSettlePressed() async {
    await settle.setState(SettleState.settling);
    print('User started the Settle');
    
    // Go to the Settle screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettleScreen(settle)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget customBox = Column(
      children: [
        Container(height: 30),
        Text('Enter your custom options', style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: myControler,
            decoration: InputDecoration(
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
            ),
          ),
        ), 
        RaisedButton(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: BorderSide(color: Colors.white)),
          color: Colors.blue,
          child: Icon(
            Icons.arrow_forward_outlined,
            color: Colors.white,
          ),
          onPressed: () async {
            if (myControler.text.isEmpty) {
              _validate = true;
            } else {
              await settle.addOption(myControler.text);
              myControler = TextEditingController();
              _validate = false;
            }
            setState((){});
          },
        )]
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate("lobbycode") + " $code",
            style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.refresh), 
            onPressed: () async {await settle.update();setState((){});}
          )
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
              Text(
                AppLocalizations.of(context).translate("welcome"),
                style: TextStyle(fontSize: 30), textAlign: TextAlign.center
              ),
              Text(
                '$userName',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20),
              ),
              Container(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: scroller(settle.users, "Guests")
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: scroller(settle.options, "Options")
                      ),
                    )
                  ],
                )
              ),
              if (settle.customAllowed) customBox,
              Container(height: 75),
              if (isHost)
                startButton()
              else
                Column(
                  children: [
                    animation(),
                    Container(height: 50),
                    Text(AppLocalizations.of(context).translate("waithost"),
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center
                    )
                  ]
                )
            ],
          )
        ),
      )
    );
  }

  Widget startButton() {
    return SizedBox(
      width: 150,
      height: 45,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettleScreen(settle)),
          );
        },
        child: Text(
          AppLocalizations.of(context).translate("startsettle"),
          style: TextStyle(fontSize: 16.4, color: Colors.white),
        ),
      )
    );
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
          leading: Container()
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue,
                height: 22,
                child: Text('${l[index]}',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center
                ),
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
