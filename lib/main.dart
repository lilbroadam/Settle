import 'package:flutter/material.dart';
import 'CreateSettle.dart';
import 'JoinSettle.dart';

void main() {
  runApp(SettleApp());
}

class SettleApp extends StatelessWidget {
  // This widget is the root of the app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(
        child: SettleHomePage(title: 'Settle')
      ),
    );
  }
}

class SettleHomePage extends StatefulWidget {
  SettleHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  // From dart.dev: The => expr syntax is a shorthand for { return expr; }
  @override
  _SettleHomePageState createState() => _SettleHomePageState();
}

class _SettleHomePageState extends State<SettleHomePage> {

  void _createASettlePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateSettle()),
    );
  }

  void _joinASettlePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JoinSettle()),
    );
  }

  void _informationPressed() {
    // TODO
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final createSettleButton = ElevatedButton(
        onPressed: _createASettlePressed, child: Text('Create a Settle'));
    final joinSettleButton = ElevatedButton(
        onPressed: _joinASettlePressed, child: Text('Join a Settle'));
    final buttonMargin = EdgeInsets.all(15.0);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: buttonMargin,
                  child: createSettleButton,
                ),
                Container(
                  margin: buttonMargin,
                  child: joinSettleButton,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                icon: Icon(Icons.info),
                tooltip: 'Information about Settle',
                onPressed: _informationPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
