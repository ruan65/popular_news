import 'package:clean_news_ai/domain/states/app_state/app_state.dart';
import 'package:clean_news_ai/ui/drawing/gradient.dart';
import 'package:clean_news_ai/ui/screens/top_news/top_news_presenter.dart';
import 'package:clean_news_ai/ui/screens/top_news/top_news_screen.dart';
import 'package:clean_news_ai/ui/ui_elements/bottom_navigation/navigation_app_bar.dart';
import 'package:clean_news_ai/ui/ui_elements/bottom_navigation/navigation_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

import 'favorites/favorites_presenter.dart';
import 'favorites/favorites_screen.dart';

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
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          NewsGradient(),
          TabBarView(controller: _controller, children: <Widget>[
            PresenterProvider<Store<AppState>, TopNewsPresenter>(
              key: ValueKey('topNewsPresenter'),
              child: TopNewsScreen(PageStorageKey('news')),
              presenter: TopNewsPresenter(),
            ),
            PresenterProvider<Store<AppState>, FavoritesPresenter>(
              key: ValueKey('favoritesPresenter'),
              child: FavoritesScreen(PageStorageKey('favorites')),
              presenter: FavoritesPresenter(),
            ),
          ]),
          PresenterProvider<Store<AppState>, NavigationPresenter>(
            key: ValueKey('navigation'),
            presenter: NavigationPresenter(),
            child: NavigationAppBar(
              controller: _controller,
            ),
          )
        ],
      ),
    );
  }
}

const colors = [Colors.purple, Colors.red, Colors.green, Colors.cyan, Colors.amber];
