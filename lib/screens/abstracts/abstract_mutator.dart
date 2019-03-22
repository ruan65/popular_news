import 'dart:async';

import 'package:clean_news_ai/provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'abstract_state.dart';

abstract class AbstractMutator {
  final AbstractState state;
  AbstractMutator(this.state);

  final _prefs = SharedPreferences.getInstance();

  _addNews (theme) async {
    state.cashedData.addAll(await provider.getNews(false, theme));
    state.broadcaster.add(state.cashedData);
  }

  getNews() async {
    //state.broadcaster.add(null);
    state.cashedData = {};
    final themes = (await _prefs).getStringList('themes') ?? [];
    if (themes.isNotEmpty) {
      await Future.wait(themes.map((theme) {
        return _addNews(theme);
      }));
    }
     else {
      _addNews("general");
    }
  }

  updateStars(key) {
    if (state.cashedData.containsKey(key)) {
      state.cashedData[key].liked = !state.cashedData[key].liked;
      state.broadcaster.add(state.cashedData);
    }
  }
}
