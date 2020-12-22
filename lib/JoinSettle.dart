import 'package:flutter/material.dart';

class JoinSettle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Second Route"),
        // ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Joined Settle!'),
          ),
        ),
      ),
    );
  }
}
