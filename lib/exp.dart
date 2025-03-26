import 'package:flutter/material.dart';

class Exp extends StatefulWidget {
  @override
  _ExpState createState() => _ExpState();
}

class _ExpState extends State<Exp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Text('hi'),
      Container(
        height: 100,
        width: 100,
        color: Colors.red,
      )
    ]));
  }
}
