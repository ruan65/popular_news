import 'dart:math';

import 'package:clean_news_ai/domain/models/event.dart';
import 'package:clean_news_ai/domain/states/favorite_news_state.dart';
import 'package:clean_news_ai/domain/states/search_news_state.dart';
import 'package:clean_news_ai/domain/states/settings_state.dart';
import 'package:clean_news_ai/domain/states/top_news_state.dart';
import 'package:clean_news_ai/domain/store.dart';
import 'package:clean_news_ai/ui/drawing/gradient.dart';
import 'package:clean_news_ai/ui/screens/screens.dart';
import 'package:clean_news_ai/ui/widgets/navigation_app_bar.dart';
import 'package:clean_news_ai/ui/widgets/title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({Key key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> with TickerProviderStateMixin {
  TabController _controller;
  final store = Store(TopNewsState(), SearchNewsState(), FavoriteNewsState(), SettingsState())
    ..sendEvent(event: Event(type: EventType.refreshTopNewsState, bundle: 'science'))
    ..sendEvent(event: Event(type: EventType.refreshFavoriteNewsState));

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Provider<Store>(
      builder: (ctx) => store,
      child: Scaffold(
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
              CustomScrollView(
                slivers: <Widget>[TitleAppBar(title: 'Новости')],
              ),
            ]),
            NavigationAppBar(
              controller: _controller,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final number = Random().nextInt(4);
            store.sendEvent(event: Event(type: EventType.changeColor, bundle: colors[number]));
          },
        ),
      ),
    );
  }
}

const colors = [Colors.purple, Colors.red, Colors.green, Colors.cyan, Colors.amber];
