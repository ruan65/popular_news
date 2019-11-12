import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/event_enum.dart';
import 'package:clean_news_ai/domain/states/favorites_state.dart';
import 'package:clean_news_ai/domain/states/settings_state.dart';
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
                .propertyStream<Map<String, Article>>('news')
                .map((articles) => articles.values.toList()))
      ],
    );
  }
}

class FavoritesNewsScreen extends StatelessWidget {
  FavoritesNewsScreen(Key key) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of(context);
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      key: key,
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
                .propertyStream<Map<String, Article>>('news')
                .map((articles) => articles.values.toList()))
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  SettingsScreen(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of(context);
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      key: key,
      slivers: <Widget>[
        TitleAppBar(title: 'Настройки'),
        SliverToBoxAdapter(
          child: StreamBuilder(
            initialData: store.getState<SettingsState>().theme,
            stream: store.getState<SettingsState>().propertyStream('theme'),
            builder: (ctx, snapshot) {
              return Text(snapshot.data);
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('science'),
                onPressed: () {
                  store.dispatchEvent<SettingsState>(
                      event: Event.sideEffect(bundle: 'science', type: EventType.changeTheme));
                },
              ),
              RaisedButton(
                child: Text('sport'),
                onPressed: () {
                  store.dispatchEvent<SettingsState>(
                      event: Event.sideEffect(bundle: 'sport', type: EventType.changeTheme));
                },
              ),
              RaisedButton(
                child: Text('general'),
                onPressed: () {
                  store.dispatchEvent<SettingsState>(
                      event: Event.sideEffect(bundle: 'general', type: EventType.changeTheme));
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
