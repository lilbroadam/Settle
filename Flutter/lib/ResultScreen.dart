import 'package:flutter/material.dart';
import 'Settle.dart';

class ResultScreen extends StatefulWidget {

  final Settle settle;

  ResultScreen(this.settle);

  @override
  _ResultScreen createState() => _ResultScreen(settle);

}

class _ResultScreen extends State<ResultScreen> {

  Settle settle;

  _ResultScreen(this.settle);

  @override
  Widget build(BuildContext context) {
    Widget result;
    if (settle.result == null) {
      result = Text('Waiting for this\nSettle to finish...',
        style: TextStyle(color: Colors.black, fontSize: 30)
      );
    } else {
      result = Text('Your group\nSettled on\n${settle.result}!',
        style: TextStyle(color: Colors.black, fontSize: 30)
      );
    }

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.refresh),
            onPressed: () async {
              await settle.update();
              setState(() {});
            }
          )
        ],
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(18.0),
                child: result
              ),
            ],
          ),
        ),
      ),
    );
  }
}
