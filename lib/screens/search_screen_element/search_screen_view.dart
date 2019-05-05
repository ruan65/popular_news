import 'package:clean_news_ai/screens/abstracts/abstract_screen.dart';
import 'package:clean_news_ai/screens/search_screen_element/search_screen_mutator.dart';
import 'package:clean_news_ai/screens/search_screen_element/search_screen_state.dart';
import 'package:clean_news_ai/ui_elements/list_element/list_item_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreenView extends AbstractScreenView {
  SearchScreenView(
      {Key key, SearchScreenState state, SearchScreenMutator mutator})
      : super(key: key, state: state, mutator: mutator);
}

final searchScreenView = SearchScreenView(
  key: PageStorageKey('search'),
  state: searchScreenState,
  mutator: searchScreenMutator,
);
