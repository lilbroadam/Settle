import 'package:flutter/material.dart';

class JoinSettle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
