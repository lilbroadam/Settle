import 'package:flutter/material.dart';

class Option {
  Icon icon;
  String title;
  // NOTE: If we want to add a description in the future
  // String subtitle;

  Option({this.icon, this.title});
}

final options = [
  Option(
    icon: Icon(Icons.check_box_outlined, size: 40.0),
    title: 'English',
    // subtitle: 'Add a description ?',
  ),
  Option(
    icon: Icon(Icons.check_box_outlined, size: 40.0),
    title: 'Español',
    // subtitle: 'Add a description ?',
  ),
];
