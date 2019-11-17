import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:clean_news_ai/ui/drawing/gradient.dart';
import 'package:clean_news_ai/ui/favorites/favorites_screen.dart';
import 'package:clean_news_ai/ui/top_news/top_news_presenter.dart';
import 'package:clean_news_ai/ui/top_news/top_news_screen.dart';
import 'package:clean_news_ai/ui/widgets/navigation_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

import '../favorites/favorites_presenter.dart';

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
              child: TopNewsScreen(PageStorageKey('news')),
              presenter: TopNewsPresenter(),
            ),
            //TopNewsScreen(PageStorageKey('news3')),
            PresenterProvider<Store<AppState>, FavoritesPresenter>(
              child: FavoritesScreen(
                PageStorageKey('favorites'),
              ),
              presenter: FavoritesPresenter(),
            ),
            //  TopNewsScreen(PageStorageKey('news4'))
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
