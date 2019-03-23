import 'package:clean_news_ai/provider/provider.dart';
import 'package:clean_news_ai/screens/abstracts/abstract_mutator.dart';
import 'favorites_screen_state.dart';

class FavoritesScreenMutator extends AbstractMutator {
  FavoritesScreenMutator(state) : super(state);

  getNews() async {
    state.cashedArticles = {};
    state.broadcaster.add(await provider.getSavedNews());
  }
}

final FavoritesScreenMutator favoritesMutator = FavoritesScreenMutator(favoritesScreenState);
