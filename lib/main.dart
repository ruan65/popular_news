import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'root_element.dart';

main() async {
  // final prefs = SharedPreferences.getInstance();
  // lightTheme = (await prefs).getBool("t") ?? false;
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: RootWidget()));
}

class RootWidget extends StatelessWidget {
  build(context) {
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
          ..init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black, Colors.blueAccent]))),
          RootBody()
        ],
      ),
    );
  }
}
