import 'package:clean_news_ai/provider/provider.dart';
import 'search_screen_state.dart';
import 'package:clean_news_ai/screens/abstracts/abstract_mutator.dart';

class SearchScreenMutator extends AbstractMutator {
  SearchScreenMutator(state) : super(state);

  getNews() async {
    state.cashedArticles = {};
    state.cashedArticles.addAll(await provider.getNews(search: true));
    state.broadcaster.add(state.cashedArticles);
  }
}

final searchMutator = SearchScreenMutator(searchScreenState);
