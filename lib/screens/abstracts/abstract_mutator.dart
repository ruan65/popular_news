import 'dart:async';

import 'package:clean_news_ai/provider/provider.dart';
import 'abstract_state.dart';

abstract class AbstractMutator {
  final AbstractState state;
  AbstractMutator(this.state);

  _addNews(theme) async {
    state.cashedArticles.addAll(await provider.getNews(search: false, theme: theme));
    state.broadcaster.add(state.cashedArticles);
  }

  getNews() async {
    //state.broadcaster.add(null);
    state.cashedArticles = {};
    final themes = (await provider.prefs).getStringList('themes') ?? [];
    if (themes.isNotEmpty) {
      await Future.wait(themes.map((theme) {
        return _addNews(theme);
      }));
    } else {
      _addNews('general');
    }
  }

  updateStars({String url}){
    if(state.cashedArticles.containsKey(url)){
      state.cashedArticles[url].liked = !state.cashedArticles[url].liked;
      state.broadcaster.add(state.cashedArticles);
    }
  }
}
