import 'package:clean_news_ai/provider/provider.dart';
import 'package:clean_news_ai/screens/abstracts/abstract_mutator.dart';
import 'package:clean_news_ai/screens/main_screen/main_screen_state.dart';
import 'dart:async';

class MainScreenMutator extends AbstractMutator {
  MainScreenMutator({MainScreenState state}) : super(state: state);

  @override
  getNews() async {
    if (state.news.isNotEmpty) return state.broadcaster.add(state.news);
    final themes = (await provider.prefs).getStringList('themes') ?? [];
    if (themes.isNotEmpty) {
      await Future.wait(themes.map<Future>((theme) {
        return _addNews(theme: theme);
      }));
    } else {
      _addNews(theme: 'general');
    }
  }

  _addNews({String theme}) async {
    state.news.addAll(await provider.getNews(search: false, theme: theme));
    state.broadcaster.add(state.news);
  }
}

final mainScreenMutator = MainScreenMutator(state: mainScreenState);