import 'package:clean_news_ai/provider/provider.dart';
import 'package:clean_news_ai/screens/abstracts/abstract_mutator.dart';
import 'package:clean_news_ai/screens/search_screen_element/search_screen_state.dart';

class SearchScreenMutator extends AbstractMutator {
  SearchScreenMutator({SearchScreenState state}) : super(state: state);

  @override
  getNews() async {
    if (state.news.isNotEmpty) return state.broadcaster.add(state.news);
    state.news.addAll(await provider.getNews(search: true));
    state.broadcaster.add(state.news);
  }
}

final searchScreenMutator = SearchScreenMutator(state: searchScreenState);
