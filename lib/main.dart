import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'root_element.dart';

bool lightTheme = false;

main() async {
  final prefs = SharedPreferences.getInstance();
  lightTheme = (await prefs).getBool("t") ?? false;
  runApp(NewsApp());
}

class NewsApp extends StatefulWidget {
  createState() => newsAppState;
}

class NewsAppState extends State<NewsApp> {
  build(context) {
    return CupertinoApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: lightTheme ? Brightness.light : Brightness.dark,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: RootElement(),
      ),
    );
  }
}

final newsAppState = NewsAppState();
