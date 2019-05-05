import 'package:clean_news_ai/screens/abstracts/abstract_screen.dart';
import 'package:clean_news_ai/screens/favorites_screen_element/favorites_state.dart';
import 'package:clean_news_ai/ui_elements/list_element/list_item_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'favorites_mutator.dart';

class FavoritesScreenView extends AbstractScreenView {
  FavoritesScreenView(
      {Key key, FavoritesScreenState state, FavoritesScreenMutator mutator})
      : super(key: key, state: state, mutator: mutator);
}

final favoritesScreenView = FavoritesScreenView(
  key: PageStorageKey('favorites'),
  state: favoritesScreenState,
  mutator: favoritesScreenMutator,
);
