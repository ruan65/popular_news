
import 'search_screen_mutator.dart';
import 'search_screen_state.dart';
import 'package:clean_news_ai/screens/abstracts/abstract_view.dart';

class SearchScreenView extends AbstractScreenView {
  SearchScreenView(mutator, title, state) : super(mutator, title, state, true);
}
final searchScreenView = SearchScreenView(searchMutator, "Search", state);