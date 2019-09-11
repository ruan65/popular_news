import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationAppBar extends StatelessWidget {
  const NavigationAppBar({Key key, this.controller}) : super(key: key);
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: TabBar(
          indicator: BoxDecoration(
            color: Colors.transparent,
          ),
          controller: controller,
          tabs: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(CupertinoIcons.time),
            ),
            Icon(CupertinoIcons.search),
            Icon(CupertinoIcons.book),
            Icon(CupertinoIcons.gear),
          ],
        ),
      ),
    );
  }
}
