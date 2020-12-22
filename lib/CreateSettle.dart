import 'package:flutter/material.dart';

class CreateSettle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      // appBar: AppBar(
      //   title: Text("Create a Settle"),
      // ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Created Settle!'),
          ),
        ),
      ),
    );
  }
}
