import 'package:clean_news_ai/provider/provider.dart';
import 'package:clean_news_ai/screens/abstracts/abstract_mutator.dart';
import 'favorites_screen_state.dart';

class FavoritesScreenMutator extends AbstractMutator {
  FavoritesScreenMutator(state) : super(state);

  getNews() async {
    state.cashedData = await provider.getSavedNews();
    state.broadcaster.add(state.cashedData);
  }
}

final favoritesMutator = FavoritesScreenMutator(state);
