import 'package:clean_news_ai/ui_elements/empty_box.dart';
import 'package:clean_news_ai/ui_elements/list_element/list_item_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clean_news_ai/ui_elements/search_bar_element/search_widget.dart';
import 'dart:async';
import 'package:clean_news_ai/provider/provider.dart';

class AbstractScreenView extends StatefulWidget {
  final bool isSearchScreen;
  final Map cashedArticles = {};

  AbstractScreenView({Key key, this.isSearchScreen}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AbstractScreenViewState();
  }

  updateStars({String url}) {
    if (cashedArticles.containsKey(url)) {
      cashedArticles[url].liked = !cashedArticles[url].liked;
      broadcaster.add(cashedArticles);
    }
  }

  getNews() async {
    cashedArticles.clear();
    final themes = (await provider.prefs).getStringList('themes') ?? [];
    if (themes.isNotEmpty) {
      await Future.wait(themes.map((theme) {
        return _addNews(theme);
      }));
    } else {
      _addNews('general');
    }
  }

  _addNews(theme) async {
    cashedArticles.addAll(await provider.getNews(search: false, theme: theme));
    broadcaster.add(cashedArticles);
  }
}

StreamController broadcaster;

class AbstractScreenViewState extends State<AbstractScreenView> {
  ScrollController scrollController;

  @override
  void dispose() {
    broadcaster?.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    broadcaster = StreamController.broadcast();
    widget.getNews();
    scrollController = ScrollController();
  }

  build(context) {
    return StreamBuilder(
        stream: broadcaster?.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data.values.map<Widget>((element) {
                return ListItemView(
                  key: ValueKey(element.url),
                  name: element.source["name"],
                  url: element.url,
                  title: element.title,
                  publishedAt: element.publishedAt,
                  urlToImage: element.urlToImage,
                  liked: element.liked,
                );
              }).toList(),
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: CupertinoActivityIndicator(
                radius: 14.0,
              ),
            );
          }
        });
  }

  scrollToTop() {
    scrollController.jumpTo(0.0);
  }
}
