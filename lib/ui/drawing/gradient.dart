import 'package:flutter/material.dart';

class NewsGradient extends StatelessWidget {
  const NewsGradient({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black, Colors.blue])));
  }
}
