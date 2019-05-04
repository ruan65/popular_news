import 'package:flutter/material.dart';
import 'package:clean_news_ai/provider/provider.dart';
import 'package:clean_news_ai/screens/abstracts/abstract_view.dart';

class SearchScreenView extends AbstractScreenView {
  SearchScreenView({Key key}) : super(key: key);

  getNews() async {
    cashedArticles.clear();
    cashedArticles.addAll(await provider.getNews(search: true));
    broadcaster.add(cashedArticles);
  }
}
