import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleAppBar extends StatefulWidget {
  final TabController controller;
  final String title;

  const TitleAppBar({this.controller, this.title});

  @override
  _TitleAppBarState createState() => _TitleAppBarState();
}

class _TitleAppBarState extends State<TitleAppBar> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
        border: null,
        backgroundColor: Colors.transparent,
        transitionBetweenRoutes: true,
        largeTitle: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ));
  }
}
