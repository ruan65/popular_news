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
    return MaterialApp(
        // localizationsDelegates: [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        // ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: lightTheme ? Brightness.light : Brightness.dark,
        ),
        home: Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.black, Colors.blue]))),
            RootElement()
          ],
        ));
  }
}

final newsAppState = NewsAppState();
