import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsStickyHeader extends StatelessWidget {
  final String title;

  const NewsStickyHeader({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                title.substring(0, 1).toUpperCase() + title.substring(1, title.length),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )));
  }
}
