import 'package:clean_news_ai/domain/models/news_article.dart';
import 'package:clean_news_ai/domain/states/favorites_state.dart';
import 'package:clean_news_ai/domain/states/top_news_state.dart';
import 'package:clean_news_ai/ui/ui_elements/articles_list.dart';
import 'package:clean_news_ai/ui/widgets/title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

class TopNewsScreen extends StatefulWidget {
  TopNewsScreen(Key key) : super(key: key);

  @override
  _TopNewsScreenState createState() => _TopNewsScreenState();
}

class _TopNewsScreenState extends State<TopNewsScreen> {
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of(context);
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      key: widget.key,
      slivers: <Widget>[
        TitleAppBar(title: 'Новости'),
        CupertinoSliverRefreshControl(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 2), () {});
          },
        ),
        ArticleList(
            initialData: store.getState<TopNewsState>().news.values.toList(),
            stream: store
                .getState<TopNewsState>()
                .propertyStream<Map<String, ArticleModel>>('news')
                .map((articles) => articles.values.toList()))
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
    final store = StoreProvider.of(context);
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
            initialData: store.getState<FavoritesState>().news.values.toList(),
            stream: store
                .getState<FavoritesState>()
                .propertyStream<Map<String, ArticleModel>>('news')
                .map((articles) => articles.values.toList()))
      ],
    );
  }
}
