import 'package:clean_news_ai/ui/drawing/gradient.dart';
import 'package:clean_news_ai/ui/favorites/favorites_screen.dart';
import 'package:clean_news_ai/ui/top_news/top_news_screen.dart';
import 'package:clean_news_ai/ui/widgets/navigation_app_bar.dart';
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
      key: ValueKey('rootScreen'),
      body: Stack(
        key: ValueKey('rootStack'),
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          NewsGradient(
            key: ValueKey('backgroudGradient'),
          ),
          TabBarView(controller: _controller, children: <Widget>[
            TopNewsScreen(PageStorageKey('news')),
            FavoritesScreen(PageStorageKey('favorites')),
            TopNewsScreen(PageStorageKey('news3')),
            TopNewsScreen(PageStorageKey('news4'))
          ]),
          NavigationAppBar(
            key: ValueKey('navBar'),
            controller: _controller,
          )
        ],
      ),
    );
  }
}

const colors = [Colors.purple, Colors.red, Colors.green, Colors.cyan, Colors.amber];
