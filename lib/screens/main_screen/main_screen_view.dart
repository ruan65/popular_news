import 'package:clean_news_ai/screens/abstracts/abstract_screen.dart';
import 'package:clean_news_ai/screens/main_screen/main_screen_mutator.dart';
import 'package:clean_news_ai/ui_elements/list_element/list_item_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main_screen_state.dart';

class MainScreenView extends AbstractScreenView {
  MainScreenView({Key key, MainScreenState state, MainScreenMutator mutator})
      : super(key: key, state: state, mutator: mutator);
}

final mainScreenView = MainScreenView(
  key: PageStorageKey('main'),
  state: mainScreenState,
  mutator: mainScreenMutator,
);
