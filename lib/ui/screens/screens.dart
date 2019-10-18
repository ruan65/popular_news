import 'package:clean_news_ai/domain/states/favorite_news_state.dart';
import 'package:clean_news_ai/domain/states/top_news_state.dart';
import 'package:clean_news_ai/domain/store.dart';
import 'package:clean_news_ai/ui/ui_elements/articles_list.dart';
import 'package:clean_news_ai/ui/widgets/title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopNewsScreen extends StatefulWidget {
  TopNewsScreen(Key key) : super(key: key);

  @override
  _TopNewsScreenState createState() => _TopNewsScreenState();
}

class _TopNewsScreenState extends State<TopNewsScreen> {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context);
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      key: widget.key,
      slivers: <Widget>[
        TitleAppBar(title: 'Новости'),
        CupertinoSliverRefreshControl(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 2), () {
              // store.dispatcher.add(Event(type: EventType.refreshTopNewsState, bundle: 'science'));
            });
          },
        ),
        ArticleList(
          stream: store
              .nextState<TopNewsState>(state: store.topNewsState)
              .map((state) => state.articles),
          initialData: store.topNewsState.articles,
        )
      ],
    );
  }
}

class FavoritesNewsScreen extends StatefulWidget {
  FavoritesNewsScreen(Key key) : super(key: key);

  @override
  _FavoritesNewsScreenState createState() => _FavoritesNewsScreenState();
}

class _FavoritesNewsScreenState extends State<FavoritesNewsScreen> {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context);
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      key: widget.key,
      slivers: <Widget>[
        TitleAppBar(title: 'Избранные'),
        CupertinoSliverRefreshControl(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 2), () {
              //     store.dispatcher.add(Event(type: EventType.refreshTopNewsState, bundle: 'science'));
            });
          },
        ),
        ArticleList(
          stream: store
              .nextState<FavoriteNewsState>(state: store.favoriteNewsState)
              .map((state) => state.articles),
          initialData: store.favoriteNewsState.articles,
        )
      ],
    );
  }
}
