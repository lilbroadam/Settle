import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'widgets/settle_card.dart';
import 'Settle.dart';

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
                settle.submitVote(settleCards[info.cardIndex].title);
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
                FloatingActionButton(
                  heroTag: Text("nope"),
                  // this will be forward and it should indicate user didn't
                  // like it. For demo, it's set to back
                  onPressed: () {
                    _controller.back();
                  },
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: Colors.red),
                ),
                FloatingActionButton(
                  heroTag: Text("about"),
                  mini: true,
                  onPressed: _aboutPressed, // TODO
                  backgroundColor: Colors.white,
                  child: Icon(Icons.info_outline_rounded, color: Colors.blue),
                ),
                FloatingActionButton(
                  heroTag: Text("yep"),
                  onPressed: () {
                    int index = _controller.index;
                    settle.submitVote(settleCards[index].title);
                    _controller.forward();
                  },
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite, color: Colors.green),
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
                "Coming Soon...",
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
