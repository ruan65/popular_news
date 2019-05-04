import 'package:clean_news_ai/screens/abstracts/abstract_view.dart';
import 'package:clean_news_ai/provider/provider.dart';
import 'package:flutter/material.dart';

class FavoritesScreenView extends AbstractScreenView {
  FavoritesScreenView({Key key}) : super(key: key);
  getNews() async {
    cashedArticles.clear();
    broadcaster.add(await provider.getSavedNews());
  }
}
