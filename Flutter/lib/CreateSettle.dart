import 'package:flutter/material.dart';

class CreateSettle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
