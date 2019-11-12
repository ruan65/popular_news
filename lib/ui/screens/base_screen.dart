import 'package:clean_news_ai/ui/drawing/gradient.dart';
import 'package:clean_news_ai/ui/screens/screens.dart';
import 'package:clean_news_ai/ui/widgets/navigation_app_bar.dart';
import 'package:clean_news_ai/ui/widgets/title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({Key key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          NewsGradient(),
          TabBarView(controller: _controller, children: <Widget>[
            TopNewsScreen(PageStorageKey('news')),
            CustomScrollView(
              slivers: <Widget>[TitleAppBar(title: 'Поиск')],
            ),
            FavoritesNewsScreen(PageStorageKey('favorites')),
            SettingsScreen(
              PageStorageKey('settings'),
            ),
          ]),
          NavigationAppBar(
            controller: _controller,
          )
        ],
      ),
    );
  }
}

const colors = [Colors.purple, Colors.red, Colors.green, Colors.cyan, Colors.amber];
