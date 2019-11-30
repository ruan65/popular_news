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
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: '.SF Pro Display',
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.41,
                  color: Colors.white,
                ),
              ),
            )));
  }
}
