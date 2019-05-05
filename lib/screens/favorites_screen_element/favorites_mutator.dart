import 'package:clean_news_ai/provider/provider.dart';
import 'package:clean_news_ai/screens/abstracts/abstract_mutator.dart';
import 'package:clean_news_ai/screens/main_screen/main_screen_state.dart';
import 'dart:async';
import 'favorites_state.dart';

class FavoritesScreenMutator extends AbstractMutator {
  FavoritesScreenMutator({FavoritesScreenState state}) : super(state: state);

  @override
  getNews() async {
    state.news.clear();
    state.news.addAll(await provider.getSavedNews());
    state.broadcaster.add(state.news);
  }

}

final favoritesScreenMutator = FavoritesScreenMutator(state: favoritesScreenState);