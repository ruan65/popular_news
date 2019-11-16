import 'package:clean_news_ai/domain/states/favorites_state.dart';
import 'package:clean_news_ai/domain/states/search_news_state.dart';
import 'package:clean_news_ai/domain/states/settings_state.dart';
import 'package:clean_news_ai/domain/states/top_news_state.dart';
import 'package:osam/domain/state/base_state.dart';

// ignore: must_be_immutable
class AppState extends BaseState<AppState> {
  final topNewsState = TopNewsState();
  final favoritesState = FavoritesState();
  final searchState = SearchState();
  final settingsState = SettingsState();

  @override
  List<Object> get props => [topNewsState, favoritesState, searchState, settingsState];
}
